//
//  searchView.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/13.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "searchView.h"


@implementation searchView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
		imageView.image=[UIImage imageNamed:@"search-splash-graphic-1.png"];
		[self addSubview:imageView];
		
   		mainLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 230, 300, 40)];
		mainLabel.backgroundColor=[UIColor clearColor];
		mainLabel.textAlignment=UITextAlignmentCenter;
		mainLabel.font=[UIFont fontWithName:FONT_BOLD size:14];
		mainLabel.textColor=TEXT_COLOR;
		mainLabel.numberOfLines=2;
		mainLabel.text=LANDING_SEARCH_TITLE_STRING;
		[self addSubview:mainLabel];
		
		label1=[[UILabel alloc] initWithFrame:CGRectMake(180, 45, 90, 40)];
		label1.backgroundColor=[UIColor clearColor];
		label1.textAlignment=UITextAlignmentCenter;
		label1.font=[UIFont fontWithName:FONT_BOLD size:20];
		label1.textColor=TEXT_COLOR;
		label1.numberOfLines=1;
		label1.text=LANDING_SEARCH_PHOTO_STRING;
		[self addSubview:label1];
		
		
		
    }
    return self;
}

- (void)dealloc {
    [imageView release];
	[mainLabel release];
	[label1 release];
	[super dealloc];
	
}


@end
