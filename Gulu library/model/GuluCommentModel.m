//
//  GuluCommentModel.m
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluCommentModel.h"

@implementation GuluCommentModel

@synthesize  comment;
@synthesize  post_id;
@synthesize  submit_date;
@synthesize  time_ago;
@synthesize  user; 

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
    [comment release];
    [post_id release];
    [user release];
    
    [super dealloc];
}

@end
