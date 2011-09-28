//
//  commentViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/27.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_comments.h"

#import "ChatTextFieldView.h"

@interface commentViewController : UIViewController <ACImageDownloaderDelegate,EGORefreshTableHeaderDelegate,UITextFieldDelegate>{
	IBOutlet UITableView *table;
	BOOL _reloading;
	EGORefreshTableHeaderView *_refreshHeaderView;
	
	ACNetworkManager *network;
	TopMenuBarView *topView;
	BottomMenuBarView *bottomView;
	loadingSpinnerAndMessageView *LoadingView;
    
    ChatTextFieldView *chatView;
    

    
	NSMutableArray *commentsArray;
    NSMutableDictionary *imageLoaderDictionary;
    id targetObj;
	
	
}

@property (nonatomic,retain) id targetObj;
@property (nonatomic,retain) NSMutableArray *commentsArray;
@property (nonatomic,retain) NSMutableDictionary *imageLoaderDictionary;


-(void)getcommentList;
-(void)postComment;

@end
