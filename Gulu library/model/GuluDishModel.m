//
//  GuluDishModel.m
//  GULUAPP
//
//  Created by alan on 11/9/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluDishModel.h"

@implementation GuluDishModel

@synthesize restaurant;
@synthesize photo;
@synthesize user;
@synthesize name;
@synthesize best_known;

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
    [photo release];
    [user release];
    [name release];
    
    [best_known release];
    
    [super dealloc];
    
}

@end
