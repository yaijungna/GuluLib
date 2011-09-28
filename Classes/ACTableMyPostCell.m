//
//  ACTableMyPostCell.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/19.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACTableMyPostCell.h"


@implementation ACTableMyPostCell

@synthesize likeBtn;
@synthesize commentBtn;
@synthesize moreBtn;

@synthesize labelTitle;
@synthesize labelSubtitle;

@synthesize contentTextView;
@synthesize bigPhotoImageView;
@synthesize bestKnownImageView;

-(void)initCell
{
	[super initCell];
	[self setBackgroundView:nil];

	self.likeBtn=[ACCreateButtonClass createButton:ButtonTypeNumberLikes];
//	CGSize size =  [likeBtn SizeTofit:@"999 likes" textFont:likeBtn.textlabel.font];
//	[likeBtn setFrame:CGRectMake(5, 235, size.width, 45)];
	[self addSubview: likeBtn];

	
	self.commentBtn=[ACCreateButtonClass createButton:ButtonTypeNumberComments];
//	CGSize size2 =  [commentBtn SizeTofit:@"999 comments" textFont:commentBtn.textlabel.font];
//	[commentBtn setFrame:CGRectMake(5+likeBtn.frame.size.width+5, 235, size2.width, 45)];
	[self addSubview: commentBtn];

	
	self.moreBtn=[ACCreateButtonClass createButton:ButtonTypeCellMore];
	[moreBtn setFrame:CGRectMake(320- moreBtn.frame.size.width-5, 280- moreBtn.frame.size.height-15, moreBtn.frame.size.width, moreBtn.frame.size.height)];
	[self addSubview: moreBtn];

	
	[labelTitle setNumberOfLines:1];
	[labelSubtitle setNumberOfLines:2];
	
	[labelTitle setTextColor:TEXT_COLOR];
	[labelSubtitle setTextColor:TEXT_COLOR];
	
	[labelTitle setFont:[UIFont fontWithName:FONT_BOLD size:14]];
	[labelSubtitle setFont:[UIFont fontWithName:FONT_NORMAL size:12]];
	
	[contentTextView setFont:[UIFont fontWithName:FONT_NORMAL size:12]];
	[contentTextView setTextColor:TEXT_COLOR];
	
}


- (void)dealloc {
	
	[likeBtn release];
	[commentBtn release];
	[moreBtn release];
	[labelTitle release];
	[labelSubtitle release];
	[contentTextView release];
	[bigPhotoImageView release];
	[bestKnownImageView release];
	
	
	likeBtn=nil;
	commentBtn=nil;
	moreBtn=nil;
	labelTitle=nil;
	labelSubtitle=nil;
	contentTextView=nil;
	bigPhotoImageView=nil;
	bestKnownImageView=nil;
	
	
    [super dealloc];
}

@end
