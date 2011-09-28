//
//  signInsignUpLandingPageViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/13.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "ACPagableScrollView.h"
#import "ACPageControl.h"

#import "postView.h"
#import "searchView.h"
#import "missionView.h"
#import "chatView.h"
#import "myguluView.h"

#import "crashreportModel.h"



@interface signInsignUpLandingPageViewController : UIViewController<ACPagableScrollViewDelegate> {
	IBOutlet ACPagableScrollView *pageViewController;
	IBOutlet UIButton *btnSignUp;
	IBOutlet UIButton *btnSignIn;
	IBOutlet ACPageControl *pageController;	
	BottomMenuBarView *bottomView;
    
    crashreportModel *crash;
}

- (void)setBottomIconToSelected :(NSInteger)index;

@end
