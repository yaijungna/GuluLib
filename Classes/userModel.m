//
//  userModel.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "userModel.h"

@implementation userModel

@synthesize myLocation,username,email,userPicture,userDictionary,uid;

- (id)init 
{
	if(self=[super init])
	{
		
	}
	return self;
}

- (void) dealloc
{
	[myLocation release];myLocation=nil;
	[username release];username=nil;
	[email release];email=nil;
	[uid release];uid=nil;
	[userPicture release];userPicture=nil;
	[userDictionary release];userDictionary=nil;
	[super dealloc];
}

@end
