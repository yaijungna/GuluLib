//
//  GuluBasicViewController.h
//  GULUAPP
//
//  Created by alan on 11/9/22.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GULUAPPAppDelegate.h"
#import "GuluAPIManager.h"
#import "GuluUtility.h"
#import "TopMenuBarView.h"
#import "BottomMenuBarView.h"

@interface GuluBasicViewController : UIViewController
{
    GULUAPPAppDelegate *appDelegate;
    UIActivityIndicatorView *loadingSpinner;
    GuluAPIAccessManager *APIManager;
    GuluUserModel *guluUserInfo;
    
    TopMenuBarView *topView;
	BottomMenuBarView *bottomView;
    
}

@property (nonatomic,retain) UIActivityIndicatorView *loadingSpinner;

@end
