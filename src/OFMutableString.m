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

#include <stdarg.h>
#include <stdlib.h>
#include <string.h>

#import "OFString.h"
#import "OFMutableString_UTF8.h"
#import "OFAutoreleasePool.h"

#import "OFInvalidArgumentException.h"
#import "OFInvalidFormatException.h"
#import "OFNotImplementedException.h"
#import "OFOutOfRangeException.h"

#import "macros.h"

#import "of_asprintf.h"
#import "unicode.h"

static struct {
	Class isa;
} placeholder;

@interface OFMutableString_placeholder: OFMutableString
@end

@implementation OFMutableString_placeholder
- init
{
	return (id)[[OFMutableString_UTF8 alloc] init];
}

- initWithUTF8String: (const char*)UTF8String
{
	return (id)[[OFMutableString_UTF8 alloc]
	    initWithUTF8String: UTF8String];
}

- initWithUTF8String: (const char*)UTF8String
	      length: (size_t)UTF8StringLength
{
	return (id)[[OFMutableString_UTF8 alloc]
	    initWithUTF8String: UTF8String
			length: UTF8StringLength];
}

- initWithCString: (const char*)cString
	 encoding: (of_string_encoding_t)encoding
{
	return (id)[[OFMutableString_UTF8 alloc] initWithCString: cString
							encoding: encoding];
}

- initWithCString: (const char*)cString
	 encoding: (of_string_encoding_t)encoding
	   length: (size_t)cStringLength
{
	return (id)[[OFMutableString_UTF8 alloc]
	    initWithCString: cString
		   encoding: encoding
		     length: cStringLength];
}

- initWithString: (OFString*)string
{
	return (id)[[OFMutableString_UTF8 alloc] initWithString: string];
}

- initWithUnicodeString: (const of_unichar_t*)string
{
	return (id)[[OFMutableString_UTF8 alloc] initWithUnicodeString: string];
}

- initWithUnicodeString: (const of_unichar_t*)string
	      byteOrder: (of_endianess_t)byteOrder
{
	return (id)[[OFMutableString_UTF8 alloc]
	    initWithUnicodeString: string
			byteOrder: byteOrder];
}

- initWithUnicodeString: (const of_unichar_t*)string
		 length: (size_t)length
{
	return (id)[[OFMutableString_UTF8 alloc] initWithUnicodeString: string
								length: length];
}

- initWithUnicodeString: (const of_unichar_t*)string
	      byteOrder: (of_endianess_t)byteOrder
		 length: (size_t)length
{
	return (id)[[OFMutableString_UTF8 alloc]
	    initWithUnicodeString: string
			byteOrder: byteOrder
			   length: length];
}

- initWithUTF16String: (const uint16_t*)string
{
	return (id)[[OFMutableString_UTF8 alloc] initWithUTF16String: string];
}

- initWithUTF16String: (const uint16_t*)string
	    byteOrder: (of_endianess_t)byteOrder
{
	return (id)[[OFMutableString_UTF8 alloc]
	    initWithUTF16String: string
		      byteOrder: byteOrder];
}

- initWithUTF16String: (const uint16_t*)string
	       length: (size_t)length
{
	return (id)[[OFMutableString_UTF8 alloc] initWithUTF16String: string
							      length: length];
}

- initWithUTF16String: (const uint16_t*)string
	    byteOrder: (of_endianess_t)byteOrder
	       length: (size_t)length
{
	return (id)[[OFMutableString_UTF8 alloc]
	    initWithUTF16String: string
		      byteOrder: byteOrder
			 length: length];
}

- initWithFormat: (OFConstantString*)format, ...
{
	id ret;
	va_list arguments;

	va_start(arguments, format);
	ret = [[OFMutableString_UTF8 alloc] initWithFormat: format
						 arguments: arguments];
	va_end(arguments);

	return ret;
}

- initWithFormat: (OFConstantString*)format
       arguments: (va_list)arguments
{
	return (id)[[OFMutableString_UTF8 alloc] initWithFormat: format
						      arguments: arguments];
}

- initWithPath: (OFString*)firstComponent, ...
{
	id ret;
	va_list arguments;

	va_start(arguments, firstComponent);
	ret = [[OFMutableString_UTF8 alloc] initWithPath: firstComponent
					       arguments: arguments];
	va_end(arguments);

	return ret;
}

- initWithPath: (OFString*)firstComponent
     arguments: (va_list)arguments
{
	return (id)[[OFMutableString_UTF8 alloc] initWithPath: firstComponent
						    arguments: arguments];
}

- initWithContentsOfFile: (OFString*)path
{
	return (id)[[OFMutableString_UTF8 alloc] initWithContentsOfFile: path];
}

- initWithContentsOfFile: (OFString*)path
		encoding: (of_string_encoding_t)encoding
{
	return (id)[[OFMutableString_UTF8 alloc]
	    initWithContentsOfFile: path
			  encoding: encoding];
}

- initWithContentsOfURL: (OFURL*)URL
{
	return (id)[[OFMutableString_UTF8 alloc] initWithContentsOfURL: URL];
}

- initWithContentsOfURL: (OFURL*)URL
	       encoding: (of_string_encoding_t)encoding
{
	return (id)[[OFMutableString_UTF8 alloc]
	    initWithContentsOfURL: URL
			 encoding: encoding];
}

- initWithSerialization: (OFXMLElement*)element
{
	return (id)[[OFMutableString_UTF8 alloc]
	    initWithSerialization: element];
}

- retain
{
	return self;
}

- autorelease
{
	return self;
}

- (void)release
{
}

- (void)dealloc
{
	@throw [OFNotImplementedException exceptionWithClass: isa
						    selector: _cmd];
	[super dealloc];	/* Get rid of a stupid warning */
}
@end

@implementation OFMutableString
+ (void)initialize
{
	if (self == [OFMutableString class])
		placeholder.isa = [OFMutableString_placeholder class];
}

+ alloc
{
	if (self == [OFMutableString class])
		return (id)&placeholder;

	return [super alloc];
}

- (void)_applyTable: (const of_unichar_t* const[])table
	   withSize: (size_t)tableSize
{
	OFAutoreleasePool *pool = [[OFAutoreleasePool alloc] init];
	const of_unichar_t *string = [self unicodeString];
	size_t i, length = [self length];

	for (i = 0; i < length; i++) {
		of_unichar_t c = string[i];

		if (c >> 8 < tableSize && table[c >> 8][c & 0xFF])
			[self setCharacter: table[c >> 8][c & 0xFF]
				   atIndex: i];
	}

	[pool release];
}

- (void)setCharacter: (of_unichar_t)character
	     atIndex: (size_t)index
{
	@throw [OFNotImplementedException exceptionWithClass: isa
						    selector: _cmd];
}

- (void)appendUTF8String: (const char*)UTF8String
{
	OFAutoreleasePool *pool = [[OFAutoreleasePool alloc] init];

	[self appendString: [OFString stringWithUTF8String: UTF8String]];

	[pool release];
}

- (void)appendUTF8String: (const char*)UTF8String
	      withLength: (size_t)UTF8StringLength
{
	OFAutoreleasePool *pool = [[OFAutoreleasePool alloc] init];

	[self appendString: [OFString stringWithUTF8String: UTF8String
						    length: UTF8StringLength]];

	[pool release];
}

- (void)appendCString: (const char*)cString
	 withEncoding: (of_string_encoding_t)encoding
{
	OFAutoreleasePool *pool = [[OFAutoreleasePool alloc] init];

	[self appendString: [OFString stringWithCString: cString
					       encoding: encoding]];

	[pool release];
}

- (void)appendCString: (const char*)cString
	 withEncoding: (of_string_encoding_t)encoding
	       length: (size_t)cStringLength
{
	OFAutoreleasePool *pool = [[OFAutoreleasePool alloc] init];

	[self appendString: [OFString stringWithCString: cString
					       encoding: encoding
						 length: cStringLength]];

	[pool release];
}

- (void)appendString: (OFString*)string
{
	return [self insertString: string
			  atIndex: [self length]];
}

- (void)appendFormat: (OFConstantString*)format, ...
{
	va_list arguments;

	va_start(arguments, format);
	[self appendFormat: format
	     withArguments: arguments];
	va_end(arguments);
}

- (void)appendFormat: (OFConstantString*)format
       withArguments: (va_list)arguments
{
	char *UTF8String;
	int UTF8StringLength;

	if (format == nil)
		@throw [OFInvalidArgumentException exceptionWithClass: isa
							     selector: _cmd];

	if ((UTF8StringLength = of_vasprintf(&UTF8String, [format UTF8String],
	    arguments)) == -1)
		@throw [OFInvalidFormatException exceptionWithClass: isa];

	@try {
		[self appendUTF8String: UTF8String
			    withLength: UTF8StringLength];
	} @finally {
		free(UTF8String);
	}
}

- (void)prependString: (OFString*)string
{
	return [self insertString: string
			  atIndex: 0];
}

- (void)reverse
{
	size_t i, j, length = [self length];

	for (i = 0, j = length - 1; i < length / 2; i++, j--) {
		of_unichar_t tmp = [self characterAtIndex: j];
		[self setCharacter: [self characterAtIndex: i]
			   atIndex: j];
		[self setCharacter: tmp
			   atIndex: i];
	}
}

- (void)upper
{
	[self _applyTable: of_unicode_upper_table
		 withSize: OF_UNICODE_UPPER_TABLE_SIZE];
}

- (void)lower
{
	[self _applyTable: of_unicode_lower_table
		 withSize: OF_UNICODE_LOWER_TABLE_SIZE];
}

- (void)insertString: (OFString*)string
	     atIndex: (size_t)index
{
	@throw [OFNotImplementedException exceptionWithClass: isa
						    selector: _cmd];
}

- (void)deleteCharactersInRange: (of_range_t)range
{
	@throw [OFNotImplementedException exceptionWithClass: isa
						    selector: _cmd];
}

- (void)replaceCharactersInRange: (of_range_t)range
		      withString: (OFString*)replacement
{
	[self deleteCharactersInRange: range];
	[self insertString: replacement
		   atIndex: range.start];
}

- (void)replaceOccurrencesOfString: (OFString*)string
			withString: (OFString*)replacement
{
	[self replaceOccurrencesOfString: string
			      withString: replacement
				 inRange: of_range(0, [self length])];
}

- (void)replaceOccurrencesOfString: (OFString*)string
			withString: (OFString*)replacement
			   inRange: (of_range_t)range
{
	OFAutoreleasePool *pool = [[OFAutoreleasePool alloc] init], *pool2;
	const of_unichar_t *unicodeString;
	const of_unichar_t *searchString = [string unicodeString];
	size_t searchLength = [string length];
	size_t replacementLength = [replacement length];
	size_t i;

	if (range.start + range.length > [self length])
		@throw [OFOutOfRangeException exceptionWithClass: isa];

	if (searchLength > range.length) {
		[pool release];
		return;
	}

	pool2 = [[OFAutoreleasePool alloc] init];
	unicodeString = [self unicodeString];

	for (i = range.start; i <= range.length - searchLength; i++) {
		if (memcmp(unicodeString + i, searchString,
		    searchLength * sizeof(of_unichar_t)))
			continue;

		[self replaceCharactersInRange: of_range(i, searchLength)
				    withString: replacement];

		range.length -= searchLength;
		range.length += replacementLength;

		i += replacementLength - 1;

		[pool2 releaseObjects];

		unicodeString = [self unicodeString];
	}

	[pool release];
}

- (void)deleteLeadingWhitespaces
{
	size_t i, length = [self length];

	for (i = 0; i < length; i++) {
		of_unichar_t c = [self characterAtIndex: i];

		if (c != ' '  && c != '\t' && c != '\n' && c != '\r' &&
		    c != '\f')
			break;
	}

	[self deleteCharactersInRange: of_range(0, i)];
}

- (void)deleteTrailingWhitespaces
{
	size_t length = [self length];
	ssize_t i;

	for (i = length - 1; i >= 0; i--) {
		of_unichar_t c = [self characterAtIndex: i];

		if (c != ' '  && c != '\t' && c != '\n' && c != '\r' &&
		    c != '\f')
			break;
	}

	[self deleteCharactersInRange: of_range(i + 1, length - i - 1)];
}

- (void)deleteEnclosingWhitespaces
{
	[self deleteLeadingWhitespaces];
	[self deleteTrailingWhitespaces];
}

- copy
{
	return [[OFString alloc] initWithString: self];
}

- (void)makeImmutable
{
}
@end
