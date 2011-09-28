//
//  notifyCell.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "notifyCell.h"


@implementation notifyCell


@synthesize label1;
@synthesize label2;
@synthesize leftImageview;
@synthesize yesBtn;
@synthesize noBtn;


-(void)initCell
{
	[super initCell];
	
	[self customizeLabel_title:label1];
	[self customizeLabel_subtitle:label2];
    
    label1.font=notify_text_font;
    label2.font=notify_text_font;
    
    label1.numberOfLines=0;
    label1.lineBreakMode=UILineBreakModeWordWrap;
	[label1 setTextAlignment:UITextAlignmentLeft];
    
    self.yesBtn=[ACCreateButtonClass createButton:ButtonTypeNormal];
    self.noBtn=[ACCreateButtonClass createButton:ButtonTypeNormal];
    
    [self addSubview:yesBtn];
    [self addSubview:noBtn];
    
    [yesBtn setTitle:GLOBAL_YES_STRING forState:UIControlStateNormal];
    [noBtn setTitle:GLOBAL_NO_STRING forState:UIControlStateNormal];
    
    yesBtn.frame=CGRectMake(160, 0, yesBtn.frame.size.width, yesBtn.frame.size.height);
    noBtn.frame=CGRectMake(235, 0, noBtn.frame.size.width, noBtn.frame.size.height);
    
    yesBtn.hidden=YES;
    noBtn.hidden=YES;
    
}

-(void)sizeToFitTitle
{
    CGSize maxSize = CGSizeMake(225, 2000);
	
	CGSize TextSize = [label1.text  sizeWithFont:notify_text_font
                                     constrainedToSize:maxSize 
                                         lineBreakMode:UILineBreakModeWordWrap];
	if(TextSize.height<35)
		TextSize.height=35;
	
	label1.frame=CGRectMake(label1.frame.origin.x, 0, TextSize.width, TextSize.height);	
    label2.frame=CGRectMake(label2.frame.origin.x, label1.frame.size.height, 
                            label2.frame.size.width,  label2.frame.size.height);
    
    
    
}

-(void)showYesNoBtn
{
    yesBtn.frame=CGRectMake(160, label2.frame.origin.y+label2.frame.size.height+3, yesBtn.frame.size.width, yesBtn.frame.size.height);
    noBtn.frame=CGRectMake(235, label2.frame.origin.y+label2.frame.size.height+3, noBtn.frame.size.width, noBtn.frame.size.height);
    
    yesBtn.hidden=NO;
    noBtn.hidden=NO;
}

-(void)hideYesNoBtn
{
    
    
    yesBtn.hidden=YES;
    noBtn.hidden=YES; 
}

- (void)dealloc {
	[noBtn release];
    [yesBtn release];
	[label1 release];
	[label2 release];
	[leftImageview release];
	
    [super dealloc];
}



@end
