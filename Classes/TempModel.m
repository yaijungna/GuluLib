//
//  TempModel.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "TempModel.h"


@implementation TempModel

@synthesize postObj;
@synthesize inviteObj;
@synthesize missionObj;
@synthesize taskObj;

static id sharedMyManager_Temp = nil;

+ (id)sharedManager {
	@synchronized(self){
        if(sharedMyManager_Temp == nil)
            sharedMyManager_Temp = [[super alloc] init];
    }
    return sharedMyManager_Temp;
}

- (id)init {
	
	if(self=[super init])
	{
		
		self.postObj=[[[postModel alloc] init] autorelease];
		
		
		return self;
	}
	return self;
}

- (void) dealloc
{
	[postObj release];
	[inviteObj release];
    [missionObj release];
    [taskObj release];
	[super dealloc];
}



@end
