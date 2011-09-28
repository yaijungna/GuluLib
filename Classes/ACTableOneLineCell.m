//
//  ACTableOneLineCell.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/8.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACTableOneLineCell.h"


@implementation ACTableOneLineCell

@synthesize rightBtn,label1,label2;

-(void)initCell
{
	[super initCell];
	rightBtn.userInteractionEnabled=NO;	
	[self customizeLabel_title:label1];

}

- (void)dealloc {
	[rightBtn release];
	[label1 release];
    [label2 release];
    [super dealloc];
}


@end
