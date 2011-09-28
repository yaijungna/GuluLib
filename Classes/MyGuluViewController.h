//
//  MyGuluViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/7.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuluBasicViewController.h"

#import "UIViewControllerAddtion.h"
#import "ACSegmentController.h"
#import "AppStrings_myGulu.h"

#import "MyPostTableViewController.h"
#import "aroundMeTableViewController.h"
#import "ToDoTableViewController.h"
#import "FeedTableViewController.h"
#import "MyFriendTableViewController.h"

#import "crashreportModel.h"
#import "GuluCrashReportModel.h"

#import "GuluChatManager.h"
#import "newchatVC.h"


//============

#import "MyPostFriendTableView.h"
#import "MyGuluMyPostTableView.h"
#import "AroundMeTableView.h"

@interface MyGuluViewController : GuluBasicViewController <ACSegmentControllerDelegate> {
    
	ACSegmentController *segment;
	IBOutlet UIView *myView;
	
/*	MyPostTableViewController *mypost;
	aroundMeTableViewController *aroundme;
	ToDoTableViewController *todolist;
	FeedTableViewController *feed;
	MyFriendTableViewController *myfriend;
*/    
//    GuluCrashReportModel *crashreport;
//    GuluChatManager *manager;
    
    //==================
    
    MyPostFriendTableView *friendTableView;
    MyGuluMyPostTableView *mypostTableView;
    AroundMeTableView *aroundMeTableView;
    
    GuluHttpRequest *friendRequest;
    GuluHttpRequest *mypostRequest;
    GuluHttpRequest *aroundMeRequest;
}

@property (nonatomic,assign) GuluHttpRequest *friendRequest;
@property (nonatomic,assign) GuluHttpRequest *mypostRequest;
@property (nonatomic,assign) GuluHttpRequest *aroundMeRequest;


/*
@property (nonatomic,retain )MyPostTableViewController *mypost;
@property (nonatomic,retain )aroundMeTableViewController *aroundme;
@property (nonatomic,retain )ToDoTableViewController *todolist;
@property (nonatomic,retain )FeedTableViewController *feed;
@property (nonatomic,retain )MyFriendTableViewController *myfriend;
*/

@end
