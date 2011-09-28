//
//  GuluTaskModel.h
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"
#import "GuluDishModel.h"
#import "GuluPlaceModel.h"
#import "GuluPhotoModel.h"

#import "GuluTypeDefine.h"

@interface GuluTaskModel : GuluModel
{
    NSString *title;
    GuluPhotoModel *main_pic;
    NSString *description;
    GuluDishModel *dish;
    GuluPlaceModel *restaurant;
    BOOL show_place;
    BOOL show_dish;
    BOOL show_next;
    GuluTaskStatus status;
}

@property(nonatomic,retain)NSString *title;
@property(nonatomic,retain)GuluPhotoModel *main_pic;
@property(nonatomic,retain)NSString *description;
@property(nonatomic,retain)GuluDishModel *dish;
@property(nonatomic,retain)GuluPlaceModel *restaurant;
@property(nonatomic,assign)BOOL show_place;
@property(nonatomic,assign)BOOL show_dish;
@property(nonatomic,assign)BOOL show_next;
@property(nonatomic,assign)GuluTaskStatus status;


@end
