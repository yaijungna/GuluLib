//
//  ACTableViewCell.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/8.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACTableViewCell.h"


@implementation ACTableViewCell

@synthesize more;

-(void)initCell
{
//	UIImageView *bgImageView=[[[UIImageView alloc] initWithFrame:self.backgroundView.frame] autorelease];
    UIImageView *bgImageView=[[[UIImageView alloc] init] autorelease];
	bgImageView.image=[UIImage imageNamed:@"large-list-box-1.png"];
	self.backgroundView=bgImageView;
	
    /*
	self.backgroundColor=normal_cell_color;
    self.backgroundColor=[UIColor redColor];
    */
    
	self.more=[[[moreView alloc] initWithFrame:CGRectMake(320, 0, 320, 60)] autorelease];
	[self addSubview:more];
    [self hideMore];
	more.hidden=YES;
}

- (void)setHighlighted: (BOOL)highlighted animated: (BOOL)animated
{
	[super setHighlighted:highlighted animated:animated];
}

- (void)setSelected: (BOOL)selected animated: (BOOL)animated 
{
	//[super setSelected:selected animated:animated];
}

- (void)dealloc {
   // [more release];
    [super dealloc];
}

-(void)customizeLabel_title :(UILabel *) label
{
	[label setBackgroundColor:[UIColor clearColor]];
	[label setFont:[UIFont fontWithName:FONT_BOLD size:14]];
	[label setTextColor:TEXT_COLOR];
}

-(void)customizeLabel_subtitle :(UILabel *) label
{
	[label setBackgroundColor:[UIColor clearColor]];
	[label setFont:[UIFont fontWithName:FONT_NORMAL size:14]];
	[label setTextColor:[UIColor grayColor]];
}

-(void)showMore
{
	more.hidden=NO;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	CGRect Frame=CGRectMake(0, self.frame.size.height-more.frame.size.height, more.frame.size.width ,more.frame.size.height );
	more.frame=Frame;
	[more layoutSubviews];
	[UIView commitAnimations];
}

-(void)hideMore
{
	more.hidden=NO;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	CGRect Frame=CGRectMake(320, self.frame.size.height-more.frame.size.height, more.frame.size.width ,more.frame.size.height );
	more.frame=Frame;
	[more layoutSubviews];
	[UIView commitAnimations];
}


@end
