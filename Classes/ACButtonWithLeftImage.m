//
//  ACButtonWithLeftImage.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/19.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACButtonWithLeftImage.h"


@implementation ACButtonWithLeftImage

@synthesize leftImageView;
@synthesize textlabel;

- (id)initWithFrame:(CGRect)Frame
{
	if(self=[super initWithFrame:Frame])
	{
		[self setBackgroundImage:[UIImage imageNamed:@"button-0.png"] forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];

		
		self.leftImageView=[[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
		self.textlabel=[[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
		
		[textlabel setBackgroundColor:[UIColor clearColor]];
		
		[self addSubview:leftImageView];
		[self addSubview:textlabel];
		
	//	[leftImageView release];
	//	[textlabel release];
    
		
	}
	
	return self;
}

- (CGSize)SizeTofit : (NSString *)text  textFont:(UIFont *)textfont 
{
	CGSize maxSize=CGSizeMake(160,40);

	CGSize TextSize = [text sizeWithFont:textfont 
							   constrainedToSize:maxSize
								   lineBreakMode:UILineBreakModeWordWrap];
	
	textlabel.frame = CGRectMake(leftImageView.frame.origin.x+leftImageView.frame.size.width+10,
								 0, 
								 TextSize.width,
								 40);
	textlabel.text=text;
		
	return CGSizeMake(10+leftImageView.frame.size.width +10+textlabel.frame.size.width+10, 40);
	//return CGSizeMake(100,40);
}




@end
