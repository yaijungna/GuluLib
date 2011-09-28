//
//  ACTableAroundMeCell.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/19.
//  Copyright 2011 Gulu.com. All rights reserved.
//


#import "ACTableAroundMeCell.h"


@implementation ACTableAroundMeCell

@synthesize likeBtn;
@synthesize commentBtn;
@synthesize moreBtn;

@synthesize firstBtn;
@synthesize secondBtn;
@synthesize atlabel;

@synthesize reviewlabel;

@synthesize bigPhotoImageView;

@synthesize dishName;
@synthesize placeName;
@synthesize review;

@synthesize rightViewImage;


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
    
    self.rightViewImage=[[[UIImageView alloc] initWithFrame:CGRectMake(280, 310, 25, 20)] autorelease];
	rightViewImage.image=[UIImage imageNamed:@"more-icon-1.png"];
    [self insertSubview:rightViewImage belowSubview:moreBtn];
        
    [self bringSubviewToFront:more];

}



-(NSInteger)sizeToFitTitle
{
    
    [firstBtn.titleLabel setLineBreakMode:UILineBreakModeTailTruncation];
    [secondBtn.titleLabel setLineBreakMode:UILineBreakModeTailTruncation];
    
    [firstBtn.titleLabel setTextAlignment:UITextAlignmentCenter];
    [secondBtn.titleLabel setTextAlignment:UITextAlignmentCenter];
    
    [firstBtn.titleLabel setNumberOfLines:1];
    [secondBtn.titleLabel setNumberOfLines:1];
    
    [firstBtn.titleLabel setFont:AROUNDME_TEXT_FONT];
    [secondBtn.titleLabel setFont:AROUNDME_TEXT_FONT];
    
    [firstBtn setTitleColor:BLUE_TEXT_COLOR forState:UIControlStateNormal];
    [secondBtn setTitleColor:BLUE_TEXT_COLOR forState:UIControlStateNormal];
    
    [firstBtn setTitle:dishName forState:UIControlStateNormal];
    [secondBtn setTitle:placeName forState:UIControlStateNormal];
    
    [atlabel setFont:[UIFont fontWithName:FONT_BOLD size:18]];
    [atlabel setTextAlignment:UITextAlignmentCenter];
    atlabel.text=@"@";
    [atlabel setTextColor:TEXT_COLOR];
    
    [firstBtn.titleLabel setFont:AROUNDME_TEXT_FONT];
    [secondBtn.titleLabel setFont:AROUNDME_TEXT_FONT];
    
    //=============  first btn ======================
    
	CGSize TextSizeFirst = [dishName sizeWithFont:AROUNDME_TEXT_FONT
                                constrainedToSize:AROUNDME_BTN_MAX_SIZE 
                                    lineBreakMode:UILineBreakModeTailTruncation];
    
	if(TextSizeFirst.height<20)
		TextSizeFirst.height=20;
    
    if(isnan(TextSizeFirst.width))
		TextSizeFirst.width=10;
    
    //=============  second btn =======================
    
    CGSize TextSizeSecond = [placeName  sizeWithFont:AROUNDME_TEXT_FONT
                                   constrainedToSize:CGSizeMake(280-TextSizeFirst.width, 20)  
                                       lineBreakMode:UILineBreakModeTailTruncation];
    
    if(TextSizeSecond.height<20)
		TextSizeSecond.height=20;
    
    
    if(isnan(TextSizeSecond.width))
		TextSizeSecond.width=10;
    
    //=============  set up btn ======================

    
    if(TextSizeSecond.width<=140)
    {
        TextSizeFirst = [dishName sizeWithFont:AROUNDME_TEXT_FONT
                                    constrainedToSize:CGSizeMake(280-TextSizeSecond.width, 20)
                                        lineBreakMode:UILineBreakModeTailTruncation];
        
        if(TextSizeFirst.height<20)
            TextSizeFirst.height=20;
        
        if(isnan(TextSizeFirst.width))
            TextSizeFirst.width=10;

    }
    
    
    firstBtn.frame=CGRectMake(10, 265, TextSizeFirst.width, TextSizeFirst.height);	
    atlabel.frame=CGRectMake(firstBtn.frame.origin.x+firstBtn.frame.size.width,
                             265, 
                             20, 
                             20);
    
    
    secondBtn.frame=CGRectMake(atlabel.frame.origin.x+atlabel.frame.size.width,
                               265, 
                               TextSizeSecond.width, 
                               TextSizeSecond.height);	


    
    //==============  review  =====================
    
    reviewlabel.numberOfLines=0;
    reviewlabel.lineBreakMode=UILineBreakModeWordWrap;
    reviewlabel.font=AROUNDME_REVIEW_FONT;
    reviewlabel.textColor=TEXT_COLOR;
    
    reviewlabel.text=review;
    
    CGSize TextSizeReview = [review  sizeWithFont:AROUNDME_REVIEW_FONT
                                constrainedToSize:AROUNDME_REVIEW_MAX_SIZE
                                    lineBreakMode:UILineBreakModeWordWrap];
    
    if(isnan(TextSizeReview.width))
		TextSizeReview.width=0;
    if(isnan(TextSizeReview.height))
		TextSizeReview.height=0;
    
    if(TextSizeReview.height<0)
		TextSizeReview.height=0;
    
    if(TextSizeReview.height>1000)
		TextSizeReview.height=1000;
    
    reviewlabel.frame=CGRectMake(10, secondBtn.frame.origin.y+secondBtn.frame.size.height,TextSizeReview.width, TextSizeReview.height);	
    
    //============   more  btn  ========================
    
    moreBtn.frame=CGRectMake(moreBtn.frame.origin.x, reviewlabel.frame.origin.y+TextSizeReview.height+5,moreBtn.frame.size.width, moreBtn.frame.size.height);
    
    rightViewImage.frame=CGRectMake(rightViewImage.frame.origin.x, reviewlabel.frame.origin.y+TextSizeReview.height+10,rightViewImage.frame.size.width, rightViewImage.frame.size.height);

    return reviewlabel.frame.origin.y+TextSizeReview.height;
}

- (void)dealloc {
	
	[likeBtn release];
	[commentBtn release];
	[moreBtn release];
	
    [firstBtn release];
    [secondBtn release];
    [atlabel release];
    
    [reviewlabel release];
    
	[bigPhotoImageView release];

    [dishName release];
    [placeName release];
    
    [rightViewImage release];
    
    [super dealloc];
}

@end
