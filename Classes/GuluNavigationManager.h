//
//  
//  GULUAPP
//
//  Created by alan on 11/9/27.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GuluMapViewController.h"
#import "RestaurantProfileViewController.h"
#import "dishProfileViewController.h"
#import "EventViewController.h"
#import "missionProfileviewcontroller.h"

@interface GuluNavigationManager : NSObject

+(id)getVCWithNibName:(NSString *)name ;
+(id)getVC:(NSString *)name ;

+(void)gotoMap:(UINavigationController *)nav  place:(GuluPlaceModel *)place ;
//+(void)gotoReviewProfile;
+(void)gotoPlaceProfile:(UINavigationController *)nav  place:(GuluPlaceModel *)place;
+(void)gotoDishProfile:(UINavigationController *)nav  dish:(GuluDishModel *)dish;
+(void)gotoMissionProfile:(UINavigationController *)nav  missions:(GuluMissionModel *)mission;

//+(void)gotoUserProfile;
+(void)gotoCreateEvent:(UINavigationController *)nav place:(GuluPlaceModel *)place  dish:(GuluDishModel *)dish;



@end
