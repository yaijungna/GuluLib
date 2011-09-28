//
//  MissionSummaryViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/30.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "ACCreateButtonClass.h"

#import "UIViewControllerAddtion_Connection_Post.h"
#import "UIViewControllerAddtion_Connection_Mission.h"


@interface MissionSummaryViewController : UIViewController <TSAlertViewDelegate>{
 
    ACNetworkManager *network;
    TopMenuBarView *topView;
    loadingSpinnerAndMessageView *LoadingView;
    //===============================
    IBOutlet UITableView *table;
    
    IBOutlet UILabel *missionTitleLabel;
    IBOutlet UITextView  *aboutTextView;
    
    IBOutlet UIImageView *photo;
    IBOutlet UIButton *photoBtn;
    
    IBOutlet UILabel *buttomLabel;
    IBOutlet UISwitch *switcher;
    
    missionModel *missionObj;
    
    TSAlertView *WarningAlert;
    BOOL isAllRequestFinished;
    
}

- (void)uploadMissionPhoto;
- (void)uploadTaskPhoto:(taskModel *)obj;

-(void) showWarningAlert_cancel;
-(void) showWarningAlert_create;


@property(nonatomic,retain)TSAlertView *WarningAlert;
@property(nonatomic,retain) missionModel *missionObj;

@end
