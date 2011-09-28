//
//  ACTableTwoLinesWithImageCell.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/15.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACTableTwoLinesWithImageCell.h"


@implementation ACTableTwoLinesWithImageCell

@synthesize rightBtn;
@synthesize label1;
@synthesize label2;
@synthesize leftImageview;
@synthesize rightViewImage;


-(void)initCell
{
	rightViewImage=[[UIImageView alloc] initWithFrame:CGRectMake(285, 20, 25, 20)];
	rightViewImage.image=[UIImage imageNamed:@"more-icon-1.png"];
	[self addSubview:rightViewImage];
	
	[super initCell];
	
	[self customizeLabel_title:label1];
	[self customizeLabel_subtitle:label2];
	

	
}

-(void)setRightBtnImage : (UIImage *)img
{
	[rightBtn setBackgroundImage:img forState:UIControlStateNormal];
}

-(void)setRightBtnToMoretype
{
    rightViewImage.hidden=NO;
	[self setRightBtnImage:nil];
	[rightBtn setFrame:CGRectMake(280, 5, 40, 50)];
}

-(void)setRightBtnToNormaltype
{
	[self setRightBtnImage:[UIImage imageNamed:@"table-cell-arrow.png"]];
	[rightBtn setFrame:CGRectMake(290, 20, 20, 20)];
	rightViewImage.hidden=YES;
	
}

- (void)dealloc {
	[rightBtn release];
	[label1 release];
	[label2 release];
	[leftImageview release];
    [rightViewImage release];
	
    [super dealloc];
}



@end
