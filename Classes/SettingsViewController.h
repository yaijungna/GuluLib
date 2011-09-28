//
//  SettingsViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/15.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "AppStrings_settings.h"
#import "ACSegmentController.h"
#import "notificationViewController.h"
#import "UIViewControllerAddtion_Connection_General.h"

typedef enum {
	settings_profile,
    settings_sendFeedback,
    settings_Logout,
    settings_Notification,
	settings_socialNetwork,
	settings_privacy,
	//settings_sendFeedback,
	//settings_Logout
} settingsType;

@interface SettingsViewController : UIViewController<TSAlertViewDelegate,ACSegmentControllerDelegate,UITableViewDelegate,UITableViewDataSource> {
	TopMenuBarView *topView;
    ACSegmentController *segment;
	
	IBOutlet UITableView *table;

	NSMutableArray *settingsArray;
	NSArray *strArray;
	NSArray *photoArray;
    
    notificationViewController *notifyVC;
    
    ACNetworkManager *network;
	loadingSpinnerAndMessageView *LoadingView;

}


@end
