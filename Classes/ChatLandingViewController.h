//
//  ChatLandingViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/7.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_chat.h"
#import "ACSegmentController.h"
#import "AppStrings_chat.h"

#import "chatLandingTableViewController.h"


@interface ChatLandingViewController : UIViewController <ACSegmentControllerDelegate> {
	
	ACSegmentController *segment;
	TopMenuBarView *topView;
	BottomMenuBarView *bottomView;
	
	IBOutlet UIView *myView;

	chatLandingTableViewController *chat;
}




@end
