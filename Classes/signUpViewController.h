//
//  signUpViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/13.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_SigninSignUp.h"
#import "SocialNetworkConnectViewController.h"
#import "API_URL_USER.h"
#import "numberAndImageView.h"
#import "inputBackGroundView.h"

@interface signUpViewController : UIViewController <UITextFieldDelegate> {
	ACNetworkManager *network;
	TopMenuBarView *topView;
	loadingSpinnerAndMessageView *checkingView;
	
	IBOutlet  UIView *myView; 
	IBOutlet  UILabel *welcomeLabel; 
	numberAndImageView *firstItem;
	numberAndImageView *secondItem;
	numberAndImageView *thirdItem;
	inputBackGroundView *inputbg;
	UITextField *usernametextField;
	UITextField *passwordtextField;
	UITextField *emailtextField;
	UITextField *passwordconfirmtextField;
	
	UIButton *confirmBtn;
	BOOL isPasswordConfirm;
	
	
}

- (void)signUpRequest;
- (IBAction)tapBackGround ;

@end
