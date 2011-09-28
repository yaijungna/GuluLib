//
//  GuluReviewModel.h
//  GULUAPP
//
//  Created by alan on 11/9/9.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"
#import "GuluDishModel.h"
#import "GuluPhotoModel.h"
#import "GuluUserModel.h"

#import "GuluTypeDefine.h"

@interface GuluReviewModel : GuluModel
{
    GuluDishModel *dish;
    GuluPlaceModel *restaurant;
    GuluPhotoModel *photo;
    GuluUserModel *user;
    
    NSString *content;
    float created; //created time
    NSInteger comment_count;
    NSInteger like_count;
    BOOL is_like;
    NSInteger thumb;
    
    NSString *group_id;
    NSString *task_id;

}

@property (nonatomic,retain) GuluDishModel *dish;
@property (nonatomic,retain) GuluPhotoModel *photo;
@property (nonatomic,retain) GuluPlaceModel *restaurant;
@property (nonatomic,retain) GuluUserModel *user;

@property (nonatomic,retain) NSString *content;
@property (nonatomic) float created; //created time
@property (nonatomic) NSInteger comment_count;
@property (nonatomic) NSInteger like_count;
@property (nonatomic) BOOL is_like;
@property (nonatomic) NSInteger thumb;

@property (nonatomic,retain) NSString *group_id;
@property (nonatomic,retain) NSString *task_id;



@end
