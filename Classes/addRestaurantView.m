//
//  addRestaurantView.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/19.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "addRestaurantView.h"


@implementation addRestaurantView

@synthesize bgImageView;
@synthesize nameLabel;
@synthesize addLabel;
@synthesize phonetextField;
@synthesize addBtn;


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) 
    {
       
    }
    
    return self;
}

- (void)dealloc
{
    [bgImageView release];
    [nameLabel release];
    [addLabel release];
    [phonetextField release];
    [addBtn release];
    
    [super dealloc];
}

@end
