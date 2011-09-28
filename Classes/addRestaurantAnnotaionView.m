//
//  addRestaurantAnnotaionView.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/10.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "addRestaurantAnnotaionView.h"


@implementation addRestaurantAnnotaionView

@synthesize nameLabel;
@synthesize phoneTextField;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self)
	{
		nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width*0.4, frame.size.height)];
		[self addSubview:nameLabel];
		nameLabel.backgroundColor=[UIColor clearColor];
		nameLabel.textColor=[UIColor whiteColor];
		nameLabel.font=[UIFont fontWithName:FONT_NORMAL size:12];
		nameLabel.numberOfLines=2;
		nameLabel.textAlignment=UITextAlignmentCenter;
		
		phoneTextField=[[UITextField alloc] initWithFrame:CGRectMake(frame.size.width*0.4+3, 0, frame.size.width*0.6, frame.size.height)];
		[self addSubview:phoneTextField];
		
    }
    return self;
}

- (void)dealloc {
	[nameLabel release];
	[phoneTextField release];
    [super dealloc];
}


@end
