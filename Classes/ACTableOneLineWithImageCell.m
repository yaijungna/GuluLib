//
//  ACTableOneLineWithImageCell.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/19.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACTableOneLineWithImageCell.h"


@implementation ACTableOneLineWithImageCell

@synthesize rightImageview;
@synthesize label1;
@synthesize leftImageview;
@synthesize isExpand;
@synthesize switcher;


-(void)initCell
{
	[super initCell];
	//self.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"large-list-box-1.png"]];
	[self customizeLabel_title:label1];
}


-(void)setRightImageDown
{
	[UIView beginAnimations:nil context:NULL];
	[rightImageview layer].transform = CATransform3DMakeRotation(M_PI * 0.5, 0, 0, 1);
	[UIView commitAnimations];
}

-(void)setRightImageRight
{
	[UIView beginAnimations:nil context:NULL];
	[rightImageview layer].transform = CATransform3DMakeRotation(M_PI*0, 0, 0, 1);
	[UIView commitAnimations];
	
}

-(void) setArrowDirection
{
	if(isExpand)
	{
		[self setRightImageRight];
		isExpand=NO;
	}
	else
	{
		[self setRightImageDown];
		isExpand=YES;
	}

		
}


- (void)dealloc {
	[rightImageview release];
	[label1 release];
	[leftImageview release];
	[switcher release];
	
    [super dealloc];
}



@end
