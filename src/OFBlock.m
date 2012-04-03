/*
 * Copyright (c) 2008, 2009, 2010, 2011, 2012
 *   Jonathan Schleifer <js@webkeks.org>
 *
 * All rights reserved.
 *
 * This file is part of ObjFW. It may be distributed under the terms of the
 * Q Public License 1.0, which can be found in the file LICENSE.QPL included in
 * the packaging of this file.
 *
 * Alternatively, it may be distributed under the terms of the GNU General
 * Public License, either version 2 or 3, which can be found in the file
 * LICENSE.GPLv2 or LICENSE.GPLv3 respectively included in the packaging of this
 * file.
 */

#include "config.h"

#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include <assert.h>

#if defined(OF_APPLE_RUNTIME) && !defined(__OBJC2__)
# import <objc/runtime.h>
#elif defined(OF_OBJFW_RUNTIME)
# import "runtime-private.h"
#endif

#import "OFBlock.h"

#import "OFAllocFailedException.h"
#import "OFInitializationFailedException.h"
#import "OFNotImplementedException.h"

#ifdef OF_ATOMIC_OPS
# import "atomic.h"
#endif
#ifdef OF_THREADS
# import "threading.h"
#endif

typedef struct of_block_byref_t of_block_byref_t;
struct of_block_byref_t {
	Class isa;
	of_block_byref_t *forwarding;
	int flags;
	int size;
	void (*byref_keep)(void *dest, void *src);
	void (*byref_dispose)(void*);
};

enum {
	OF_BLOCK_HAS_COPY_DISPOSE = (1 << 25),
	OF_BLOCK_HAS_CTOR	  = (1 << 26),
	OF_BLOCK_IS_GLOBAL	  = (1 << 28),
	OF_BLOCK_HAS_STRET	  = (1 << 29),
	OF_BLOCK_HAS_SIGNATURE	  = (1 << 30),
};
#define OF_BLOCK_REFCOUNT_MASK \
	~(OF_BLOCK_HAS_COPY_DISPOSE | OF_BLOCK_HAS_CTOR | OF_BLOCK_IS_GLOBAL | \
	OF_BLOCK_HAS_STRET | OF_BLOCK_HAS_SIGNATURE)

enum {
	OF_BLOCK_FIELD_IS_OBJECT =   3,
	OF_BLOCK_FIELD_IS_BLOCK	 =   7,
	OF_BLOCK_FIELD_IS_BYREF	 =   8,
	OF_BLOCK_FIELD_IS_WEAK	 =  16,
	OF_BLOCK_BYREF_CALLER	 = 128,
};

@protocol RetainRelease
- retain;
- (void)release;
@end

#ifndef OF_OBJFW_RUNTIME
enum objc_abi_class_info {
	OBJC_CLASS_INFO_CLASS	  = 0x01,
	OBJC_CLASS_INFO_METACLASS = 0x02
};
#endif

#if defined(OF_OBJFW_RUNTIME)
extern void __objc_exec_class(struct objc_abi_module*);

/* Begin of ObjC module */
static struct objc_abi_class _NSConcreteStackBlock_metaclass = {
	(struct objc_abi_class*)(void*)"OFBlock", "OFBlock", "OFStackBlock", 8,
	OBJC_CLASS_INFO_METACLASS, sizeof(struct objc_abi_class), NULL, NULL
};

struct objc_abi_class _NSConcreteStackBlock = {
	&_NSConcreteStackBlock_metaclass, "OFBlock", "OFStackBlock", 8,
	OBJC_CLASS_INFO_CLASS, sizeof(of_block_literal_t), NULL, NULL
};

static struct objc_abi_class _NSConcreteGlobalBlock_metaclass = {
	(struct objc_abi_class*)(void*)"OFBlock", "OFBlock", "OFGlobalBlock", 8,
	OBJC_CLASS_INFO_METACLASS, sizeof(struct objc_abi_class), NULL, NULL
};

struct objc_abi_class _NSConcreteGlobalBlock = {
	&_NSConcreteGlobalBlock_metaclass, "OFBlock", "OFGlobalBlock",
	8, OBJC_CLASS_INFO_CLASS, sizeof(of_block_literal_t), NULL, NULL
};

static struct objc_abi_class _NSConcreteMallocBlock_metaclass = {
	(struct objc_abi_class*)(void*)"OFBlock", "OFBlock", "OFMallocBlock", 8,
	OBJC_CLASS_INFO_METACLASS, sizeof(struct objc_abi_class), NULL, NULL
};

struct objc_abi_class _NSConcreteMallocBlock = {
	&_NSConcreteMallocBlock_metaclass, "OFBlock", "OFMallocBlock",
	8, OBJC_CLASS_INFO_CLASS, sizeof(of_block_literal_t), NULL, NULL
};

static struct {
	unsigned int unknown;
	struct objc_abi_selector *sel_refs;
	uint16_t cls_def_cnt, cat_def_cnt;
	void *defs[4];
} symtab = {
	0, NULL, 3, 0,
	{
		&_NSConcreteStackBlock, &_NSConcreteGlobalBlock,
		&_NSConcreteMallocBlock, NULL
	}
};

static struct objc_abi_module module = {
	8, sizeof(module), NULL, (struct objc_abi_symtab*)&symtab
};

static void __attribute__((constructor))
constructor(void)
{
	__objc_exec_class(&module);
}
/* End of ObjC module */
#elif defined(OF_APPLE_RUNTIME) && !defined(__OBJC2__)
struct class {
	struct class *isa, *super_class;
	const char *name;
	long version, info, instance_size;
	struct ivar_list *ivars;
	struct method_list **methodLists;
	struct cache *cache;
	struct protocol_list *protocols;
	const char *ivar_layout;
	struct class_ext *ext;
};

struct class _NSConcreteStackBlock;
struct class _NSConcreteGlobalBlock;
struct class _NSConcreteMallocBlock;
#else
extern void *_NSConcreteStackBlock;
extern void *_NSConcreteGlobalBlock;
extern void *_NSConcreteMallocBlock;
#endif

static struct {
	Class isa;
} alloc_failed_exception;

#if !defined(OF_ATOMIC_OPS) && defined(OF_THREADS)
# define NUM_SPINLOCKS 8	/* needs to be a power of 2 */
# define SPINLOCK_HASH(p) ((uintptr_t)p >> 4) & (NUM_SPINLOCKS - 1)
static of_spinlock_t spinlocks[NUM_SPINLOCKS];
#endif

void*
_Block_copy(const void *block_)
{
	of_block_literal_t *block = (of_block_literal_t*)block_;

	if (block->isa == (Class)&_NSConcreteStackBlock) {
		of_block_literal_t *copy;

		if ((copy = malloc(block->descriptor->size)) == NULL) {
			alloc_failed_exception.isa =
			    [OFAllocFailedException class];
			@throw (OFAllocFailedException*)&alloc_failed_exception;
		}
		memcpy(copy, block, block->descriptor->size);

		copy->isa = (Class)&_NSConcreteMallocBlock;
		copy->flags++;

		if (block->flags & OF_BLOCK_HAS_COPY_DISPOSE)
			block->descriptor->copy_helper(copy, block);

		return copy;
	}

	if (block->isa == (Class)&_NSConcreteMallocBlock) {
#if defined(OF_ATOMIC_OPS)
		of_atomic_inc_int(&block->flags);
#else
		unsigned hash = SPINLOCK_HASH(block);

		assert(of_spinlock_lock(&spinlocks[hash]));
		block->flags++;
		assert(of_spinlock_unlock(&spinlocks[hash]));
#endif
	}

	return block;
}

void
_Block_release(const void *block_)
{
	of_block_literal_t *block = (of_block_literal_t*)block_;

	if (block->isa != (Class)&_NSConcreteMallocBlock)
		return;

#ifdef OF_ATOMIC_OPS
	if ((of_atomic_dec_int(&block->flags) & OF_BLOCK_REFCOUNT_MASK) == 0) {
		if (block->flags & OF_BLOCK_HAS_COPY_DISPOSE)
			block->descriptor->dispose_helper(block);

		free(block);
	}
#else
	unsigned hash = SPINLOCK_HASH(block);

	assert(of_spinlock_lock(&spinlocks[hash]));
	if ((--block->flags & OF_BLOCK_REFCOUNT_MASK) == 0) {
		assert(of_spinlock_unlock(&spinlocks[hash]));

		if (block->flags & OF_BLOCK_HAS_COPY_DISPOSE)
			block->descriptor->dispose_helper(block);

		free(block);

		return;
	}
	assert(of_spinlock_unlock(&spinlocks[hash]));
#endif
}

void
_Block_object_assign(void *dst_, const void *src_, const int flags_)
{
	int flags = flags_ & (OF_BLOCK_FIELD_IS_BLOCK |
	    OF_BLOCK_FIELD_IS_OBJECT | OF_BLOCK_FIELD_IS_BYREF);

	if (src_ == NULL)
		return;

	if (flags_ & OF_BLOCK_BYREF_CALLER)
		return;

	switch (flags) {
	case OF_BLOCK_FIELD_IS_BLOCK:
		*(of_block_literal_t**)dst_ = _Block_copy(src_);
		break;
	case OF_BLOCK_FIELD_IS_OBJECT:
		*(id*)dst_ = [(id)src_ retain];
		break;
	case OF_BLOCK_FIELD_IS_BYREF:;
		of_block_byref_t *src = (of_block_byref_t*)src_;
		of_block_byref_t **dst = (of_block_byref_t**)dst_;

		if ((src->flags & OF_BLOCK_REFCOUNT_MASK) == 0) {
			if ((*dst = malloc(src->size)) == NULL) {
				alloc_failed_exception.isa =
				    [OFAllocFailedException class];
				@throw (OFAllocFailedException*)
				    &alloc_failed_exception;
			}

			if (src->forwarding == src)
				(*dst)->forwarding = *dst;

			memcpy(*dst, src, src->size);

			if (src->size >= sizeof(of_block_byref_t))
				src->byref_keep(*dst, src);
		} else
			*dst = src;

		(*dst)->flags++;
		break;
	}
}

void
_Block_object_dispose(const void *obj_, const int flags_)
{
	const int flags = flags_ & (OF_BLOCK_FIELD_IS_BLOCK |
	    OF_BLOCK_FIELD_IS_OBJECT | OF_BLOCK_FIELD_IS_BYREF);

	if (obj_ == NULL)
		return;

	if (flags_ & OF_BLOCK_BYREF_CALLER)
		return;

	switch (flags) {
	case OF_BLOCK_FIELD_IS_BLOCK:
		_Block_release(obj_);
		break;
	case OF_BLOCK_FIELD_IS_OBJECT:
		[(id)obj_ release];
		break;
	case OF_BLOCK_FIELD_IS_BYREF:;
		of_block_byref_t *obj = (of_block_byref_t*)obj_;

		if ((--obj->flags & OF_BLOCK_REFCOUNT_MASK) == 0) {
			if (obj->size >= sizeof(of_block_byref_t))
				obj->byref_dispose(obj);

			free(obj);
		}
		break;
	}
}

@implementation OFBlock
#if defined(OF_APPLE_RUNTIME) && !defined(__OBJC2__)
+ (void)load
{
	Class tmp;

	/*
	 * There is no objc_initializeClassPair in 10.5.
	 * However, objc_allocateClassPair does not register the new class with
	 * the subclass in the ObjC1 runtime like the ObjC2 runtime does, so
	 * this workaround should be fine.
	 */
	if ((tmp = objc_allocateClassPair(self, "OFStackBlock", 0)) == NULL)
		@throw [OFInitializationFailedException
		    exceptionWithClass: self];
	memcpy(&_NSConcreteStackBlock, tmp, sizeof(_NSConcreteStackBlock));
	free(tmp);
	objc_registerClassPair((Class)&_NSConcreteStackBlock);

	if ((tmp = objc_allocateClassPair(self, "OFGlobalBlock", 0)) == NULL)
		@throw [OFInitializationFailedException
		    exceptionWithClass: self];
	memcpy(&_NSConcreteGlobalBlock, tmp, sizeof(_NSConcreteGlobalBlock));
	free(tmp);
	objc_registerClassPair((Class)&_NSConcreteGlobalBlock);

	if ((tmp = objc_allocateClassPair(self, "OFMallocBlock", 0)) == NULL)
		@throw [OFInitializationFailedException
		    exceptionWithClass: self];
	memcpy(&_NSConcreteMallocBlock, tmp, sizeof(_NSConcreteMallocBlock));
	free(tmp);
	objc_registerClassPair((Class)&_NSConcreteMallocBlock);
}
#endif

#if !defined(OF_ATOMIC_OPS)
+ (void)initialize
{
	size_t i;

	for (i = 0; i < NUM_SPINLOCKS; i++)
		if (!of_spinlock_new(&spinlocks[i]))
			@throw [OFInitializationFailedException
			    exceptionWithClass: self];
}
#endif

+ alloc
{
	@throw [OFNotImplementedException exceptionWithClass: self
						    selector: _cmd];
}

- init
{
	@throw [OFNotImplementedException exceptionWithClass: isa
						    selector: _cmd];
}

- (void*)allocMemoryWithSize: (size_t)size
{
	@throw [OFNotImplementedException exceptionWithClass: isa
						    selector: _cmd];
}

- (void*)allocMemoryForNItems: (size_t)nitems
		     withSize: (size_t)size
{
	@throw [OFNotImplementedException exceptionWithClass: isa
						    selector: _cmd];
}

- (void*)resizeMemory: (void*)ptr
	       toSize: (size_t)size
{
	@throw [OFNotImplementedException exceptionWithClass: isa
						    selector: _cmd];
}

- (void*)resizeMemory: (void*)ptr
	     toNItems: (size_t)nitems
	     withSize: (size_t)size
{
	@throw [OFNotImplementedException exceptionWithClass: isa
						    selector: _cmd];
}

- (void)freeMemory: (void*)ptr
{
	@throw [OFNotImplementedException exceptionWithClass: isa
						    selector: _cmd];
}

- retain
{
	if (isa == (Class)&_NSConcreteMallocBlock)
		return Block_copy(self);

	return self;
}

- copy
{
	return Block_copy(self);
}

- autorelease
{
	if (isa == (Class)&_NSConcreteMallocBlock)
		return [super autorelease];

	return self;
}

- (unsigned int)retainCount
{
	if (isa == (Class)&_NSConcreteMallocBlock)
		return ((of_block_literal_t*)self)->flags &
		    OF_BLOCK_REFCOUNT_MASK;

	return OF_RETAIN_COUNT_MAX;
}

- (void)release
{
	if (isa == (Class)&_NSConcreteMallocBlock)
		Block_release(self);
}

- (void)dealloc
{
	@throw [OFNotImplementedException exceptionWithClass: isa
						    selector: _cmd];
	[super dealloc];	/* Get rid of a stupid warning */
}
@end

#if defined(OF_APPLE_RUNTIME) && defined(__OBJC2__)
@implementation OFStackBlock
+ (void)load
{
	/*
	 * Send a message to the class to ensure it's initialized. Otherwise it
	 * it might not get initialized as blocks are preallocated.
	 */
	[self class];
}
@end

@implementation OFGlobalBlock
+ (void)load
{
	/*
	 * Send a message to the class to ensure it's initialized. Otherwise it
	 * it might not get initialized as blocks are preallocated.
	 */
	[self class];
}
@end

@implementation OFMallocBlock
+ (void)load
{
	/*
	 * Send a message to the class to ensure it's initialized. Otherwise it
	 * it might not get initialized as blocks are preallocated.
	 */
	[self class];
}
@end
#endif
