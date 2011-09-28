//
//  GuluDishModel.h
//  GULUAPP
//
//  Created by alan on 11/9/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"
#import "GuluPlaceModel.h"
#import "GuluPhotoModel.h"
#import "GuluUserModel.h"

@interface GuluDishModel : GuluModel
{
    GuluPlaceModel *restaurant;
    GuluPhotoModel *photo;
    GuluUserModel *user;
    
    NSString *name;
    NSString *best_known;

}

@property (nonatomic,retain)GuluPlaceModel *restaurant;
@property (nonatomic,retain)GuluPhotoModel *photo;
@property (nonatomic,retain)GuluUserModel *user;

@property (nonatomic,retain)NSString *name;
@property (nonatomic,retain)NSString *best_known;

@end

