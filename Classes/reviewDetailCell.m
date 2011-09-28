//
//  reviewDetailCell.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/5.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "reviewDetailCell.h"


@implementation reviewDetailCell

@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize label4;
@synthesize Imageview;
@synthesize  aboutTextView;
@synthesize  aboutlabel;

-(void)initCell
{
	[super initCell];    
    self.backgroundView=nil;
    aboutlabel.numberOfLines=0;
    aboutlabel.lineBreakMode=UILineBreakModeWordWrap;
    aboutlabel.font= [UIFont fontWithName:FONT_NORMAL size:12];
}

- (void)sizeToFitCell :(NSString *)text
{
    UIFont *font = [UIFont fontWithName:FONT_NORMAL size:12];
    
    CGSize size = [text sizeWithFont:font
                            constrainedToSize:CGSizeMake(260, 1000)
                                lineBreakMode:UILineBreakModeWordWrap];
   /* 
    if (size.height<40) {
        size.height=40;
    }
    */
    
   // aboutTextView.frame=CGRectMake(20,300 , 260,size.height) ;
    aboutlabel.frame=CGRectMake(20,300 , 260,size.height) ;
    	
}


- (void)setHighlighted: (BOOL)highlighted animated: (BOOL)animated
{
	
}

- (void)setSelected: (BOOL)selected animated: (BOOL)animated 
{
	
}


- (void)dealloc {
    [label1 release];
    [label2 release];
    [label3 release];
    [label4 release];
    [aboutlabel release];
    [Imageview release];
	
    [aboutTextView release];
    [super dealloc];
}



@end
