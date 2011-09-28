//
//  RootViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACTabBarController.h"
#import "userMeModel.h"

@class MyGuluViewController;
@class ChatLandingViewController;
@class PostLandingViewController;
@class MissionLandingViewController;
@class SearchLandingViewContorller;

@interface RootViewController : UIViewController <UINavigationControllerDelegate>{
	UITabBarController *tabVC;
	NSInteger tabVCLastSelected;
	userMeModel *userMe;
    
    MyGuluViewController *firstView;
    ChatLandingViewController *secondView;
    PostLandingViewController *thirdView;
    MissionLandingViewController *fourthView;
    SearchLandingViewContorller *fifthView;
    
    BOOL startToCallCrashView;
}

@property(nonatomic,retain) UITabBarController *tabVC;
@property(nonatomic) NSInteger tabVCLastSelected;
@property(nonatomic,retain) userMeModel *userMe;

- (void) checkuserlogin;

@end
