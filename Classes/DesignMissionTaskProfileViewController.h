//
//  DesignMissionTaskProfileViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/30.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"

#import "ACCameraViewController.h"

@interface DesignMissionTaskProfileViewController : UIViewController <ACImageDownloaderDelegate,ACCameraViewControllerDelegate> {
    
    ACNetworkManager *network;
    TopMenuBarView *topView;

    ACCameraViewController *imagePicker;

    //===============================
    
    IBOutlet UITextField *titleTextField;
    
    IBOutlet UILabel *aboutLabel;
    IBOutlet UITextView  *aboutTextView;
    
    IBOutlet UIImageView *photobg;
    IBOutlet UILabel *photoLabel;
    IBOutlet UIButton *photoButton;
    
    IBOutlet UILabel *placeLabel;
    IBOutlet UILabel *placenameLabel;
    
    IBOutlet UILabel *dishLabel;
    IBOutlet UILabel *dishnameLabel;
    
    IBOutlet UILabel *showplaceLabel;
    IBOutlet UILabel *showdishLabel;
    
    IBOutlet UISwitch *placeSwitcher;
    IBOutlet UISwitch *dishSwitcher;

    
    taskModel *taskObj;
    missionModel *missionObj;
    ACImageLoader *imageLoader;
    

}

-(BOOL)checkFieldIsCorrect;

@end
