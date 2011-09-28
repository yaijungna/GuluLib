//
//  GuluTaskReviewModel.m
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluTaskReviewModel.h"

@implementation GuluTaskReviewModel

@synthesize group_task_id;
@synthesize task_title;
@synthesize review_photo;
@synthesize review_creator;
@synthesize review_content;

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
    [group_task_id release];
    [task_title release];
    [review_photo release];
    [review_creator release];
    [review_content release];
    
    [super dealloc];
}


@end
