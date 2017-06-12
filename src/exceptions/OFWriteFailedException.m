/*
 * Copyright (c) 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017
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

#include "config.h"

#import "OFWriteFailedException.h"
#import "OFString.h"

@implementation OFWriteFailedException
@synthesize bytesWritten = _bytesWritten;

+ (instancetype)exceptionWithObject: (id)object
		    requestedLength: (size_t)requestedLength
			      errNo: (int)errNo
{
	return [[[self alloc] initWithObject: object
			     requestedLength: requestedLength
				       errNo: errNo] autorelease];
}

+ (instancetype)exceptionWithObject: (id)object
		    requestedLength: (size_t)requestedLength
		       bytesWritten: (size_t)bytesWritten
			      errNo: (int)errNo
{
	return [[[self alloc] initWithObject: object
			     requestedLength: requestedLength
				bytesWritten: bytesWritten
				       errNo: errNo] autorelease];
}

-  initWithObject: (id)object
  requestedLength: (size_t)requestedLength
	    errNo: (int)errNo
{
	OF_INVALID_INIT_METHOD
}

-  initWithObject: (id)object
  requestedLength: (size_t)requestedLength
     bytesWritten: (size_t)bytesWritten
	    errNo: (int)errNo
{
	self = [super initWithObject: object
		     requestedLength: requestedLength
			       errNo: errNo];

	_bytesWritten = bytesWritten;

	return self;
}

- (OFString *)description
{
	return [OFString stringWithFormat:
	    @"Failed to write %zu bytes (after %zu bytes written)  to an "
	    @"object of type %@: %@",
	    _requestedLength, _bytesWritten, [_object class],
	    of_strerror(_errNo)];
}
@end
