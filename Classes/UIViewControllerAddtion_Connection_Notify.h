//
//  UIViewControllerAddtion_Connection_Notify.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "ACNetworkManager.h"
#import "API_URL_NOTIFY.h"

@interface UIViewController(MyAdditions_notify)

- (void)allNotificationConnection : (ACNetworkManager *)network;
- (void)unreadNotificationConnection :(ACNetworkManager *)network;
- (void)setAllToBeSeenNotificationConnection :(ACNetworkManager *)network;
- (void)respondFriendNotificationConnection :(ACNetworkManager *)network  senderID:(NSString*)uid  status:(NSString *)respond;

@end

