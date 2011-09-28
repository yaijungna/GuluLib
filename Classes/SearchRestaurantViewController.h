//
//  SearchRestaurantViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/22.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppStrings_invite.h"
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_Search.h"
#import "EGORefreshTableHeaderView.h"



@protocol SearchRestaurantDelegate

- (void) selectedDictionary:(NSMutableDictionary *)dict;

@end

@interface SearchRestaurantViewController : UIViewController <EGORefreshTableHeaderDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{

    ACNetworkManager *network;
	loadingSpinnerAndMessageView *LoadingView;
    
	NSMutableArray *postArray;
	NSString *term;
    
    UITableView *table;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
	UITextField *searchTextField;  //need to assign 
    
    id <SearchRestaurantDelegate> delegate;
    BOOL allowAddNewPlace;
}

@property (nonatomic,readonly)  ACNetworkManager *network;
@property (nonatomic,retain)  UITableView *table;
@property (nonatomic,retain) NSMutableArray *postArray;
@property (nonatomic,retain) NSString *term;

@property (nonatomic,retain) UITextField *searchTextField;  //need to assign 

@property (nonatomic,assign) id <SearchRestaurantDelegate> delegate;
@property (nonatomic ,assign) UINavigationController *navigationController;

@property (nonatomic)  BOOL allowAddNewPlace;


- (void)searchRestaurant ;

@end
