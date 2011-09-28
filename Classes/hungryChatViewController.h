//
//  hungryChatViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/15.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "chatRoomViewController.h"

#import "ChatEventHeaderView.h"

@interface hungryChatViewController  : chatRoomViewController{
    ChatEventHeaderView *tableHeaderView;
    
    ACNetworkManager *network;
	loadingSpinnerAndMessageView *LoadingView;
    
}

@end
