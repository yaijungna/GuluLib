//
//  MissionLandingViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/7.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_Mission.h"
#import "EGORefreshTableHeaderView.h"
#import "ACSegmentController.h"


typedef enum {
    MyMissionLandingType,
	GradeMissionType
}  MissionLandingType;


@interface MissionLandingViewController : UIViewController <EGORefreshTableHeaderDelegate,ACSegmentControllerDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,ACImageDownloaderDelegate> {
    
    ACNetworkManager *network;
    TopMenuBarView *topView;
    BottomMenuBarView *bottomView;
    loadingSpinnerAndMessageView *LoadingView;
    
    ACSegmentController *segment;
    
    //======================================================
    
    IBOutlet UITableView *table_mine;
    EGORefreshTableHeaderView *_refreshHeaderView_mine;
    BOOL _reloading_mine;
    
    IBOutlet UITableView *table_grade;
    EGORefreshTableHeaderView *_refreshHeaderView_grade;
    BOOL _reloading_grade;
    
    
    //======================================================
    
    NSMutableArray *gradeMissionArray;
    NSMutableArray *myMissionArray;
    
    //======================================================
    
}

@property (nonatomic,retain ) NSMutableArray *gradeMissionArray;
@property (nonatomic,retain ) NSMutableArray *myMissionArray;


-(void)getMyMissionList;
-(void)getMyCreatedMissionList;
-(void)leaveMission:(NSString *)mid;


@end
