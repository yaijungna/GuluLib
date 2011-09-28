//
//  GuluAPIAccessManager+Post.h
//  GULUAPP
//
//  Created by alan on 11/9/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluAPIAccessManager.h"

#import "API_URL_POST.h"

#import "GuluPhotoModel.h"
#import "GuluPlaceModel.h"
#import "GuluDishModel.h"
#import "GuluReviewModel.h"

@interface GuluAPIAccessManager(Post)

- (GuluHttpRequest *)postImage :(id)target 
             photo:(UIImage *)photo;

- (GuluHttpRequest *)createNewPlace :(id)target 
             placeObject:(GuluPlaceModel *)placeObject;

- (GuluHttpRequest *)createNewReview :(id)target 
            reviewObject:(GuluReviewModel*)reviewObject;
        

@end
