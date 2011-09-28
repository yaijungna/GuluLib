//
//  GuluGroupMissionModel.h
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"
#import "GuluTypeDefine.h"


@interface GuluGroupMissionModel : GuluModel
{
    NSArray *attend_users;
    NSArray *task_reviews; //GuluTaskReviewModel Array
}

@property (nonatomic,retain) NSArray *attend_users;
@property (nonatomic,retain) NSArray *task_reviews;

@end
