//
//  pickSpectatorViewController.h
//  GULUAPP
//
//  Created by Genie Capital on 7/1/11.
//  Copyright 2011 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_MyGulu.h"

@interface pickSpectatorViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    ACNetworkManager *network;
	TopMenuBarView *topView;
	loadingSpinnerAndMessageView *LoadingView;
    
    IBOutlet UITableView *table;
    IBOutlet UILabel *titleLabel;
    IBOutlet UITextField *searchTextField;
    
    NSMutableArray *usersArray;
    
    missionModel *missionObj;
    
}

@property (nonatomic,retain)NSMutableArray *usersArray;

- (void)searchUser;


@end
