//
//  GuluAPIAccessManager+Favorite+Like.h
//  GULUAPP
//
//  Created by alan on 11/9/9.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluAPIAccessManager.h"

#import "API_URL_FAVORITE.h"

@interface GuluAPIAccessManager(Favorite_like)

- (GuluHttpRequest *)favoriteSomething :(id)target            
             target_id:(NSString *)target_id
           target_type:(GuluTargetType)target_type;

- (GuluHttpRequest *)unfavoriteSomething :(id)target            
             target_id:(NSString *)target_id
           target_type:(GuluTargetType)target_type;

- (GuluHttpRequest *)likeSomething :(id)target            
             target_id:(NSString *)target_id
           target_type:(GuluTargetType)target_type;

- (GuluHttpRequest *)unlikeSomething :(id)target            
             target_id:(NSString *)target_id
           target_type:(GuluTargetType)target_type;


#pragma mark -
#pragma mark check Favorited

- (GuluHttpRequest *)checkTargetIfFavorited :(id)target            
                                   target_id:(NSString *)target_id;



@end
