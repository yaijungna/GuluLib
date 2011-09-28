//
//  notificationViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_Notify.h"
#import "EGORefreshTableHeaderView.h"
#import "AppStrings_settings.h"
#import "TimeAgoFormat.h"

#import "notificationViewController.h"

@interface notificationViewController : UIViewController<EGORefreshTableHeaderDelegate,ACImageDownloaderDelegate,UITableViewDelegate,UITableViewDataSource> 
{
    ACNetworkManager *network;
	loadingSpinnerAndMessageView *LoadingView;
	
	IBOutlet UITableView *table;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
	NSMutableArray *notifyArray;
}

@property(nonatomic,retain )NSMutableArray *notifyArray;
@property(nonatomic,assign) UINavigationController *navigationController;

- (void)getAllNotification;
- (void)sendRespondFriend :(NSString *)uid  status:(NSString *)status;

@end
