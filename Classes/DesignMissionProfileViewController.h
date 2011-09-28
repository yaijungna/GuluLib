//
//  DesignMissionProfileViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/29.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"

#import "ACCreateButtonClass.h"
#import "ACCameraViewController.h"

@interface DesignMissionProfileViewController : UIViewController <UITextFieldDelegate,ACCameraViewControllerDelegate>{
    ACNetworkManager *network;
    TopMenuBarView *topView;
    BottomMenuBarView *bottomView;
    
    ACCameraViewController *imagePicker;
    
    //===============================
    
    IBOutlet UIView *myView;
    
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *aboutLabel;
    
    IBOutlet UITextField *titleTextField;
    IBOutlet UITextView  *aboutTextView;
    
    IBOutlet UIImageView *photobg;
    IBOutlet UILabel *photoLabel;
    IBOutlet UILabel *challengerLabel;
    IBOutlet UITextField *challengerTextField;
    IBOutlet UIButton *photoButton;
   
    //===============================
    IBOutlet UIView *dateView;
    
    IBOutlet UIButton *checkBox1;
    IBOutlet UIButton *checkBox2;
    IBOutlet UIButton *checkBox3;
    
    IBOutlet UILabel *option1Label;
    IBOutlet UILabel *option2_1_Label;
    IBOutlet UILabel *option2_2_Label;
    IBOutlet UILabel *option3_1_Label;
    IBOutlet UILabel *option3_2_Label;
    IBOutlet UILabel *option3_3_Label;
    IBOutlet UILabel *option3_4_Label;
    
    IBOutlet UITextField *option1TextField;
    IBOutlet UITextField *option2TextField;
    IBOutlet UITextField *option3_1_TextField;
    IBOutlet UITextField *option3_2_TextField;
    
    IBOutlet UIView *datePickerBg;
    IBOutlet UIButton *datePickerDoneButton;
    IBOutlet UIDatePicker *datePicker;
    
    
    NSString *deadline_1;
    NSString *deadline_3;
    
    
    //======================
    
    IBOutlet UIView *privateDateView;
    IBOutlet UILabel *startTimeLabel;
    IBOutlet UILabel *endTimeLabel;
    IBOutlet UITextField *startTimeTextField;
    IBOutlet UITextField *endTimeTextField;
    BOOL isStartOrDeadLine;
    
    IBOutlet UIView *datePickerBg2;
    IBOutlet UIButton *datePickerDoneButton2;
    IBOutlet UIDatePicker *datePicker2;
    
    missionModel *missionObj;
    
}

- (void)tapButton:(UIButton *) btn ;
-(BOOL)checkFieldIsCorrect;

@property (nonatomic,retain) NSString *deadline_1;
@property (nonatomic,retain) NSString *deadline_3;




@end
