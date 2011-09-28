//
//  chatView.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/13.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "chatView.h"


@implementation chatView



- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
		imageView.image=[UIImage imageNamed:@"chat-splash-graphic-1.png"];
		[self addSubview:imageView];
		
		mainLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 230, 300, 40)];
		mainLabel.backgroundColor=[UIColor clearColor];
		mainLabel.textAlignment=UITextAlignmentCenter;
		mainLabel.font=[UIFont fontWithName:FONT_BOLD size:14];
		mainLabel.textColor=TEXT_COLOR;
		mainLabel.numberOfLines=2;
		mainLabel.text=LANDING_CHAT_TITLE_STRING;
		[self addSubview:mainLabel];
		
		label1=[[UILabel alloc] initWithFrame:CGRectMake(30, 45, 60, 40)];
		label1.backgroundColor=[UIColor clearColor];
		label1.textAlignment=UITextAlignmentCenter;
		label1.font=[UIFont fontWithName:FONT_BOLD size:14];
		label1.textColor=TEXT_COLOR;
		label1.numberOfLines=2;
		label1.text=LANDING_CHAT_PHOTO1_STRING;
		[self addSubview:label1];

		label2=[[UILabel alloc] initWithFrame:CGRectMake(87, 27, 90, 40)];
		label2.backgroundColor=[UIColor clearColor];
		label2.textAlignment=UITextAlignmentCenter;
		label2.font=[UIFont fontWithName:FONT_BOLD size:12];
		label2.textColor=TEXT_COLOR;
		label2.numberOfLines=2;
		label2.text=LANDING_CHAT_PHOTO2_STRING;
		[self addSubview:label2];

		label3=[[UILabel alloc] initWithFrame:CGRectMake(58, 82, 90, 40)];
		label3.backgroundColor=[UIColor clearColor];
		label3.textAlignment=UITextAlignmentCenter;
		label3.font=[UIFont fontWithName:FONT_BOLD size:14];
		label3.textColor=TEXT_COLOR;
		label3.numberOfLines=2;
		label3.text=LANDING_CHAT_PHOTO3_STRING;
		[self addSubview:label3];

    }
    return self;
}

- (void)dealloc {
    [imageView release];
	[mainLabel release];
	[label1 release];
	[label2 release];
	[label3 release];
	[super dealloc];
	
}


@end
