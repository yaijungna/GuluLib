//
//  GuluAPIAccessManager+Other.h
//  GULUAPP
//
//  Created by alan on 11/9/9.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluAPIAccessManager.h"

#import "API_URL_GENERAL.h"

#import "GuluPhotoModel.h"
#import "GuluPlaceModel.h"
#import "GuluDishModel.h"
#import "GuluReviewModel.h"
#import "GuluUserModel.h"


@interface GuluAPIAccessManager(Other)


- (GuluHttpRequest *)getObject :(id)target            
                      target_id:(NSString *)target_id
                    target_type:(GuluTargetType)target_type;

- (GuluHttpRequest *)registerDeviceForNotification:(id)target            
                                       deviceToken:(NSString *)deviceToken;


@end
