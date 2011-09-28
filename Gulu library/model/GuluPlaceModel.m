//
//  GuluPlaceModel.m
//  GULUAPP
//
//  Created by alan on 11/9/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluPlaceModel.h"

@implementation GuluPlaceModel

@synthesize name;
@synthesize address;
@synthesize city;
@synthesize district;
@synthesize get_follower_count;
@synthesize get_review_num;
@synthesize is_gulu_approved;
@synthesize phone;
@synthesize photo;
@synthesize score;

@synthesize longitude;
@synthesize latitude;

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
    [name release];
    [address release];
    [city release];
    [district release];
    [get_review_num release];
    [get_follower_count release];
    [phone release];
    [photo release];
    [score release];
    
    [best_known release];
    
    [super dealloc];
    
}


@end



