//
//  missionChatViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/7.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "chatRoomViewController.h"

#import "ChatEventHeaderView.h"

@interface missionChatViewController : chatRoomViewController <TSAlertViewDelegate>{
    ChatEventHeaderView *tableHeaderView;
    
    ACNetworkManager *network;
	loadingSpinnerAndMessageView *LoadingView;
    
    
    NSDictionary *missionDict;
    
    TSAlertView *recruitAlert;
    BOOL fromProfile;

}
- (void)showRecruitAlert;

@property(nonatomic) BOOL fromProfile;

@end
