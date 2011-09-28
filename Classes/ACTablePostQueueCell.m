//
//  ACTablePostQueueCell.m
//  GULUAPP
//
//  Created by alan on 11/9/5.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "ACTablePostQueueCell.h"

@implementation ACTablePostQueueCell

@synthesize label;
@synthesize leftImageview;

@synthesize  btn1;

@synthesize  progress;
@synthesize  spinner;


-(void)initCell
{
	[super initCell];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"more-icon-1.png"] forState:UIControlStateNormal];
    label.hidden=NO;
    progress.hidden=YES;
    progress.progress=0.0;
    [spinner stopAnimating];

}

-(void)progresReadyToStart
{
    label.hidden=YES;
    progress.hidden=NO;
    btn1.hidden=YES;
    [spinner startAnimating];
    progress.progress=0.0;
    
}

-(void)progresFinish
{
    label.hidden=NO;
    progress.hidden=YES;
    btn1.hidden=NO;
    [spinner stopAnimating];
    progress.progress=1.0;
}



- (void)dealloc
{

	[label release];
	[leftImageview release];
    [btn1 release];
    
    [progress release];
    
    [spinner release];
	
    [super dealloc];
}



@end
