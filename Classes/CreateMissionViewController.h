//
//  CreateMissionViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/9.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewControllerAddtion.h"

#import "API_URL_USER.h"



@interface CreateMissionViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    
    ACNetworkManager *network;
    TopMenuBarView *topView;
    BottomMenuBarView *bottomView;
    loadingSpinnerAndMessageView *LoadingView;
    
     IBOutlet UITableView *table_design;
    
    //======================================================
    
    NSArray *designMissionPhotoArray;
    NSArray *designMissionStringArray;
    NSArray *designMissionSubTitleStringArray;
}


@end
