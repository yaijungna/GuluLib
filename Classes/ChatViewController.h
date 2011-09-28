//
//  ChatViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/7.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_Invite.h"

#import "ChatEventHeaderView.h"

#import "chatRoomViewController.h"

@interface ChatViewController : chatRoomViewController < UIPickerViewDelegate,UIPickerViewDataSource> {
    ACNetworkManager *network;
	
	UIView *pickerBg;
	UIButton *selectBtn;
	UIPickerView *RSVPPicker;
	NSInteger selectRow;
	
	ChatEventHeaderView *tableHeaderView;
	
}


- (void)attendEvent;  
- (void)refuseEvent;  
@end
