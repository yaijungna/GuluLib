//
//  ACTableOneLineWithImage_Checkbox_Cell.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/22.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACTableOneLineWithImage_Checkbox_Cell.h"


@implementation ACTableOneLineWithImage_Checkbox_Cell


@synthesize label1;
@synthesize leftImageview;
@synthesize checkBox;


-(void)initCell
{
	[super initCell];
	self.backgroundView=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"large-list-box-1.png"]] autorelease];
	[self customizeLabel_title:label1];
	
	
	checkBox=[[ACCheckBox alloc] initWithFrame:CGRectMake(10, 14, 22, 22)];	
	[self addSubview:checkBox];
}





- (void)dealloc {
	[label1 release];
	[leftImageview release];
	[checkBox release];
	
    [super dealloc];
}



@end
