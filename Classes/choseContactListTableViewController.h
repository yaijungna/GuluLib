//
//  choseContactListTableViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/22.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "PullRefreshTableViewController.h"

#import "UIViewControllerAddtion_Connection_MyGulu.h"

@interface choseContactListTableViewController : PullRefreshTableViewController<ACImageDownloaderDelegate> {
	ACNetworkManager *network;
	loadingSpinnerAndMessageView *LoadingView;
	
	NSMutableDictionary *imageLoaderDictionary_post;
	NSMutableArray *postArray;
	
}

@property (nonatomic,retain) NSMutableArray *postArray;
@property (nonatomic,retain) ACNetworkManager *network;
@property (nonatomic,retain) NSMutableDictionary *imageLoaderDictionary_post;
@property (nonatomic,retain) UINavigationController *navigationController;

- (void)getMyFriend ;

@end
