//
//  MyPostTableViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/17.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_Favorite.h"
#import "PullRefreshTableViewController.h"
#import "UserHeaderView.h"
#import "AppStrings_myGulu.h"

#import "UIViewControllerAddtion_Connection_MyGulu.h"
#import "UIViewControllerAddtion_moreView.h"
#import "UIViewControllerAddtion_Connection_Favorite.h"

#import "UserHeaderView.h"

#import "ACTableAroundMeCell.h"

#import "RestaurantProfileViewController.h"
#import "dishProfileViewController.h"

#import "EGORefreshTableHeaderView.h"

#import "PostManager.h"

#import "GuluAPIManager.h"


@interface MyPostTableViewController : UIViewController <PostManagerDelegate,ACImageDownloaderDelegate,UITableViewDataSource,UITableViewDelegate,GuluAPIAccessManagerDelegate> {
	ACNetworkManager *network;
	loadingSpinnerAndMessageView *LoadingView;
	
	NSMutableArray *postArray;
    NSMutableArray *queueArray;
    PostManager *postManager;
    
    
    UITableView *tableView;
    
    GuluGeneralHTTPClient *http;
}

@property (nonatomic,retain) NSMutableArray *postArray;
@property (nonatomic,retain) NSMutableArray *queueArray;
@property (nonatomic,assign) UINavigationController *navigationController;

@property (nonatomic,retain)  UITableView *tableView;


- (void)getMyPost ;

@end
