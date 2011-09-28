//
//  chatLandingTableViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/21.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "PullRefreshTableViewController.h"
#import "UIViewControllerAddtion_Connection_chat.h"
#import "ACSegmentController.h"


@interface chatLandingTableViewController : PullRefreshTableViewController<ACSegmentControllerDelegate> 
{
	ACNetworkManager *network;
	loadingSpinnerAndMessageView *LoadingView;
    ACSegmentController *segment;
	
	NSMutableArray *chatArray;
    
	NSMutableArray *chatArray_hungry;
	NSMutableArray *chatArray_mission;
	NSMutableArray *chatArray_event;
    
}

@property (nonatomic,retain) NSMutableArray *chatArray;
@property (nonatomic,retain) UINavigationController *navigationController;

@property (nonatomic,retain) NSMutableArray *chatArray_hungry;
@property (nonatomic,retain) NSMutableArray *chatArray_mission;
@property (nonatomic,retain) NSMutableArray *chatArray_event;

- (void) getMyChat;

@end
