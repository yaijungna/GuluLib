//
//  ACCheckBox.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/10.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACCheckBox.h"


@implementation ACCheckBox


@synthesize normalImage,selectedImage;

- (id)initWithFrame:(CGRect)Frame
{
	if(self=[super initWithFrame:Frame])
	{
		[self setBackgroundImage:[UIImage imageNamed:@"unselected-bubble-1.png"] forState:UIControlStateNormal];
		[self setBackgroundImage:[UIImage imageNamed:@"selected-bubble-1.png"] forState:UIControlStateSelected];
		[self addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	return self;
}

- (void)initBtn
{
	
	[self setBackgroundImage:[UIImage imageNamed:@"unselected-bubble-1.png"] forState:UIControlStateNormal];
	[self setBackgroundImage:[UIImage imageNamed:@"selected-bubble-1.png"] forState:UIControlStateSelected];
	[self addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)dealloc {

	[selectedImage release];
	[normalImage release];
    [super dealloc];
}

- (void)tapButton:(UIButton *) btn 
{
	btn.selected = !btn.selected;
}

@end
