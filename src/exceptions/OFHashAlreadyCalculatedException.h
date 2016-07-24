/*
 * Copyright (c) 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016
 *   Jonathan Schleifer <js@heap.zone>
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

#import "OFException.h"
#import "OFCryptoHash.h"

/*!
 * @class OFHashAlreadyCalculatedException \
 *	  OFHashAlreadyCalculatedException.h \
 *	  ObjFW/OFHashAlreadyCalculatedException.h
 *
 * @brief An exception indicating that the hash has already been calculated.
 */
@interface OFHashAlreadyCalculatedException: OFException
{
	id <OFCryptoHash> _object;
}

/*!
 * The hash which has already been calculated.
 */
@property (readonly, retain) id <OFCryptoHash> object;

/*!
 * @brief Creates a new, autoreleased hash already calculated exception.
 *
 * @param object The hash which has already been calculated
 * @return A new, autoreleased hash already calculated exception
 */
+ (instancetype)exceptionWithObject: (id <OFCryptoHash>)object;

/*!
 * @brief Initializes an already allocated hash already calculated exception.
 *
 * @param object The hash which has already been calculated
 * @return An initialized hash already calculated exception
 */
- initWithObject: (id <OFCryptoHash>)object;
@end
