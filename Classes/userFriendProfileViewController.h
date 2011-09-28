//
//  userFriendProfileViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/20.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_Favorite.h"
#import "UIViewControllerAddtion_Connection_MyGulu.h"
#import "userProfileView.h"

#import "RestaurantProfileViewController.h"
#import "dishProfileViewController.h"
#import "missionProfileviewcontroller.h"



@interface userFriendProfileViewController : UIViewController <ACImageDownloaderDelegate,UITableViewDelegate ,UITableViewDataSource>{
	UITableView *table;
	userProfileView *userView;
	NSMutableDictionary *userDict;
	
	ACNetworkManager *network;
	TopMenuBarView *topView;
	BottomMenuBarView *bottomView;
	loadingSpinnerAndMessageView *LoadingView;
	
	NSMutableArray *favoriteArray;
	NSMutableDictionary *imageLoaderDictionary_post;
    
    NSInteger friendStatus;
    BOOL isFavorite;
	
}

@property (nonatomic,retain) BottomMenuBarView *bottomView;
@property (nonatomic,retain) NSMutableDictionary *userDict;
@property (nonatomic,retain) NSMutableDictionary *imageLoaderDictionary_post;
@property (nonatomic,retain) NSMutableArray *favoriteArray;

- (void)getUserInfo;
- (void)getMyFavorite;

- (void)addFavoriteUser;
- (void)unFavoriteUser;
- (void)checkFriend;
- (void)checkFavorite;
- (void)AddFriend;


@end