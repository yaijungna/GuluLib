//
//  GuluReviewModel.m
//  GULUAPP
//
//  Created by alan on 11/9/9.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluReviewModel.h"

@implementation GuluReviewModel

@synthesize dish;
@synthesize restaurant;
@synthesize photo;
@synthesize user;

@synthesize content;
@synthesize created; 
@synthesize comment_count;
@synthesize like_count;
@synthesize is_like;
@synthesize thumb;

@synthesize group_id;
@synthesize task_id;


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
    [dish release];
    [restaurant release];
    [photo release];
    [user release];
    [content release];
    
    [group_id release];
    [task_id release];
    
    
    [super dealloc];
}


-(void)switchDataIntoModel:(NSDictionary *)dataDictionary
{
    [super switchDataIntoModel:dataDictionary];
    
    // Because API format problem, we need to set restaurant of dish to self.restaurant.
    // Maybe we will change API JSON format later.
    if(self.dish.restaurant)
    {
        self.restaurant=dish.restaurant;
    }
    
}


@end
