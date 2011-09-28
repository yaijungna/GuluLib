//
//  EventViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/22.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "AppStrings_invite.h"
#import "UIViewControllerAddtion_Connection_Invite.h"

#import "GuluEventModel.h"


@interface EventViewController : UIViewController  <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
	ACNetworkManager *network;
	TopMenuBarView *topView;
	BottomMenuBarView *bottomView;
	loadingSpinnerAndMessageView *LoadingView;
	IBOutlet UIView *myView;
	
	UILabel *eventTitleLabel;
	UILabel *whereTitleLabel;
	UILabel *whenTitleLabel;
	
	UITextField *titleTextField;
	UITextField *whereTextField;
	UITextField *whenTextField;
	
	
	UIButton *inviteBtn;
	UITableView *table;
	
	UIView *datePickerBackgroundView;
	UIButton *datePickerDonebtn;
	UIDatePicker *datePicker;

	inviteModel *inviteObj;
    
    GuluEventModel *event;
	
}
-(void)sendButton_hidden_or_show_up;

@property (nonatomic,retain) inviteModel *inviteObj;
@property (nonatomic,retain) GuluEventModel *event;

@end
