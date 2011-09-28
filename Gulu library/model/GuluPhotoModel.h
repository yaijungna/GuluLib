//
//  GuluPhotoModel.h
//  GULUAPP
//
//  Created by alan on 11/9/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"

@interface GuluPhotoModel : GuluModel
{
    NSString *get_photo_url;
    NSString *image_large;
    NSString *image_medium;
    NSString *image_small;
    NSString *target_id; 
    NSString *target_type;

}

@property(nonatomic,retain)NSString *get_photo_url;
@property(nonatomic,retain)NSString *image_large;
@property(nonatomic,retain)NSString *image_medium;
@property(nonatomic,retain)NSString *image_small;
@property(nonatomic,retain)NSString *target_id; 
@property(nonatomic,retain)NSString *target_type;

@end
