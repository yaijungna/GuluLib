//
//  aroundMeTableViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/19.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewControllerAddtion.h"
#import "PullRefreshTableViewController.h"
#import "UserHeaderView.h"
#import "AppStrings_myGulu.h"
#import "UIViewControllerAddtion_Connection_Favorite.h"
#import "UIViewControllerAddtion_moreView.h"
#import "UIViewControllerAddtion_Connection_MyGulu.h"

#import "RestaurantProfileViewController.h"
#import "dishProfileViewController.h"

@interface aroundMeTableViewController : PullRefreshTableViewController <ACImageDownloaderDelegate>{
	ACNetworkManager *network;
	loadingSpinnerAndMessageView *LoadingView;
	
	NSMutableArray *postArray;
    
    
}

@property (nonatomic,retain) NSMutableArray *postArray;

@property (nonatomic,assign) UINavigationController *navigationController;

- (void)getMyPost ;

@end
