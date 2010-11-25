/*
 * Copyright (c) 2008 - 2010
 *   Jonathan Schleifer <js@webkeks.org>
 *
 * All rights reserved.
 *
 * This file is part of ObjFW. It may be distributed under the terms of the
 * Q Public License 1.0, which can be found in the file LICENSE included in
 * the packaging of this file.
 */

#include "config.h"

#import "OFList.h"
#import "OFAutoreleasePool.h"
#import "OFString.h"
#import "OFExceptions.h"

#import "TestsAppDelegate.h"

static OFString *module = @"OFList";
static OFString *strings[] = {
	@"Foo",
	@"Bar",
	@"Baz"
};

@implementation TestsAppDelegate (OFListTests)
- (void)listTests
{
	OFAutoreleasePool *pool = [[OFAutoreleasePool alloc] init];
	OFList *list;
	OFEnumerator *enumerator;
	of_list_object_t *loe;
	OFString *obj;
	size_t i;
	BOOL ok;

	TEST(@"+[list]", (list = [OFList list]))

	TEST(@"-[appendObject:]", [list appendObject: strings[0]] &&
	    [list appendObject: strings[1]] && [list appendObject: strings[2]])

	TEST(@"-[firstListObject]",
	    [[list firstListObject]->object isEqual: strings[0]])

	TEST(@"-[firstListObject]->next",
	    [[list firstListObject]->next->object isEqual: strings[1]])

	TEST(@"-[lastListObject]",
	    [[list lastListObject]->object isEqual: strings[2]])

	TEST(@"-[lastListObject]->prev",
	    [[list lastListObject]->prev->object isEqual: strings[1]])

	TEST(@"-[removeListObject:]",
	    R([list removeListObject: [list lastListObject]]) &&
	    [[list lastListObject]->object isEqual: strings[1]] &&
	    R([list removeListObject: [list firstListObject]]) &&
	    [[list firstListObject]->object isEqual:
	    [list lastListObject]->object])

	TEST(@"-[insertObject:beforeListObject:]",
	    [list insertObject: strings[0]
	      beforeListObject: [list lastListObject]] &&
	    [[list lastListObject]->prev->object isEqual: strings[0]])

	TEST(@"-[insertObject:afterListObject:]",
	    [list insertObject: strings[2]
	       afterListObject: [list firstListObject]->next] &&
	    [[list lastListObject]->object isEqual: strings[2]])

	TEST(@"-[count]", [list count] == 3)

	TEST(@"-[copy]", (list = [[list copy] autorelease]) &&
	    [[list firstListObject]->object isEqual: strings[0]] &&
	    [[list firstListObject]->next->object isEqual: strings[1]] &&
	    [[list lastListObject]->object isEqual: strings[2]])

	TEST(@"-[isEqual:]", [list isEqual: [[list copy] autorelease]])

	TEST(@"-[description]",
	    [[list description] isEqual: @"[Foo, Bar, Baz]"])

	TEST(@"-[objectEnumerator]", (enumerator = [list objectEnumerator]))

	loe = [list firstListObject];
	i = 0;
	ok = YES;
	while ((obj = [enumerator nextObject]) != nil) {
		if (![obj isEqual: loe->object])
			ok = NO;

		loe = loe->next;
		i++;
	}

	if ([list count] != i)
		ok = NO;

	TEST(@"OFEnumerator's -[nextObject]", ok);

	[enumerator reset];
	[list removeListObject: [list firstListObject]];

	EXPECT_EXCEPTION(@"Detection of mutation during enumeration",
	    OFEnumerationMutationException, [enumerator nextObject])

	[list prependObject: strings[0]];

#ifdef OF_HAVE_FAST_ENUMERATION
	loe = [list firstListObject];
	i = 0;
	ok = YES;

	for (OFString *obj in list) {
		if (![obj isEqual: loe->object])
			ok = NO;

		loe = loe->next;
		i++;
	}

	if ([list count] != i)
		ok = NO;

	TEST(@"Fast Enumeration", ok)

	ok = NO;
	@try {
		for (OFString *obj in list)
			[list removeListObject: [list lastListObject]];
	} @catch (OFEnumerationMutationException *e) {
		ok = YES;
		[e dealloc];
	}

	TEST(@"Detection of mutation during Fast Enumeration", ok)
#endif

	[pool drain];
}
@end
