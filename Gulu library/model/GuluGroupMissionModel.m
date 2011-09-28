//
//  GuluGroupMissionModel.m
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluGroupMissionModel.h"

@implementation GuluGroupMissionModel

@synthesize task_reviews;
@synthesize attend_users;


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
    [task_reviews release];
    [attend_users release];
    
    [super dealloc];
}

@end
