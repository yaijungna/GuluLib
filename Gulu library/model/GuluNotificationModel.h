//
//  GuluNotificationModel.h
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GuluModel.h"
#import "GuluUserModel.h"

#import "GuluTypeDefine.h"

@interface GuluNotificationModel  : GuluModel
{
    NSDictionary *object;
    GuluTargetType object_type;
    GuluUserModel *from_user;
    NSString *message;
    BOOL unseen;
    GuluNotifyType notify_type;
    float created;
    NSString *title;
    NSInteger status;
    
    id objectModel;
    
}

@property (nonatomic,retain)NSDictionary *object;
@property (nonatomic,assign)GuluTargetType object_type;
@property (nonatomic,retain)GuluUserModel *from_user;
@property (nonatomic,retain)NSString *message;
@property (nonatomic,assign)BOOL unseen;
@property (nonatomic,assign)GuluNotifyType notify_type;
@property (nonatomic,assign)float created;
@property (nonatomic,retain)NSString *title;
@property (nonatomic,assign)NSInteger status;

@property (nonatomic,retain)id objectModel;


- (NSString *)handleNotificatioMessageString;


@end
