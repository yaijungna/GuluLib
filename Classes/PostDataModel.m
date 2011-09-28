
//
//  PostDataModel.m
//  GULUAPP
//
//  Created by alan on 11/9/1.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "PostDataModel.h"

@implementation PostDataModel

@synthesize todoid;
@synthesize taskid, groupid;
@synthesize isThumb , isGuluapproved ;
@synthesize photo,restaurantDict,dishDict,photoDict,review;
@synthesize bestKnownFor;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (void) dealloc
{
	[photo release];
	[restaurantDict release];
	[dishDict release];
	[photoDict release];
	[review release];
	[bestKnownFor release];
    
	[todoid release];
    [taskid release];
    [groupid release];
    
	[super dealloc];
}


@end
