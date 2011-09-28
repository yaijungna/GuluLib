//
//  GuluAPIAccessManager+Notify.h
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluAPIAccessManager.h"

#import "API_URL_NOTIFY.h"
#import "GuluNotificationModel.h"


@interface GuluAPIAccessManager(Notify)

- (GuluHttpRequest *)allNotifications :(id)target;

- (GuluHttpRequest *)unReadNotifications :(id)target;

- (GuluHttpRequest *)markAllNotificationsToBeSeen :(id)target;

- (GuluHttpRequest *)respondFriendsRequestNotification:(id)target  
                                             senderID:(NSString *)senderID 
                                               respond:(NSString *)respond;
@end
