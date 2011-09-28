//
//  GuluErrorMessageModel.m
//  GULUAPP
//
//  Created by alan on 11/9/14.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluErrorMessageModel.h"

@implementation GuluErrorMessageModel

@synthesize error;
@synthesize errorMessage;

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
    [error release];
    [errorMessage release];
    [super dealloc];
}



@end
