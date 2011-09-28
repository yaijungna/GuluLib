//
//  ACAlertViewReadyToPost.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/12.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ACAlertView.h"
#import "ACCreateButtonClass.h"

@interface ACAlertViewReadyToPost : ACAlertView {
	UILabel *alertTitleLabel;
	UILabel *shareTitle;
	UILabel *settingsTitle;
	
	UIButton *mixiBtn;
	UIButton *fbBtn;
	
	ACButtonWIthBottomTitle *publicBtn;
	ACButtonWIthBottomTitle *friendsFansBtn;
	ACButtonWIthBottomTitle *friendsBtn;
}

-(void) setframeToDefinedSize :(ACAlertViewSizeType )type;

@property(nonatomic,retain) UILabel *alertTitleLabel;
@property(nonatomic,retain) UILabel *shareTitle;
@property(nonatomic,retain) UILabel *settingsTitle;

@property(nonatomic,retain) UIButton *mixiBtn;
@property(nonatomic,retain) UIButton *fbBtn;

@property(nonatomic,retain) ACButtonWIthBottomTitle *publicBtn;
@property(nonatomic,retain) ACButtonWIthBottomTitle *friendsFansBtn;
@property(nonatomic,retain) ACButtonWIthBottomTitle *friendsBtn;




@end
