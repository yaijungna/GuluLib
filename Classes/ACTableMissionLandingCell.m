//
//  ACTableMissionLandingCell.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/29.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "ACTableMissionLandingCell.h"


@implementation ACTableMissionLandingCell


@synthesize labelTitle;
@synthesize labelSubTitle;
@synthesize leftImageview;
@synthesize rightImageview;

-(void)initCell
{
	[super initCell];
    UIImageView *bg=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"large-list-box-1.png"]] autorelease];
	[self setBackgroundView:bg];
	/*
	self.likeBtn=[ACCreateButtonClass createButton:ButtonTypeNumberLikes];
	//	CGSize size =  [likeBtn SizeTofit:@"999 likes" textFont:likeBtn.textlabel.font];
	//	[likeBtn setFrame:CGRectMake(5, 235, size.width, 45)];
	[self addSubview: likeBtn];
	[likeBtn release];
	
	self.commentBtn=[ACCreateButtonClass createButton:ButtonTypeNumberComments];
	//	CGSize size2 =  [commentBtn SizeTofit:@"999 comments" textFont:commentBtn.textlabel.font];
	//	[commentBtn setFrame:CGRectMake(5+likeBtn.frame.size.width+5, 235, size2.width, 45)];
	[self addSubview: commentBtn];
	[commentBtn release];
	
	self.moreBtn=[ACCreateButtonClass createButton:ButtonTypeCellMore];
	[moreBtn setFrame:CGRectMake(320- moreBtn.frame.size.width-5, 380- moreBtn.frame.size.height-15, moreBtn.frame.size.width, moreBtn.frame.size.height)];
	[self addSubview: moreBtn];
	[moreBtn release];
	
	[labelTitle setNumberOfLines:1];
    
	[labelTitle setTextColor:TEXT_COLOR];
    
	
	[labelTitle setFont:[UIFont fontWithName:FONT_BOLD size:14]];*/
}


- (void)dealloc {
    [labelTitle release];
    [labelSubTitle release];
	[leftImageview release];
    [rightImageview release];
    
    [super dealloc];
}

@end
