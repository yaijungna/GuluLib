//
//  GuluHttpRequest.m
//  GULUAPP
//
//  Created by alan on 11/9/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluHttpRequest.h"

@implementation GuluHttpRequest

@synthesize guluTarget;
@synthesize tag;
@synthesize tagObj;


- (void)startAsynchronous
{
    [super startAsynchronous];
}

-(void)cancel
{
    self.delegate=nil;
    [super cancel];   
}


- (void)dealloc
{
    self.guluTarget=nil;
    self.tagObj=nil;
    [super dealloc];
}

@end
