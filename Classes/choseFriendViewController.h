//
//  choseFriendViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_MyGulu.h"


@interface choseFriendViewController  : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    ACNetworkManager *network;
	TopMenuBarView *topView;
	loadingSpinnerAndMessageView *LoadingView;
    
    IBOutlet UITableView *table;
    IBOutlet UITextField *searchTextField;
    
    NSMutableArray *usersArray;
    NSMutableDictionary *chosedDict;
    
}

@property (nonatomic,retain)NSMutableArray *usersArray;
@property (nonatomic,retain)NSMutableDictionary *chosedDict;

- (void)searchUser;
- (void)getFriendUser;
-(void)ACConnectionSuccess:(ASIFormDataRequest *)request;
-(void)ACConnectionFailed:(ASIFormDataRequest *)request;

@end
