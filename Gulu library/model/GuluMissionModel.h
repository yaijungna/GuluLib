//
//  GuluMissionModel.h
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"
#import "GuluUserModel.h"
#import "GuluPhotoModel.h"
#import "GuluGuestModel.h"
#import "GuluTypeDefine.h"


@interface GuluMissionModel : GuluModel
{
    NSString *title;
    GuluUserModel *created_user;
    NSString *description;
    float start;
    float deadline;
    GuluMissionType type;
    GuluPhotoModel *badge_pic;
    NSInteger allowed_mins;
    GuluMissionMemberStatus member_status;
    GuluMissionGroupStatus group_status;
    GuluUserModel *inviter;
    NSInteger member_num;
    NSString *group_id;
    NSInteger group_number;
    NSInteger grade_number;
}

@property (nonatomic,retain)NSString *title;
@property (nonatomic,retain)GuluUserModel *created_user;
@property (nonatomic,retain)NSString *description;
@property (nonatomic,assign)float start;
@property (nonatomic,assign)float deadline;
@property (nonatomic,assign)GuluMissionType type;
@property (nonatomic,retain)GuluPhotoModel *badge_pic;
@property (nonatomic,assign)NSInteger allowed_mins;
@property (nonatomic,assign)GuluMissionMemberStatus member_status;
@property (nonatomic,assign)GuluMissionGroupStatus group_status;
@property (nonatomic,retain)GuluUserModel *inviter;
@property (nonatomic,assign)NSInteger member_num;
@property (nonatomic,retain)NSString *group_id;
@property (nonatomic,assign)NSInteger group_number;
@property (nonatomic,assign)NSInteger grade_number;

-(NSString *) contactListString:(NSMutableArray *)contactsArray;

@end
