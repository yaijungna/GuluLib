//
//  GuluContactModel.m
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluContactModel.h"

@implementation GuluContactModel

@synthesize first_name;
@synthesize last_name;
@synthesize email;
@synthesize profile_pic;
@synthesize gulu_user_id;
@synthesize is_favorited;

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
    [first_name release];
    [last_name release];
    [email release];
    [profile_pic release];
    [gulu_user_id release];
    
    [super dealloc];
}



@end
