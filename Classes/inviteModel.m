//
//  inviteModel.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/22.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "inviteModel.h"


@implementation inviteModel

@synthesize eid;
@synthesize restaurantDict;
@synthesize dateString;
@synthesize EventTitle;
@synthesize contactDict;


- (id)init {
	
	if(self=[super init])
	{
		
	}
	return self;
}


- (void) dealloc
{
	[eid release];
	[dateString release];
	[restaurantDict release];
	[EventTitle release];
	[contactDict release];
	[super dealloc];
}

@end
