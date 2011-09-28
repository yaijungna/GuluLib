//
//  gradeMissionViewContorller.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/7.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_Mission.h"
#import "UIViewControllerAddtion_Connection_Favorite.h"

#import "gradeDetailView.h"


@interface gradeMissionViewContorller : UIViewController <TSAlertViewDelegate,ACImageDownloaderDelegate>{
    
    IBOutlet UITableView *table;
    
    ACNetworkManager *network;
    TopMenuBarView *topView;
    BottomMenuBarView *bottomView;
    loadingSpinnerAndMessageView *LoadingView;
    
    gradeDetailView *detailView;
    
    NSMutableArray *groupMissionArray;
    NSMutableDictionary *imageLoaderDictionary;
    NSDictionary *missionDict;
    NSInteger indexOfGroupMissionArray;  // tell you which mission you are verifying
    
    NSMutableDictionary *failDict;
    
    BOOL isFailMode;
    
    TSAlertView *passAlert;
    TSAlertView *aplusAlert;
    TSAlertView *failAlert;
    
    
    
}

@property (nonatomic,retain) NSMutableArray *groupMissionArray;
@property (nonatomic,retain) NSMutableDictionary *imageLoaderDictionary;
@property (nonatomic,retain) NSDictionary *missionDict;
@property (nonatomic) NSInteger indexOfGroupMissionArray;

@property (nonatomic,retain)  NSMutableDictionary *failDict;



-(void)getGradeMission;
-(void)passMission:(NSString *)grade;
-(void)failMission:(NSString *)message;
@end
