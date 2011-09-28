//
//  ACCommentCell.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/4.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "ACCommentCell.h"


@implementation ACCommentCell

@synthesize leftImageview;
@synthesize labelTitle;
@synthesize labelContent;
@synthesize timelabel;
@synthesize bgImgView;

-(void)initCell
{
	[super initCell];
   
    self.backgroundView=nil;
    
    [bgImgView setBackgroundColor:lightBrownColor];
    bgImgView.layer.cornerRadius=5.0;
    bgImgView.alpha=0.7;
    
    [labelContent setLineBreakMode:UILineBreakModeWordWrap];
    labelContent.numberOfLines=0;
    labelContent.font = [UIFont fontWithName:FONT_NORMAL size:12];
    
    [timelabel setTextAlignment:UITextAlignmentRight];
    timelabel.font=[UIFont fontWithName:FONT_NORMAL size:12];
    timelabel.textColor=[UIColor lightGrayColor];


}

- (void)sizeToFitCell 
{
    NSString *contentString=labelContent.text;
    
    UIFont *font = [UIFont fontWithName:FONT_NORMAL size:12];
    
    CGSize size = [contentString sizeWithFont:font
                            constrainedToSize:CGSizeMake(220, 1000)
                                lineBreakMode:UILineBreakModeWordWrap];
    
    if (size.height<35) {
        size.height=35;
    }
    
    float height=5+20+size.height;
    
    labelContent.frame=CGRectMake(60, 25, 220, size.height);
    bgImgView.frame=CGRectMake(0, 0, 300, height+25);
    
    timelabel.frame=CGRectMake(10, height, 280 , 25);
	
}

- (void)setHighlighted: (BOOL)highlighted animated: (BOOL)animated
{
	
}

- (void)setSelected: (BOOL)selected animated: (BOOL)animated 
{
	
}



- (void)dealloc {
	[leftImageview release];
	[labelTitle release];
    [labelContent release];
    [timelabel release];
	
    [super dealloc];
}



@end
