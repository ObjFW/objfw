/*
 * Copyright (c) 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017,
 *               2018, 2019
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

#import "OFObject.h"
#import "OFDNSResolver.h"
#import "OFRunLoop.h"

#import "socket.h"

OF_ASSUME_NONNULL_BEGIN

@class OFDNSResolverSettings;
@class OFDNSResourceRecord;
@class OFMutableArray OF_GENERIC(ObjectType);
@class OFMutableData;
@class OFString;

@interface OFHostAddressResolver: OFObject <OFDNSResolverDelegate>
{
	OFString *_host;
	of_socket_address_family_t _addressFamily;
	OFDNSResolver *_resolver;
	OFDNSResolverSettings *_settings;
	of_run_loop_mode_t _Nullable _runLoopMode;
	id <OFDNSResolverDelegate> _Nullable _delegate;
	unsigned int _numExpectedResponses;
	OFMutableData *_addresses;
}

- (instancetype)initWithHost: (OFString *)host
	       addressFamily: (of_socket_address_family_t)addressFamily
		    resolver: (OFDNSResolver *)resolver
		    settings: (OFDNSResolverSettings *)settings
		 runLoopMode: (nullable of_run_loop_mode_t)runLoopMode
		    delegate: (nullable id <OFDNSResolverDelegate>)delegate;
- (void)asyncResolve;
- (OFData *)resolve;
@end

OF_ASSUME_NONNULL_END
