//
//  SearchRestaurantTableViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/22.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "PullRefreshTableViewController.h"
#import "UserHeaderView.h"

#import "UIViewControllerAddtion_Connection_MyGulu.h"
#import "UIViewControllerAddtion_Connection_Search.h"

@interface SearchRestaurantTableViewController : PullRefreshTableViewController <ACImageDownloaderDelegate> {
	ACNetworkManager *network;
	loadingSpinnerAndMessageView *LoadingView;
	NSMutableDictionary *imageLoaderDictionary_post;
	NSMutableArray *postArray;
	NSString *term;
	
}

@property (nonatomic,retain) ACNetworkManager *network;
@property (nonatomic,retain) NSMutableArray *postArray;
@property (nonatomic,retain) NSMutableDictionary *imageLoaderDictionary_post;
@property (nonatomic,retain) UINavigationController *navigationController;
@property (nonatomic,retain) NSString *term;

- (void)searchRestaurant ;

@end
