//
//  GuluPlaceModel.h
//  GULUAPP
//
//  Created by alan on 11/9/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"
#import "GuluPhotoModel.h"

@interface GuluPlaceModel :GuluModel
{
    NSString *name;
    NSString *address;
    NSString *city;
    NSString *district;
    NSString *get_follower_count;
    NSString *get_review_num;
    BOOL is_gulu_approved;
    NSString *phone;
    GuluPhotoModel *photo;
    NSString *score;
    
    float longitude;
    float latitude;
    
    NSString *best_known;

}

@property (nonatomic,retain)NSString *name;
@property (nonatomic,retain)NSString *address;
@property (nonatomic,retain)NSString *city;
@property (nonatomic,retain)NSString *district;
@property (nonatomic,retain)NSString *get_follower_count;
@property (nonatomic,retain)NSString *get_review_num;
@property (nonatomic)BOOL is_gulu_approved;
@property (nonatomic,retain)NSString *phone;
@property (nonatomic,retain)GuluPhotoModel *photo;
@property (nonatomic,retain)NSString *score;

@property(nonatomic)float longitude;
@property(nonatomic)float latitude;

@property (nonatomic,retain) NSString *best_known;

@end
