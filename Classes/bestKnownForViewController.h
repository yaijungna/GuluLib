//
//  bestKnownForViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_Post.h"
#import "EGORefreshTableHeaderView.h"


@protocol bestKnownForDelegate

- (void) selectedBestKnownForDictionary:(NSMutableDictionary *)dict;

@end 

@interface bestKnownForViewController : UIViewController <EGORefreshTableHeaderDelegate, UITableViewDelegate ,UITableViewDataSource,UITextFieldDelegate>
{
    
    ACNetworkManager *network;
	loadingSpinnerAndMessageView *LoadingView;
    
	NSString *term;
    
    UITableView *table;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
	UITextField *searchTextField;  //need to assign 
    
    id <bestKnownForDelegate> delegate;

    //====
	
	NSMutableArray *tableArray;
	NSMutableArray *originArray;
    
    //====
    NSString *bestkownforserial;

	

}

@property (nonatomic ,retain) NSMutableArray *tableArray;
@property (nonatomic ,retain) NSMutableArray *originArray;

@property (nonatomic,readonly) ACNetworkManager *network;
@property (nonatomic,retain) UITableView *table;
@property (nonatomic,retain) NSString *term;

@property (nonatomic,retain) UITextField *searchTextField;  //need to assign 

@property (nonatomic,assign) id <bestKnownForDelegate> delegate;

@property (nonatomic,retain) NSString *bestkownforserial;

- (void)getBestKnownForList :(NSString *)serial;



@end
