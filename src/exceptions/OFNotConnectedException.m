/*
 * Copyright (c) 2008, 2009, 2010, 2011, 2012, 2013, 2014
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

#import "OFNotConnectedException.h"
#import "OFString.h"
#import "OFTCPSocket.h"

#import "common.h"
#import "macros.h"

@implementation OFNotConnectedException
+ (instancetype)exceptionWithSocket: (OFStreamSocket*)socket
{
	return [[[self alloc] initWithSocket: socket] autorelease];
}

- init
{
	OF_INVALID_INIT_METHOD
}

- initWithSocket: (OFStreamSocket*)socket
{
	self = [super init];

	_socket = [socket retain];

	return self;
}

- (void)dealloc
{
	[_socket release];

	[super dealloc];
}

- (OFString*)description
{
	return [OFString stringWithFormat:
	    @"The socket of type %@ is not connected or bound!",
	    [_socket class]];
}

- (OFStreamSocket*)socket
{
	OF_GETTER(_socket, true)
}
@end
