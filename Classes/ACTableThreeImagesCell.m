//
//  ACTableThreeImagesCell.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/16.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACTableThreeImagesCell.h"


@implementation ACTableThreeImagesCell

@synthesize leftBtn;
@synthesize middleBtn;
@synthesize rightBtn;
@synthesize label1;
@synthesize label2;
@synthesize label3;


-(void)initCell
{
	[super initCell];
	
	[self customizeLabel_title:label1];
	[label1 setTextAlignment:UITextAlignmentCenter];
	[self customizeLabel_title:label2];
	[label2 setTextAlignment:UITextAlignmentCenter];
	[self customizeLabel_title:label3];
	[label3 setTextAlignment:UITextAlignmentCenter];
	[self setBackgroundView:nil];
	
}

-(void)showIndexOfBtn :(NSInteger)index
{
	if(index==1)
	{
		leftBtn.hidden=NO;
		label1.hidden=NO;
		imageView1.hidden=NO;
	}
	else if(index==2)
	{
		middleBtn.hidden=NO;
		label2.hidden=NO;
		imageView2.hidden=NO;
	}
	else if(index==3)
	{
		rightBtn.hidden=NO;
		label3.hidden=NO;
		imageView3.hidden=NO;
	}
}

-(void)hideIndexOfBtn :(NSInteger)index
{
	if(index==1)
	{
		leftBtn.hidden=YES;
		label1.hidden=YES;
		imageView1.hidden=YES;
	}
	else if(index==2)
	{
		middleBtn.hidden=YES;
		label2.hidden=YES;
		imageView2.hidden=YES;
	}
	else if(index==3)
	{
		rightBtn.hidden=YES;
		label3.hidden=YES;
		imageView3.hidden=YES;
	}
}



- (void)dealloc {
	[leftBtn release];
	[middleBtn release];
	[rightBtn release];
	[label1 release];
	[label2 release];
	[label3 release];
	
    [super dealloc];
}



@end
