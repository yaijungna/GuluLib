//
//  GuluUserModel.m
//  GULUAPP
//
//  Created by alan on 11/9/9.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluUserModel.h"

@implementation GuluUserModel

@synthesize username;
@synthesize phone;
@synthesize email;
@synthesize about_me;
@synthesize photo;
@synthesize public_comments;

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
    [username release];
    [phone release];
    [email release];
    [about_me release];
    [photo release];
    
    [super dealloc];
}



@end
