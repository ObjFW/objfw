/*
 * Copyright (c) 2008-2021 Jonathan Schleifer <js@nil.im>
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

#include <string.h>
#include <assert.h>

#import "OFList.h"
#import "OFString.h"
#import "OFXMLElement.h"
#import "OFArray.h"

#import "OFEnumerationMutationException.h"
#import "OFInvalidArgumentException.h"

OF_DIRECT_MEMBERS
@interface OFListEnumerator: OFEnumerator
{
	OFList *_list;
	OFListItem *_Nullable _current;
	unsigned long _mutations;
	unsigned long *_Nullable _mutationsPtr;
}

- (instancetype)initWithList: (OFList *)list
	    mutationsPointer: (unsigned long *)mutationsPtr;
@end

@implementation OFList
@synthesize firstListItem = _firstListItem, lastListItem = _lastListItem;

+ (instancetype)list
{
	return [[[self alloc] init] autorelease];
}

- (instancetype)initWithSerialization: (OFXMLElement *)element
{
	self = [self init];

	@try {
		void *pool = objc_autoreleasePoolPush();

		if (![element.name isEqual: self.className] ||
		    ![element.namespace isEqual: OF_SERIALIZATION_NS])
			@throw [OFInvalidArgumentException exception];

		for (OFXMLElement *child in
		    [element elementsForNamespace: OF_SERIALIZATION_NS]) {
			void *pool2 = objc_autoreleasePoolPush();

			[self appendObject: child.objectByDeserializing];

			objc_autoreleasePoolPop(pool2);
		}

		objc_autoreleasePoolPop(pool);
	} @catch (id e) {
		[self release];
		@throw e;
	}

	return self;
}

- (void)dealloc
{
	OFListItem *next;

	for (OFListItem *iter = _firstListItem; iter != NULL; iter = next) {
		[iter->object release];
		next = iter->next;
		free(iter);
	}

	[super dealloc];
}

- (OFListItem *)appendObject: (id)object
{
	OFListItem *listItem;

	listItem = of_alloc(1, sizeof(OFListItem));
	listItem->object = [object retain];
	listItem->next = NULL;
	listItem->previous = _lastListItem;

	if (_lastListItem != NULL)
		_lastListItem->next = listItem;

	_lastListItem = listItem;

	if (_firstListItem == NULL)
		_firstListItem = listItem;

	_count++;
	_mutations++;

	return listItem;
}

- (OFListItem *)prependObject: (id)object
{
	OFListItem *listItem = of_alloc(1, sizeof(OFListItem));

	listItem->object = [object retain];
	listItem->next = _firstListItem;
	listItem->previous = NULL;

	if (_firstListItem != NULL)
		_firstListItem->previous = listItem;

	_firstListItem = listItem;
	if (_lastListItem == NULL)
		_lastListItem = listItem;

	_count++;
	_mutations++;

	return listItem;
}

- (OFListItem *)insertObject: (id)object
	      beforeListItem: (OFListItem *)listItem
{
	OFListItem *newListItem = of_alloc(1, sizeof(OFListItem));

	newListItem->object = [object retain];
	newListItem->next = listItem;
	newListItem->previous = listItem->previous;

	if (listItem->previous != NULL)
		listItem->previous->next = newListItem;

	listItem->previous = newListItem;

	if (listItem == _firstListItem)
		_firstListItem = newListItem;

	_count++;
	_mutations++;

	return newListItem;
}

- (OFListItem *)insertObject: (id)object
	       afterListItem: (OFListItem *)listItem
{
	OFListItem *newListItem = of_alloc(1, sizeof(OFListItem));

	newListItem->object = [object retain];
	newListItem->next = listItem->next;
	newListItem->previous = listItem;

	if (listItem->next != NULL)
		listItem->next->previous = newListItem;

	listItem->next = newListItem;

	if (listItem == _lastListItem)
		_lastListItem = newListItem;

	_count++;
	_mutations++;

	return newListItem;
}

- (void)removeListItem: (OFListItem *)listItem
{
	if (listItem->previous != NULL)
		listItem->previous->next = listItem->next;
	if (listItem->next != NULL)
		listItem->next->previous = listItem->previous;

	if (_firstListItem == listItem)
		_firstListItem = listItem->next;
	if (_lastListItem == listItem)
		_lastListItem = listItem->previous;

	_count--;
	_mutations++;

	[listItem->object release];
	free(listItem);
}

- (id)firstObject
{
	return (_firstListItem != NULL ? _firstListItem->object : nil);
}

- (id)lastObject
{
	return (_lastListItem != NULL ? _lastListItem->object : nil);
}

- (size_t)count
{
	return _count;
}

- (bool)isEqual: (id)object
{
	OFList *list;
	OFListItem *iter, *iter2;

	if (object == self)
		return true;

	if (![object isKindOfClass: [OFList class]])
		return false;

	list = object;

	if (list.count != _count)
		return false;

	for (iter = _firstListItem, iter2 = list.firstListItem;
	    iter != NULL && iter2 != NULL;
	    iter = iter->next, iter2 = iter2->next)
		if (![iter->object isEqual: iter2->object])
			return false;

	/* One is bigger than the other even though we checked the count */
	assert(iter == NULL && iter2 == NULL);

	return true;
}

- (bool)containsObject: (id)object
{
	if (_count == 0)
		return false;

	for (OFListItem *iter = _firstListItem; iter != NULL; iter = iter->next)
		if ([iter->object isEqual: object])
			return true;

	return false;
}

- (bool)containsObjectIdenticalTo: (id)object
{
	if (_count == 0)
		return false;

	for (OFListItem *iter = _firstListItem; iter != NULL; iter = iter->next)
		if (iter->object == object)
			return true;

	return false;
}

- (void)removeAllObjects
{
	OFListItem *next;

	_mutations++;

	for (OFListItem *iter = _firstListItem; iter != NULL; iter = next) {
		[iter->object release];
		next = iter->next;
		free(iter);
	}

	_firstListItem = _lastListItem = NULL;
}

- (id)copy
{
	OFList *copy = [[[self class] alloc] init];
	OFListItem *listItem, *previous;

	listItem = NULL;
	previous = NULL;

	@try {
		for (OFListItem *iter = _firstListItem;
		    iter != NULL; iter = iter->next) {
			listItem = of_alloc(1, sizeof(OFListItem));
			listItem->object = [iter->object retain];
			listItem->next = NULL;
			listItem->previous = previous;

			if (copy->_firstListItem == NULL)
				copy->_firstListItem = listItem;
			if (previous != NULL)
				previous->next = listItem;

			copy->_count++;

			previous = listItem;
		}
	} @catch (id e) {
		[copy release];
		@throw e;
	}

	copy->_lastListItem = listItem;

	return copy;
}

- (unsigned long)hash
{
	uint32_t hash;

	OF_HASH_INIT(hash);

	for (OFListItem *iter = _firstListItem;
	    iter != NULL; iter = iter->next)
		OF_HASH_ADD_HASH(hash, [iter->object hash]);

	OF_HASH_FINALIZE(hash);

	return hash;
}

- (OFString *)description
{
	OFMutableString *ret;

	if (_count == 0)
		return @"[]";

	ret = [OFMutableString stringWithString: @"[\n"];

	for (OFListItem *iter = _firstListItem;
	    iter != NULL; iter = iter->next) {
		void *pool = objc_autoreleasePoolPush();

		[ret appendString: [iter->object description]];

		if (iter->next != NULL)
			[ret appendString: @",\n"];

		objc_autoreleasePoolPop(pool);
	}
	[ret replaceOccurrencesOfString: @"\n" withString: @"\n\t"];
	[ret appendString: @"\n]"];

	[ret makeImmutable];

	return ret;
}

- (OFXMLElement *)XMLElementBySerializing
{
	OFXMLElement *element =
	    [OFXMLElement elementWithName: self.className
				namespace: OF_SERIALIZATION_NS];

	for (OFListItem *iter = _firstListItem;
	    iter != NULL; iter = iter->next) {
		void *pool = objc_autoreleasePoolPush();

		[element addChild: [iter->object XMLElementBySerializing]];

		objc_autoreleasePoolPop(pool);
	}

	return element;
}

- (int)countByEnumeratingWithState: (OFFastEnumerationState *)state
			   objects: (id *)objects
			     count: (int)count
{
	OFListItem *listItem;

	memcpy(&listItem, state->extra, sizeof(listItem));

	state->itemsPtr = objects;
	state->mutationsPtr = &_mutations;

	if (state->state == 0) {
		listItem = _firstListItem;
		state->state = 1;
	}

	for (int i = 0; i < count; i++) {
		if (listItem == NULL)
			return i;

		objects[i] = listItem->object;
		listItem = listItem->next;
	}

	memcpy(state->extra, &listItem, sizeof(listItem));

	return count;
}

- (OFEnumerator *)objectEnumerator
{
	return [[[OFListEnumerator alloc] initWithList: self
				      mutationsPointer: &_mutations]
	    autorelease];
}
@end

@implementation OFListEnumerator
- (instancetype)initWithList: (OFList *)list
	    mutationsPointer: (unsigned long *)mutationsPtr
{
	self = [super init];

	_list = [list retain];
	_current = _list.firstListItem;
	_mutations = *mutationsPtr;
	_mutationsPtr = mutationsPtr;

	return self;
}

- (void)dealloc
{
	[_list release];

	[super dealloc];
}

- (id)nextObject
{
	id ret;

	if (*_mutationsPtr != _mutations)
		@throw [OFEnumerationMutationException
		    exceptionWithObject: _list];

	if (_current == NULL)
		return nil;

	ret = _current->object;
	_current = _current->next;

	return ret;
}
@end
