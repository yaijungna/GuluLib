//
//  SearchDishViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppStrings_invite.h"
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_Search.h"
#import "EGORefreshTableHeaderView.h"


@protocol SearchDishDelegate

- (void) selectedDishDictionary:(NSMutableDictionary *)dict;

@end 

@interface SearchDishViewController : UIViewController <EGORefreshTableHeaderDelegate,UITextFieldDelegate,ACImageDownloaderDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    ACNetworkManager *network;
	loadingSpinnerAndMessageView *LoadingView;
    
	NSMutableArray *postArray;
	NSString *term;
    NSString *rid;
    
    UITableView *table;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
	UITextField *searchTextField;  //need to assign 
    
    id <SearchDishDelegate> delegate;
}

@property (nonatomic,readonly) ACNetworkManager *network;
@property (nonatomic,retain) UITableView *table;
@property (nonatomic,retain) NSMutableArray *postArray;
@property (nonatomic,retain) NSString *term;
@property (nonatomic,retain) NSString *rid;

@property (nonatomic,retain) UITextField *searchTextField;  //need to assign 

@property (nonatomic,assign) id <SearchDishDelegate> delegate;


- (void)getDishOfPlace;
- (void)searchDish;

@end
