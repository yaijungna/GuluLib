//
//  settingsModel.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/27.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "settingsModel.h"

@implementation settingsModel

@synthesize myLocation;

static id sharedMyManager_settings = nil;

+ (id)sharedManager {
	@synchronized(self){
        if(sharedMyManager_settings == nil)
            sharedMyManager_settings = [[super alloc] init];
    }
    return sharedMyManager_settings;
}


- (id)init {
	
	if(self=[super init])
	{
		
	}
	return self;
}

- (void) dealloc
{
	[myLocation release];myLocation=nil;
	[super dealloc];
}

@end
