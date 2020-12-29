/*
 * Copyright (c) 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017,
 *               2018, 2019, 2020
 *   Jonathan Schleifer <js@nil.im>
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

/* This file is automatically generated from library.xml */

#include "config.h"

#import "ObjFWRT.h"
#import "private.h"

#ifdef OF_AMIGAOS_M68K
# define PPC_PARAMS(...) (void)
# define M68K_ARG(type, name, reg)		\
	register type reg##name __asm__(#reg);	\
	type name = reg##name;
#else
# define PPC_PARAMS(...) (__VA_ARGS__)
# define M68K_ARG(...)
#endif

#ifdef OF_MORPHOS
/* All __saveds functions in this file need to use the SysV ABI */
__asm__ (
    ".section .text\n"
    ".align 2\n"
    "__restore_r13:\n"
    "	lwz	%r13, 44(%r12)\n"
    "	blr\n"
);
#endif

bool __saveds
glue_objc_init PPC_PARAMS(unsigned int version, struct objc_libc *libc)
{
	M68K_ARG(unsigned int, version, d0)
	M68K_ARG(struct objc_libc *, libc, a0)

	return objc_init(version, libc);
}

void __saveds
glue___objc_exec_class PPC_PARAMS(struct objc_module *_Nonnull module)
{
	M68K_ARG(struct objc_module *_Nonnull, module, a0)

	__objc_exec_class(module);
}

IMP _Nonnull __saveds
glue_objc_msg_lookup PPC_PARAMS(id _Nullable object, SEL _Nonnull selector)
{
	M68K_ARG(id _Nullable, object, a0)
	M68K_ARG(SEL _Nonnull, selector, a1)

	return objc_msg_lookup(object, selector);
}

IMP _Nonnull __saveds
glue_objc_msg_lookup_stret PPC_PARAMS(id _Nullable object, SEL _Nonnull selector)
{
	M68K_ARG(id _Nullable, object, a0)
	M68K_ARG(SEL _Nonnull, selector, a1)

	return objc_msg_lookup_stret(object, selector);
}

IMP _Nonnull __saveds
glue_objc_msg_lookup_super PPC_PARAMS(struct objc_super *_Nonnull super, SEL _Nonnull selector)
{
	M68K_ARG(struct objc_super *_Nonnull, super, a0)
	M68K_ARG(SEL _Nonnull, selector, a1)

	return objc_msg_lookup_super(super, selector);
}

IMP _Nonnull __saveds
glue_objc_msg_lookup_super_stret PPC_PARAMS(struct objc_super *_Nonnull super, SEL _Nonnull selector)
{
	M68K_ARG(struct objc_super *_Nonnull, super, a0)
	M68K_ARG(SEL _Nonnull, selector, a1)

	return objc_msg_lookup_super_stret(super, selector);
}

Class _Nullable __saveds
glue_objc_lookUpClass PPC_PARAMS(const char *_Nonnull name)
{
	M68K_ARG(const char *_Nonnull, name, a0)

	return objc_lookUpClass(name);
}

Class _Nullable __saveds
glue_objc_getClass PPC_PARAMS(const char *_Nonnull name)
{
	M68K_ARG(const char *_Nonnull, name, a0)

	return objc_getClass(name);
}

Class _Nonnull __saveds
glue_objc_getRequiredClass PPC_PARAMS(const char *_Nonnull name)
{
	M68K_ARG(const char *_Nonnull, name, a0)

	return objc_getRequiredClass(name);
}

Class _Nullable __saveds
glue_objc_lookup_class PPC_PARAMS(const char *_Nonnull name)
{
	M68K_ARG(const char *_Nonnull, name, a0)

	return objc_lookup_class(name);
}

Class _Nonnull __saveds
glue_objc_get_class PPC_PARAMS(const char *_Nonnull name)
{
	M68K_ARG(const char *_Nonnull, name, a0)

	return objc_get_class(name);
}

void __saveds
glue_objc_exception_throw PPC_PARAMS(id _Nonnull object)
{
	M68K_ARG(id _Nonnull, object, a0)

	objc_exception_throw(object);
}

int __saveds
glue_objc_sync_enter PPC_PARAMS(id _Nullable object)
{
	M68K_ARG(id _Nullable, object, a0)

	return objc_sync_enter(object);
}

int __saveds
glue_objc_sync_exit PPC_PARAMS(id _Nullable object)
{
	M68K_ARG(id _Nullable, object, a0)

	return objc_sync_exit(object);
}

id _Nullable __saveds
glue_objc_getProperty PPC_PARAMS(id _Nonnull self, SEL _Nonnull _cmd, ptrdiff_t offset, bool atomic)
{
	M68K_ARG(id _Nonnull, self, a0)
	M68K_ARG(SEL _Nonnull, _cmd, a1)
	M68K_ARG(ptrdiff_t, offset, d0)
	M68K_ARG(bool, atomic, d1)

	return objc_getProperty(self, _cmd, offset, atomic);
}

void __saveds
glue_objc_setProperty PPC_PARAMS(id _Nonnull self, SEL _Nonnull _cmd, ptrdiff_t offset, id _Nullable value, bool atomic, signed char copy)
{
	M68K_ARG(id _Nonnull, self, a0)
	M68K_ARG(SEL _Nonnull, _cmd, a1)
	M68K_ARG(ptrdiff_t, offset, d0)
	M68K_ARG(id _Nullable, value, a2)
	M68K_ARG(bool, atomic, d1)
	M68K_ARG(signed char, copy, d2)

	objc_setProperty(self, _cmd, offset, value, atomic, copy);
}

void __saveds
glue_objc_getPropertyStruct PPC_PARAMS(void *_Nonnull dest, const void *_Nonnull src, ptrdiff_t size, bool atomic, bool strong)
{
	M68K_ARG(void *_Nonnull, dest, a0)
	M68K_ARG(const void *_Nonnull, src, a1)
	M68K_ARG(ptrdiff_t, size, d0)
	M68K_ARG(bool, atomic, d1)
	M68K_ARG(bool, strong, d2)

	objc_getPropertyStruct(dest, src, size, atomic, strong);
}

void __saveds
glue_objc_setPropertyStruct PPC_PARAMS(void *_Nonnull dest, const void *_Nonnull src, ptrdiff_t size, bool atomic, bool strong)
{
	M68K_ARG(void *_Nonnull, dest, a0)
	M68K_ARG(const void *_Nonnull, src, a1)
	M68K_ARG(ptrdiff_t, size, d0)
	M68K_ARG(bool, atomic, d1)
	M68K_ARG(bool, strong, d2)

	objc_setPropertyStruct(dest, src, size, atomic, strong);
}

void __saveds
glue_objc_enumerationMutation PPC_PARAMS(id _Nonnull object)
{
	M68K_ARG(id _Nonnull, object, a0)

	objc_enumerationMutation(object);
}

int __saveds
glue___gnu_objc_personality PPC_PARAMS(int version, int actions, uint64_t *_Nonnull exClass, void *_Nonnull ex, void *_Nonnull ctx)
{
	M68K_ARG(int, version, d0)
	M68K_ARG(int, actions, d1)
	M68K_ARG(uint64_t *_Nonnull, exClass, d2)
	M68K_ARG(void *_Nonnull, ex, a0)
	M68K_ARG(void *_Nonnull, ctx, a1)

	return __gnu_objc_personality(version, actions, exClass, ex, ctx);
}

id _Nullable __saveds
glue_objc_retain PPC_PARAMS(id _Nullable object)
{
	M68K_ARG(id _Nullable, object, a0)

	return objc_retain(object);
}

id _Nullable __saveds
glue_objc_retainBlock PPC_PARAMS(id _Nullable block)
{
	M68K_ARG(id _Nullable, block, a0)

	return objc_retainBlock(block);
}

id _Nullable __saveds
glue_objc_retainAutorelease PPC_PARAMS(id _Nullable object)
{
	M68K_ARG(id _Nullable, object, a0)

	return objc_retainAutorelease(object);
}

void __saveds
glue_objc_release PPC_PARAMS(id _Nullable object)
{
	M68K_ARG(id _Nullable, object, a0)

	objc_release(object);
}

id _Nullable __saveds
glue_objc_autorelease PPC_PARAMS(id _Nullable object)
{
	M68K_ARG(id _Nullable, object, a0)

	return objc_autorelease(object);
}

id _Nullable __saveds
glue_objc_autoreleaseReturnValue PPC_PARAMS(id _Nullable object)
{
	M68K_ARG(id _Nullable, object, a0)

	return objc_autoreleaseReturnValue(object);
}

id _Nullable __saveds
glue_objc_retainAutoreleaseReturnValue PPC_PARAMS(id _Nullable object)
{
	M68K_ARG(id _Nullable, object, a0)

	return objc_retainAutoreleaseReturnValue(object);
}

id _Nullable __saveds
glue_objc_retainAutoreleasedReturnValue PPC_PARAMS(id _Nullable object)
{
	M68K_ARG(id _Nullable, object, a0)

	return objc_retainAutoreleasedReturnValue(object);
}

id _Nullable __saveds
glue_objc_storeStrong PPC_PARAMS(id _Nullable *_Nonnull object, id _Nullable value)
{
	M68K_ARG(id _Nullable *_Nonnull, object, a0)
	M68K_ARG(id _Nullable, value, a1)

	return objc_storeStrong(object, value);
}

id _Nullable __saveds
glue_objc_storeWeak PPC_PARAMS(id _Nullable *_Nonnull object, id _Nullable value)
{
	M68K_ARG(id _Nullable *_Nonnull, object, a0)
	M68K_ARG(id _Nullable, value, a1)

	return objc_storeWeak(object, value);
}

id _Nullable __saveds
glue_objc_loadWeakRetained PPC_PARAMS(id _Nullable *_Nonnull object)
{
	M68K_ARG(id _Nullable *_Nonnull, object, a0)

	return objc_loadWeakRetained(object);
}

id _Nullable __saveds
glue_objc_initWeak PPC_PARAMS(id _Nullable *_Nonnull object, id _Nullable value)
{
	M68K_ARG(id _Nullable *_Nonnull, object, a0)
	M68K_ARG(id _Nullable, value, a1)

	return objc_initWeak(object, value);
}

void __saveds
glue_objc_destroyWeak PPC_PARAMS(id _Nullable *_Nonnull object)
{
	M68K_ARG(id _Nullable *_Nonnull, object, a0)

	objc_destroyWeak(object);
}

id _Nullable __saveds
glue_objc_loadWeak PPC_PARAMS(id _Nullable *_Nonnull object)
{
	M68K_ARG(id _Nullable *_Nonnull, object, a0)

	return objc_loadWeak(object);
}

void __saveds
glue_objc_copyWeak PPC_PARAMS(id _Nullable *_Nonnull dest, id _Nullable *_Nonnull src)
{
	M68K_ARG(id _Nullable *_Nonnull, dest, a0)
	M68K_ARG(id _Nullable *_Nonnull, src, a1)

	objc_copyWeak(dest, src);
}

void __saveds
glue_objc_moveWeak PPC_PARAMS(id _Nullable *_Nonnull dest, id _Nullable *_Nonnull src)
{
	M68K_ARG(id _Nullable *_Nonnull, dest, a0)
	M68K_ARG(id _Nullable *_Nonnull, src, a1)

	objc_moveWeak(dest, src);
}

SEL _Nonnull __saveds
glue_sel_registerName PPC_PARAMS(const char *_Nonnull name)
{
	M68K_ARG(const char *_Nonnull, name, a0)

	return sel_registerName(name);
}

const char *_Nonnull __saveds
glue_sel_getName PPC_PARAMS(SEL _Nonnull selector)
{
	M68K_ARG(SEL _Nonnull, selector, a0)

	return sel_getName(selector);
}

bool __saveds
glue_sel_isEqual PPC_PARAMS(SEL _Nonnull selector1, SEL _Nonnull selector2)
{
	M68K_ARG(SEL _Nonnull, selector1, a0)
	M68K_ARG(SEL _Nonnull, selector2, a1)

	return sel_isEqual(selector1, selector2);
}

Class _Nonnull __saveds
glue_objc_allocateClassPair PPC_PARAMS(Class _Nullable superclass, const char *_Nonnull name, size_t extraBytes)
{
	M68K_ARG(Class _Nullable, superclass, a0)
	M68K_ARG(const char *_Nonnull, name, a1)
	M68K_ARG(size_t, extraBytes, d0)

	return objc_allocateClassPair(superclass, name, extraBytes);
}

void __saveds
glue_objc_registerClassPair PPC_PARAMS(Class _Nonnull class)
{
	M68K_ARG(Class _Nonnull, class, a0)

	objc_registerClassPair(class);
}

unsigned int __saveds
glue_objc_getClassList PPC_PARAMS(Class _Nonnull *_Nullable buffer, unsigned int count)
{
	M68K_ARG(Class _Nonnull *_Nullable, buffer, a0)
	M68K_ARG(unsigned int, count, d0)

	return objc_getClassList(buffer, count);
}

Class _Nonnull *_Nonnull __saveds
glue_objc_copyClassList PPC_PARAMS(unsigned int *_Nullable length)
{
	M68K_ARG(unsigned int *_Nullable, length, a0)

	return objc_copyClassList(length);
}

bool __saveds
glue_class_isMetaClass PPC_PARAMS(Class _Nullable class)
{
	M68K_ARG(Class _Nullable, class, a0)

	return class_isMetaClass(class);
}

const char *_Nullable __saveds
glue_class_getName PPC_PARAMS(Class _Nullable class)
{
	M68K_ARG(Class _Nullable, class, a0)

	return class_getName(class);
}

Class _Nullable __saveds
glue_class_getSuperclass PPC_PARAMS(Class _Nullable class)
{
	M68K_ARG(Class _Nullable, class, a0)

	return class_getSuperclass(class);
}

unsigned long __saveds
glue_class_getInstanceSize PPC_PARAMS(Class _Nullable class)
{
	M68K_ARG(Class _Nullable, class, a0)

	return class_getInstanceSize(class);
}

bool __saveds
glue_class_respondsToSelector PPC_PARAMS(Class _Nullable class, SEL _Nonnull selector)
{
	M68K_ARG(Class _Nullable, class, a0)
	M68K_ARG(SEL _Nonnull, selector, a1)

	return class_respondsToSelector(class, selector);
}

bool __saveds
glue_class_conformsToProtocol PPC_PARAMS(Class _Nullable class, Protocol *_Nonnull p)
{
	M68K_ARG(Class _Nullable, class, a0)
	M68K_ARG(Protocol *_Nonnull, p, a1)

	return class_conformsToProtocol(class, p);
}

IMP _Nullable __saveds
glue_class_getMethodImplementation PPC_PARAMS(Class _Nullable class, SEL _Nonnull selector)
{
	M68K_ARG(Class _Nullable, class, a0)
	M68K_ARG(SEL _Nonnull, selector, a1)

	return class_getMethodImplementation(class, selector);
}

IMP _Nullable __saveds
glue_class_getMethodImplementation_stret PPC_PARAMS(Class _Nullable class, SEL _Nonnull selector)
{
	M68K_ARG(Class _Nullable, class, a0)
	M68K_ARG(SEL _Nonnull, selector, a1)

	return class_getMethodImplementation_stret(class, selector);
}

Method _Nullable __saveds
glue_class_getInstanceMethod PPC_PARAMS(Class _Nullable class, SEL _Nonnull selector)
{
	M68K_ARG(Class _Nullable, class, a0)
	M68K_ARG(SEL _Nonnull, selector, a1)

	return class_getInstanceMethod(class, selector);
}

bool __saveds
glue_class_addMethod PPC_PARAMS(Class _Nonnull class, SEL _Nonnull selector, IMP _Nonnull implementation, const char *_Nullable typeEncoding)
{
	M68K_ARG(Class _Nonnull, class, a0)
	M68K_ARG(SEL _Nonnull, selector, a1)
	M68K_ARG(IMP _Nonnull, implementation, a2)
	M68K_ARG(const char *_Nullable, typeEncoding, a3)

	return class_addMethod(class, selector, implementation, typeEncoding);
}

IMP _Nullable __saveds
glue_class_replaceMethod PPC_PARAMS(Class _Nonnull class, SEL _Nonnull selector, IMP _Nonnull implementation, const char *_Nullable typeEncoding)
{
	M68K_ARG(Class _Nonnull, class, a0)
	M68K_ARG(SEL _Nonnull, selector, a1)
	M68K_ARG(IMP _Nonnull, implementation, a2)
	M68K_ARG(const char *_Nullable, typeEncoding, a3)

	return class_replaceMethod(class, selector, implementation, typeEncoding);
}

Class _Nullable __saveds
glue_object_getClass PPC_PARAMS(id _Nullable object)
{
	M68K_ARG(id _Nullable, object, a0)

	return object_getClass(object);
}

Class _Nullable __saveds
glue_object_setClass PPC_PARAMS(id _Nullable object, Class _Nonnull class)
{
	M68K_ARG(id _Nullable, object, a0)
	M68K_ARG(Class _Nonnull, class, a1)

	return object_setClass(object, class);
}

const char *_Nullable __saveds
glue_object_getClassName PPC_PARAMS(id _Nullable object)
{
	M68K_ARG(id _Nullable, object, a0)

	return object_getClassName(object);
}

const char *_Nonnull __saveds
glue_protocol_getName PPC_PARAMS(Protocol *_Nonnull protocol)
{
	M68K_ARG(Protocol *_Nonnull, protocol, a0)

	return protocol_getName(protocol);
}

bool __saveds
glue_protocol_isEqual PPC_PARAMS(Protocol *_Nonnull protocol1, Protocol *_Nonnull protocol2)
{
	M68K_ARG(Protocol *_Nonnull, protocol1, a0)
	M68K_ARG(Protocol *_Nonnull, protocol2, a1)

	return protocol_isEqual(protocol1, protocol2);
}

bool __saveds
glue_protocol_conformsToProtocol PPC_PARAMS(Protocol *_Nonnull protocol1, Protocol *_Nonnull protocol2)
{
	M68K_ARG(Protocol *_Nonnull, protocol1, a0)
	M68K_ARG(Protocol *_Nonnull, protocol2, a1)

	return protocol_conformsToProtocol(protocol1, protocol2);
}

_Nullable objc_uncaught_exception_handler_t __saveds
glue_objc_setUncaughtExceptionHandler PPC_PARAMS(objc_uncaught_exception_handler_t _Nullable handler)
{
	M68K_ARG(objc_uncaught_exception_handler_t _Nullable, handler, a0)

	return objc_setUncaughtExceptionHandler(handler);
}

void __saveds
glue_objc_setForwardHandler PPC_PARAMS(IMP _Nullable forward, IMP _Nullable stretForward)
{
	M68K_ARG(IMP _Nullable, forward, a0)
	M68K_ARG(IMP _Nullable, stretForward, a1)

	objc_setForwardHandler(forward, stretForward);
}

void __saveds
glue_objc_setEnumerationMutationHandler PPC_PARAMS(objc_enumeration_mutation_handler_t _Nullable hadler)
{
	M68K_ARG(objc_enumeration_mutation_handler_t _Nullable, hadler, a0)

	objc_setEnumerationMutationHandler(hadler);
}

id _Nullable __saveds
glue_objc_constructInstance PPC_PARAMS(Class _Nullable class, void *_Nullable bytes)
{
	M68K_ARG(Class _Nullable, class, a0)
	M68K_ARG(void *_Nullable, bytes, a1)

	return objc_constructInstance(class, bytes);
}

void __saveds
glue_objc_exit(void)
{
	objc_exit();
}

Ivar _Nullable *_Nullable __saveds
glue_class_copyIvarList PPC_PARAMS(Class _Nullable class, unsigned int *_Nullable outCount)
{
	M68K_ARG(Class _Nullable, class, a0)
	M68K_ARG(unsigned int *_Nullable, outCount, a1)

	return class_copyIvarList(class, outCount);
}

const char *_Nonnull __saveds
glue_ivar_getName PPC_PARAMS(Ivar _Nonnull ivar)
{
	M68K_ARG(Ivar _Nonnull, ivar, a0)

	return ivar_getName(ivar);
}

const char *_Nonnull __saveds
glue_ivar_getTypeEncoding PPC_PARAMS(Ivar _Nonnull ivar)
{
	M68K_ARG(Ivar _Nonnull, ivar, a0)

	return ivar_getTypeEncoding(ivar);
}

ptrdiff_t __saveds
glue_ivar_getOffset PPC_PARAMS(Ivar _Nonnull ivar)
{
	M68K_ARG(Ivar _Nonnull, ivar, a0)

	return ivar_getOffset(ivar);
}

Method _Nullable *_Nullable __saveds
glue_class_copyMethodList PPC_PARAMS(Class _Nullable class, unsigned int *_Nullable outCount)
{
	M68K_ARG(Class _Nullable, class, a0)
	M68K_ARG(unsigned int *_Nullable, outCount, a1)

	return class_copyMethodList(class, outCount);
}

SEL _Nonnull __saveds
glue_method_getName PPC_PARAMS(Method _Nonnull method)
{
	M68K_ARG(Method _Nonnull, method, a0)

	return method_getName(method);
}

const char *_Nullable __saveds
glue_method_getTypeEncoding PPC_PARAMS(Method _Nonnull method)
{
	M68K_ARG(Method _Nonnull, method, a0)

	return method_getTypeEncoding(method);
}

objc_property_t _Nullable *_Nullable __saveds
glue_class_copyPropertyList PPC_PARAMS(Class _Nullable class, unsigned int *_Nullable outCount)
{
	M68K_ARG(Class _Nullable, class, a0)
	M68K_ARG(unsigned int *_Nullable, outCount, a1)

	return class_copyPropertyList(class, outCount);
}

const char *_Nonnull __saveds
glue_property_getName PPC_PARAMS(objc_property_t _Nonnull property)
{
	M68K_ARG(objc_property_t _Nonnull, property, a0)

	return property_getName(property);
}

char *_Nullable __saveds
glue_property_copyAttributeValue PPC_PARAMS(objc_property_t _Nonnull property, const char *_Nonnull name)
{
	M68K_ARG(objc_property_t _Nonnull, property, a0)
	M68K_ARG(const char *_Nonnull, name, a1)

	return property_copyAttributeValue(property, name);
}

void *_Nullable __saveds
glue_objc_destructInstance PPC_PARAMS(id _Nullable object)
{
	M68K_ARG(id _Nullable, object, a0)

	return objc_destructInstance(object);
}

void *_Null_unspecified __saveds
glue_objc_autoreleasePoolPush(void)
{
	return objc_autoreleasePoolPush();
}

void __saveds
glue_objc_autoreleasePoolPop PPC_PARAMS(void *_Null_unspecified pool)
{
	M68K_ARG(void *_Null_unspecified, pool, a0)

	objc_autoreleasePoolPop(pool);
}

id _Nullable __saveds
glue__objc_rootAutorelease PPC_PARAMS(id _Nullable object)
{
	M68K_ARG(id _Nullable, object, a0)

	return _objc_rootAutorelease(object);
}

struct objc_hashtable *_Nonnull __saveds
glue_objc_hashtable_new PPC_PARAMS(objc_hashtable_hash_func hash, objc_hashtable_equal_func equal, uint32_t size)
{
	M68K_ARG(objc_hashtable_hash_func, hash, a0)
	M68K_ARG(objc_hashtable_equal_func, equal, a1)
	M68K_ARG(uint32_t, size, d0)

	return objc_hashtable_new(hash, equal, size);
}

void __saveds
glue_objc_hashtable_set PPC_PARAMS(struct objc_hashtable *_Nonnull table, const void *_Nonnull key, const void *_Nonnull object)
{
	M68K_ARG(struct objc_hashtable *_Nonnull, table, a0)
	M68K_ARG(const void *_Nonnull, key, a1)
	M68K_ARG(const void *_Nonnull, object, a2)

	objc_hashtable_set(table, key, object);
}

void *_Nullable __saveds
glue_objc_hashtable_get PPC_PARAMS(struct objc_hashtable *_Nonnull table, const void *_Nonnull key)
{
	M68K_ARG(struct objc_hashtable *_Nonnull, table, a0)
	M68K_ARG(const void *_Nonnull, key, a1)

	return objc_hashtable_get(table, key);
}

void __saveds
glue_objc_hashtable_delete PPC_PARAMS(struct objc_hashtable *_Nonnull table, const void *_Nonnull key)
{
	M68K_ARG(struct objc_hashtable *_Nonnull, table, a0)
	M68K_ARG(const void *_Nonnull, key, a1)

	objc_hashtable_delete(table, key);
}

void __saveds
glue_objc_hashtable_free PPC_PARAMS(struct objc_hashtable *_Nonnull table)
{
	M68K_ARG(struct objc_hashtable *_Nonnull, table, a0)

	objc_hashtable_free(table);
}

void __saveds
glue_objc_setTaggedPointerSecret PPC_PARAMS(uintptr_t secret)
{
	M68K_ARG(uintptr_t, secret, d0)

	objc_setTaggedPointerSecret(secret);
}

int __saveds
glue_objc_registerTaggedPointerClass PPC_PARAMS(Class _Nonnull class)
{
	M68K_ARG(Class _Nonnull, class, a0)

	return objc_registerTaggedPointerClass(class);
}

bool __saveds
glue_object_isTaggedPointer PPC_PARAMS(id _Nullable object)
{
	M68K_ARG(id _Nullable, object, a0)

	return object_isTaggedPointer(object);
}

uintptr_t __saveds
glue_object_getTaggedPointerValue PPC_PARAMS(id _Nonnull object)
{
	M68K_ARG(id _Nonnull, object, a0)

	return object_getTaggedPointerValue(object);
}

id _Nullable __saveds
glue_objc_createTaggedPointer PPC_PARAMS(int class, uintptr_t value)
{
	M68K_ARG(int, class, d0)
	M68K_ARG(uintptr_t, value, d1)

	return objc_createTaggedPointer(class, value);
}
