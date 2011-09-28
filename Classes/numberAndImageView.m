//
//  numberAndImageView.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/13.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "numberAndImageView.h"


@implementation numberAndImageView

@synthesize numberLabel,btn;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
		self.numberLabel=[[[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height/2-15, 30, 30)] autorelease];
		[numberLabel setTextColor:TEXT_COLOR];
		[numberLabel setFont:[UIFont fontWithName:FONT_BOLD size:20]];
		[numberLabel setTextAlignment:UITextAlignmentCenter];
		[numberLabel setBackgroundColor:[UIColor clearColor]];
		[self addSubview:numberLabel];
		//[numberLabel release];
		
		self.btn=[[[UIButton alloc] initWithFrame:CGRectMake(40, frame.size.height/2-22, 140, 45)] autorelease];
		[self addSubview:btn];
		//[btn release];
		
	}
    return self;
}

- (void)dealloc {
	[numberLabel release];
	[btn release];
    [super dealloc];
}


@end
