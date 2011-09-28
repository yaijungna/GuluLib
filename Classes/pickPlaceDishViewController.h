//
//  pickPlaceDishViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/30.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_Search.h"

@interface pickPlaceDishViewController : UIViewController <ACImageDownloaderDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    
    ACNetworkManager *network;
	TopMenuBarView *topView;
	loadingSpinnerAndMessageView *LoadingView;
    
    IBOutlet UITableView *table;
    IBOutlet UILabel *titleLabel;
    IBOutlet UITextField *searchTextField;
    
    NSMutableArray *dishArray;
    NSMutableArray *restaurantArray;
    
    NSMutableDictionary *imageLoaderDictionary_restaurant;
    NSMutableDictionary *imageLoaderDictionary_dish;

    
}

@property (nonatomic,retain)NSMutableArray *dishArray;
@property (nonatomic,retain)NSMutableArray *restaurantArray;

@property (nonatomic,retain) NSMutableDictionary *imageLoaderDictionary_restaurant;
@property (nonatomic,retain) NSMutableDictionary *imageLoaderDictionary_dish;

- (void)searchDish ;
- (void)searchRestaurant;



@end
