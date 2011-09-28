//
//  missionView.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/13.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "missionView.h"


@implementation missionView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
		imageView.image=[UIImage imageNamed:@"mission-splash-graphic-1.png"];
		[self addSubview:imageView];
		
		mainLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 230, 300, 40)];
		mainLabel.backgroundColor=[UIColor clearColor];
		mainLabel.textAlignment=UITextAlignmentCenter;
		mainLabel.font=[UIFont fontWithName:FONT_BOLD size:14];
		mainLabel.textColor=TEXT_COLOR;
		mainLabel.numberOfLines=2;
		mainLabel.text=LANDING_MISSION_TITLE_STRING;
		[self addSubview:mainLabel];
    }
    return self;
}

- (void)dealloc {
    [imageView release];
	[mainLabel release];
	[super dealloc];
	
}


@end
