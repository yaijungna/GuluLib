//
//  ToDoTableViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/20.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewControllerAddtion.h"
#import "UserHeaderView.h"

#import "UIViewControllerAddtion_Connection_MyGulu.h"

#import "ACActionSheetView.h"

#import "EGORefreshTableHeaderView.h"

@interface ToDoTableViewController : UIViewController <ACActionSheetViewDelegate,EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>
{
	ACNetworkManager *network;
	loadingSpinnerAndMessageView *LoadingView;
	
	NSMutableArray *postArray;
    
    NSMutableArray *postArray_restaurant;
    NSMutableArray *postArray_dish;
    
    UIView *tableViewContainer;
    UITableView *tableView;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
    
    NSIndexPath *selectedIndexPath;
}

@property (nonatomic,retain)  UITableView *tableView;

@property (nonatomic,retain) NSMutableArray *postArray;

@property (nonatomic,retain) NSMutableArray *postArray_restaurant;
@property (nonatomic,retain) NSMutableArray *postArray_dish;

@property (nonatomic ,assign) UINavigationController *navigationController;

- (void)getMyTodo ;
- (void)deletetMyTodo:(NSString *)todo_id;

@end
