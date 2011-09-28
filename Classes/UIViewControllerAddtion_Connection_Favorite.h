//
//  UIViewControllerAddtion_Connection_Favorite.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/16.
//  Copyright 2011 Gulu.com. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "UIViewControllerAddtion.h"
#import "ACNetworkManager.h"
#import "API_URL_FAVORITE.h"

@interface UIViewController(MyAdditions_favoriteConnection)

-(void)favoriteListConnection:(ACNetworkManager *)net userID:(NSString *)uid;
-(void)isFavoriteConnection:(ACNetworkManager *)net targetID:(NSString *)ID;

-(void)favoriteRestaurantConnection:(ACNetworkManager *)net restaurant:(NSMutableDictionary *)restaurantDict;
-(void)favoriteDishConnection:(ACNetworkManager *)net dish:(NSMutableDictionary *)dishDict;
-(void)favoriteMissionConnection:(ACNetworkManager *)net mission:(NSMutableDictionary *)missionDict;
-(void)favoriteFriendConnection:(ACNetworkManager *)net user:(NSString *)user_id;

-(void)unFavoriteRestaurantConnection:(ACNetworkManager *)net restaurant:(NSMutableDictionary *)restaurantDict;
-(void)unFavoriteDishConnection:(ACNetworkManager *)net dish:(NSMutableDictionary *)dishDict;
-(void)unFavoriteMissionConnection:(ACNetworkManager *)net mission:(NSMutableDictionary *)missionDict;
-(void)unFavoriteFriendConnection:(ACNetworkManager *)net user:(NSString *)user_id;

-(void)todoAddRestaurantConnection:(ACNetworkManager *)net restaurant:(NSMutableDictionary *)restaurantDict;
-(void)todoAddDishConnection:(ACNetworkManager *)net dish:(NSMutableDictionary *)dishDict;

-(void)likeConnection:(ACNetworkManager *)net target_id:(NSString *)target_id target_type:(NSString *)target_type;
-(void)disLikeConnection:(ACNetworkManager *)net target_id:(NSString *)target_id target_type:(NSString *)target_type;


@end

