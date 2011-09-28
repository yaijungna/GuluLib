//
//  GuluAroundMeModel.m
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluAroundMeModel.h"

@implementation GuluAroundMeModel


@synthesize restaurant;
@synthesize user;
@synthesize photo;
@synthesize like_count;
@synthesize comment_count;
@synthesize time_ago;
@synthesize target_id;
@synthesize target_type;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (void)dealloc
{
    [restaurant release];
    [user release];
    [photo release];
    [target_id release];
    [super dealloc];
}


@end
