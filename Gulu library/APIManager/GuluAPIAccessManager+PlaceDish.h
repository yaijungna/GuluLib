//
//  GuluAPIAccessManager+PlaceDish.h
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluAPIAccessManager.h"

#import "API_URL_POST.h"
#import "API_URL_RESTAURANT_DISH.h"

#import "GuluReviewModel.h"
#import "GuluPhotoModel.h"
#import "GuluDishModel.h"


@interface GuluAPIAccessManager(PlaceDish)

- (GuluHttpRequest *)bestKnownForTags :(id)target 
                              ridORdid:(NSString *)targetid;

- (GuluHttpRequest *)dishesOfPlace :(id)target 
                              placeID:(NSString *)placeID;

- (GuluHttpRequest *)reviewsOfPlace :(id)target 
                            placeID:(NSString *)placeID;

- (GuluHttpRequest *)photosOfPlace :(id)target 
                             placeID:(NSString *)placeID;

- (GuluHttpRequest *)photosOfDish :(id)target 
                             dishID:(NSString *)dishID;


@end
