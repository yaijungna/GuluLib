//
//  GuluAroundMeModel.h
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"
#import "GuluUserModel.h"
#import "GuluPhotoModel.h"
#import "GuluPlaceModel.h"

#import "GuluTypeDefine.h"

@interface GuluAroundMeModel : GuluModel
{
    GuluPlaceModel *restaurant;
    GuluUserModel *user;
    GuluPhotoModel *photo;
    
    NSInteger like_count;
    NSInteger comment_count;
    float time_ago;
    
    NSString *target_id;
    GuluTargetType target_type;

}

@property(nonatomic,retain)GuluPlaceModel *restaurant;
@property(nonatomic,retain)GuluUserModel *user;
@property(nonatomic,retain)GuluPhotoModel *photo;

@property(nonatomic,assign)NSInteger like_count;
@property(nonatomic,assign)NSInteger comment_count;
@property(nonatomic,assign)float time_ago;

@property(nonatomic,retain)NSString *target_id;
@property(nonatomic,assign)GuluTargetType target_type;

@end
