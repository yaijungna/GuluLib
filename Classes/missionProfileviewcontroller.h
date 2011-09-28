//
//  missionProfileviewcontroller.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/4.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_Mission.h"
#import "UIViewControllerAddtion_Connection_Favorite.h"
#import "missionDetailView.h"



@interface missionProfileviewcontroller : UIViewController{
    
    IBOutlet UITableView *table;
    
    ACNetworkManager *network;
    TopMenuBarView *topView;
    BottomMenuBarView *bottomView;
    loadingSpinnerAndMessageView *LoadingView;
    
    missionDetailView *detailView;

    
    NSMutableArray *tasksArray;
    NSDictionary *missionDict;
    
    NSDictionary *chatDict;
    
    BOOL fromChat;
    BOOL fromMission;
    
}

@property (nonatomic,retain) NSMutableArray *tasksArray;
@property (nonatomic,retain) NSDictionary *missionDict;

@property(nonatomic,retain)NSDictionary *chatDict;


@property(nonatomic )BOOL fromChat;
@property(nonatomic )BOOL fromMission;


-(void)getTasksList;

@end
