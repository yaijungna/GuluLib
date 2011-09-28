//
//  taskModel.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/1.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "taskModel.h"


@implementation taskModel


@synthesize taskTitle;
@synthesize taskAbout;
@synthesize taskPhoto;


@synthesize restaurantDict;
@synthesize photoDict;
@synthesize dishDict;

@synthesize showPlace;
@synthesize showDish;
@synthesize showNext;

@synthesize isChangePhoto;


- (id)init {
	
	if(self=[super init])
	{
        showPlace=@"";
        showDish=@"";
        showNext=@"";
		
	}
	return self;
}


- (void) dealloc
{
    [taskTitle release];
    [taskAbout release];
    [taskPhoto release];
    [restaurantDict release];
    [dishDict release];
    [photoDict release];
    
    [showPlace release];
    [showDish release];
    [showNext release];
    
	[super dealloc];
}


@end
