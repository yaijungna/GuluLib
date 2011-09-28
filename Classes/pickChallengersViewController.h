//
//  pickChallengersViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/30.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_MyGulu.h"

@interface pickChallengersViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    ACNetworkManager *network;
	TopMenuBarView *topView;
	loadingSpinnerAndMessageView *LoadingView;
    
    IBOutlet UITableView *table;
    IBOutlet UILabel *titleLabel;
    IBOutlet UITextField *searchTextField;
    
    NSMutableArray *usersArray;
    
    missionModel *missionObj;
    NSMutableDictionary *originChallengerDict;
    
}

@property (nonatomic,retain)NSMutableArray *usersArray;

- (void)searchUser;
-(BOOL)checkFieldIsCorrect;

@end
