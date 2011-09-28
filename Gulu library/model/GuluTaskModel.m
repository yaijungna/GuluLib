//
//  GuluTaskModel.m
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluTaskModel.h"

@implementation GuluTaskModel

@synthesize title;
@synthesize main_pic;
@synthesize description;
@synthesize dish;
@synthesize restaurant;
@synthesize show_dish;
@synthesize show_place;
@synthesize show_next;
@synthesize status;

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
    [title release];
    [main_pic release];
    [description release];
    [dish release];
    [restaurant release];
    
    [super dealloc];
}

@end
