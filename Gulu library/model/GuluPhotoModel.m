//
//  GuluPhotoModel.m
//  GULUAPP
//
//  Created by alan on 11/9/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluPhotoModel.h"

@implementation GuluPhotoModel


@synthesize get_photo_url;
@synthesize image_large;
@synthesize image_medium;
@synthesize image_small;
@synthesize target_id; 
@synthesize target_type;


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
    
    [get_photo_url release];
    [image_large release];
    [image_medium release];
    [image_small release];
    [target_id release];
    [target_type release];
    
    [super dealloc];
}


@end
