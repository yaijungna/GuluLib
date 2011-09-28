//
//  GuluTaskReviewModel.h
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"
#import "GuluPhotoModel.h"
#import "GuluUserModel.h"
#import "GuluTypeDefine.h"


@interface GuluTaskReviewModel : GuluModel
{
    NSString *group_task_id;
    NSString *task_title;
    GuluPhotoModel *review_photo;
    GuluUserModel *review_creator;
    NSString *review_content;
}


@property(nonatomic,retain) NSString *group_task_id;
@property(nonatomic,retain) NSString *task_title;
@property(nonatomic,retain) GuluPhotoModel *review_photo;
@property(nonatomic,retain) GuluUserModel *review_creator;
@property(nonatomic,retain) NSString *review_content;


@end
