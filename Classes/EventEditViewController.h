//
//  EventEditViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "AppStrings_invite.h"
#import "UIViewControllerAddtion_Connection_Invite.h"

@interface EventEditViewController : UIViewController  <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
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
	
}
-(void)sendButton_hidden_or_show_up;
-(void)callBackChangeContactListFunction;

@property (nonatomic,retain) inviteModel *inviteObj;

@end
