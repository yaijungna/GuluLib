//
//  ACAlertViewReadyToPost.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/12.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACAlertViewReadyToPost.h"


@implementation ACAlertViewReadyToPost

@synthesize alertTitleLabel,shareTitle,settingsTitle,mixiBtn,fbBtn,publicBtn,friendsFansBtn,friendsBtn;


-(void) setframeToDefinedSize :(ACAlertViewSizeType )type
{	
	[super setframeToDefinedSize:type];
	
	alertTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(ALERT_LEFT_PADDING, 40,ALERT_WIDTH-ALERT_LEFT_PADDING-ALERT_RIGHT_PADDING ,50 )];
	[alertTitleLabel setBackgroundColor:[UIColor whiteColor]];
	[self addSubview:alertTitleLabel];
	
	shareTitle=[[UILabel alloc] initWithFrame:CGRectMake(ALERT_LEFT_PADDING, 90,ALERT_WIDTH-ALERT_LEFT_PADDING-ALERT_RIGHT_PADDING,20 )];
	[shareTitle setBackgroundColor:[UIColor whiteColor]];
	[self addSubview:shareTitle];
	
	self.mixiBtn=[ACCreateButtonClass createButton:ButtonTypeMixi];
	[mixiBtn setFrame:CGRectMake(40, 115, mixiBtn.frame.size.width, mixiBtn.frame.size.height)];
	[self addSubview: mixiBtn];
	
	self.fbBtn=[ACCreateButtonClass createButton:ButtonTypefaceBook];
	[fbBtn setFrame:CGRectMake(90, 115, fbBtn.frame.size.width, fbBtn.frame.size.height)];
	[self addSubview: fbBtn];
	
	settingsTitle=[[UILabel alloc] initWithFrame:CGRectMake(ALERT_LEFT_PADDING, 165,ALERT_WIDTH-ALERT_LEFT_PADDING-ALERT_RIGHT_PADDING,20 )];
	[settingsTitle setBackgroundColor:[UIColor whiteColor]];
	[self addSubview:settingsTitle];
	
	self.publicBtn=[ACCreateButtonClass createButton:ButtonTypeLock];
	publicBtn.btnTitleLabel.text=NSLocalizedString(@"Public",@"privacy settings");
	[publicBtn setFrame:CGRectMake(40, 190, mixiBtn.frame.size.width, mixiBtn.frame.size.height)];
	[self addSubview:publicBtn];
	
	[firstBtn setFrame:CGRectMake(self.frame.size.width/2-50, 243,100, 30)];
	[firstBtn setBackgroundImage:[UIImage imageNamed:@"button-1.png"] forState:UIControlStateNormal];
	[firstBtn setTitle:NSLocalizedString(@"I'm done !",@" submit review is done and chose what social network want to share") forState:UIControlStateNormal];
	
	
	
/*	UIButton *doneBtn;
	UILabel *shareTitle;
	UILabel *settingsTitle;
	
	UIButton *mixiBtn;
	UIButton *fbBtn;
	
	UIButton *publicBtn;
	UIButton *friendsFansBtn;
	UIButton *friendsBtn;*/
	
 
	
	
	
}

- (void)dealloc {
    [super dealloc];
}


@end
