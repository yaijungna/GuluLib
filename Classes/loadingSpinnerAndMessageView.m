//
//  loadingSpinnerAndMessageView.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/30.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "loadingSpinnerAndMessageView.h"
#import "AppSettings.h"


@implementation loadingSpinnerAndMessageView

- (id)init {
	
	if (self = [super init])
	{
		[self setBackgroundColor:[UIColor clearColor]];
		
		backGroundImgView=[[UIImageView alloc] init];
		[backGroundImgView setBackgroundColor:[UIColor blackColor]];
		backGroundImgView.frame=CGRectMake(self.center.x-50,self.center.y-50,100,100);
		backGroundImgView.layer.cornerRadius=10.0;
		[self addSubview:backGroundImgView];
		[backGroundImgView release];
		backGroundImgView.alpha=0.7;
		
		loadingSpinner=[[UIActivityIndicatorView alloc] init];
		[loadingSpinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
		loadingSpinner.frame=CGRectMake(self.center.x-18,self.center.y-18,36,36);
		[self addSubview:loadingSpinner];
		[loadingSpinner release];
		[loadingSpinner startAnimating];
		
		loadingLabel=[[UILabel alloc] init];
		[loadingLabel setBackgroundColor:[UIColor clearColor]];
		[loadingLabel setTextColor:[UIColor whiteColor]];
		[loadingLabel setTextAlignment:UITextAlignmentCenter];
		loadingLabel.lineBreakMode=UILineBreakModeWordWrap;
		loadingLabel.numberOfLines=0;
		loadingLabel.font=[UIFont fontWithName:FONT_NORMAL size:16] ;
		loadingLabel.frame=CGRectMake(self.center.x-50,self.center.y-20,100,40);
		[self addSubview:loadingLabel];
		[loadingLabel release];
		
	}
	
	return self;
	
}

-(CGSize ) setMessageAndAdjustFrameSizeToFitMessage:(NSString*) message_string frameSize:(CGSize) maxSize
{	
	CGSize textSize = [message_string sizeWithFont:[UIFont fontWithName:FONT_NORMAL size:16] 
								 constrainedToSize:maxSize 
									 lineBreakMode:UILineBreakModeWordWrap];
	
	if(textSize.width<80)
		textSize.width=80;
	
	CGSize textLabelSize=CGSizeMake(textSize.width, textSize.height);
    
    if(isnan(textLabelSize.width))
		textLabelSize.width=80;
    if(isnan(textLabelSize.width))
		textLabelSize.height=20;

	CGSize frameSize=CGSizeMake(textSize.width+20,10+loadingSpinner.frame.size.height+10+textSize.height+10);
	
	
	//--------------------
	loadingSpinner.frame=CGRectMake(frameSize.width/2-18,10,36,36);
	backGroundImgView.frame=CGRectMake(0,0,frameSize.width,frameSize.height );
	loadingLabel.frame=CGRectMake(10,10+loadingSpinner.frame.size.height+10,textLabelSize.width,textLabelSize.height);
	loadingLabel.text=message_string;
	
	return frameSize;
}




@end
