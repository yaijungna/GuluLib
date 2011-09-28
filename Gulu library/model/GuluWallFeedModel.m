//
//  GuluWallFeedModel.m
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluWallFeedModel.h"

@implementation GuluWallFeedModel

@synthesize object;
@synthesize objectModel;
@synthesize type;

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
    [object release];
    [objectModel release];
    
    [super dealloc];
}



@end
