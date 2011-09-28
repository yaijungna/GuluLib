//
//  guestListViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_Invite.h"

@interface guestListViewController : UIViewController <ACImageDownloaderDelegate> {

	TopMenuBarView *topView;
	ACNetworkManager *network;
	loadingSpinnerAndMessageView *LoadingView;
	
	NSMutableDictionary *imageLoaderDictionary_post;
	NSMutableArray *postArray;
	
	IBOutlet UITableView *table;
	
	NSString *eid;
	
}

@property (nonatomic,retain) NSMutableArray *postArray;
@property (nonatomic,retain) NSMutableDictionary *imageLoaderDictionary_post;
@property (nonatomic,retain) NSString *eid;

- (void)getList ;

@end
