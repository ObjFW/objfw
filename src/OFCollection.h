/*
 * Copyright (c) 2008, 2009, 2010, 2011
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

#import "OFEnumerator.h"

/**
 * \brief A protocol with methods common for all collections.
 */
@protocol OFCollection
#ifdef OF_HAVE_PROPERTIES
@property (readonly) size_t count;
#endif

/**
 * \return The number of objects in the collection
 */
- (size_t)count;

/**
 * \returns An OFEnumerator to enumerate through all objects of the collection
 */
- (OFEnumerator*)objectEnumerator;

/**
 * \return A boolean whether the collection contains the specified object.
 */
- (BOOL)containsObject: (id)obj;

/**
 * \return A boolean whether the collection contains an object with the
 *	   specified address.
 */
- (BOOL)containsObjectIdenticalTo: (id)obj;
@end
