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

#include "config.h"

#include <string.h>
#include <unistd.h>
#include <errno.h>

#ifndef _WIN32
# include <sys/types.h>
# include <sys/socket.h>
#endif

#import "OFStreamSocket.h"

#import "OFInitializationFailedException.h"
#import "OFNotConnectedException.h"
#import "OFReadFailedException.h"
#import "OFSetOptionFailedException.h"
#import "OFWriteFailedException.h"

#ifndef INVALID_SOCKET
# define INVALID_SOCKET -1
#endif

#ifdef _WIN32
# define close(sock) closesocket(sock)
#endif

@implementation OFStreamSocket
#ifdef _WIN32
+ (void)initialize
{
	WSADATA wsa;

	if (self != [OFStreamSocket class])
		return;

	if (WSAStartup(MAKEWORD(2, 0), &wsa))
		@throw [OFInitializationFailedException newWithClass: self];
}
#endif

+ socket
{
	return [[[self alloc] init] autorelease];
}

- (BOOL)_isAtEndOfStream
{
	return isAtEndOfStream;
}

- (size_t)_readNBytes: (size_t)length
	   intoBuffer: (void*)buffer
{
	ssize_t ret;

	if (sock == INVALID_SOCKET)
		@throw [OFNotConnectedException newWithClass: isa
						      socket: self];

	if (isAtEndOfStream) {
		OFReadFailedException *e;

		e = [OFReadFailedException newWithClass: isa
						 stream: self
					requestedLength: length];
#ifndef _WIN32
		e->errNo = ENOTCONN;
#else
		e->errNo = WSAENOTCONN;
#endif

		@throw e;
	}

	if ((ret = recv(sock, buffer, length, 0)) < 0)
		@throw [OFReadFailedException newWithClass: isa
						    stream: self
					   requestedLength: length];

	if (ret == 0)
		isAtEndOfStream = YES;

	return ret;
}

- (void)_writeNBytes: (size_t)length
	  fromBuffer: (const void*)buffer
{
	if (sock == INVALID_SOCKET)
		@throw [OFNotConnectedException newWithClass: isa
						      socket: self];

	if (isAtEndOfStream) {
		OFWriteFailedException *e;

		e = [OFWriteFailedException newWithClass: isa
						  stream: self
					 requestedLength: length];
#ifndef _WIN32
		e->errNo = ENOTCONN;
#else
		e->errNo = WSAENOTCONN;
#endif

		@throw e;
	}

	if (send(sock, buffer, length, 0) < length)
		@throw [OFWriteFailedException newWithClass: isa
						     stream: self
					    requestedLength: length];
}

#ifdef _WIN32
- (void)setBlocking: (BOOL)enable
{
	u_long v = enable;
	isBlocking = enable;

	if (ioctlsocket(sock, FIONBIO, &v) == SOCKET_ERROR)
		@throw [OFSetOptionFailedException newWithClass: isa
							 stream: self];
}
#endif

- (int)fileDescriptor
{
	return sock;
}

- (void)close
{
	if (sock == INVALID_SOCKET)
		@throw [OFNotConnectedException newWithClass: isa
						      socket: self];

	close(sock);

	sock = INVALID_SOCKET;
	isAtEndOfStream = NO;
}

- (void)dealloc
{
	if (sock != INVALID_SOCKET)
		[self close];

	[super dealloc];
}

- (void)finalize
{
	if (sock != INVALID_SOCKET)
		[self close];

	[super finalize];
}
@end
