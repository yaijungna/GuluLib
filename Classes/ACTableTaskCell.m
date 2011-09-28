//
//  ACTableTaskCell.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "ACTableTaskCell.h"


@implementation ACTableTaskCell
@synthesize label1;
@synthesize label2;
@synthesize leftImageview;
@synthesize aboutTextView;
@synthesize bgView;
@synthesize checkBoxBtn;


-(void)initCell
{
	[super initCell];
	[self customizeLabel_title:label1];
    
    checkBoxBtn=[[ACCheckBox alloc] initWithFrame:CGRectMake(5,65-12 , 24 , 24)];
    [self addSubview: checkBoxBtn];
}


- (void)dealloc {

	[label1 release];
    [label2 release];
    [aboutTextView release];
	[leftImageview release];
    [bgView release];
    [checkBoxBtn release];
	
    [super dealloc];
}



@end
