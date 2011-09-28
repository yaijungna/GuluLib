//
//  GuluNavigationManager.m
//  GULUAPP
//
//  Created by alan on 11/9/27.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluNavigationManager.h"

@implementation GuluNavigationManager

+(id)getVCWithNibName:(NSString *)name 
{
    Class VCClass = NSClassFromString(name);
    id VC=[[VCClass alloc] initWithNibName:name bundle:nil];
    return [VC autorelease];
}

+(id)getVC:(NSString *)name 
{
    Class VCClass = NSClassFromString(name);
    id VC=[[VCClass alloc] init];
    return [VC autorelease];
}

+(void)gotoMap:(UINavigationController *)nav  place:(GuluPlaceModel *)place 
{
    GuluMapViewController *VC=[GuluNavigationManager getVC:@"GuluMapViewController"];	
	VC.place=place;
	[nav pushViewController:VC animated:YES];
}

+(void)gotoPlaceProfile:(UINavigationController *)nav  place:(GuluPlaceModel *)place 
{
    RestaurantProfileViewController *VC=[GuluNavigationManager getVCWithNibName:@"RestaurantProfileViewController"];
    VC.place=place;
    [nav pushViewController:VC animated:YES];
}

+(void)gotoDishProfile:(UINavigationController *)nav  dish:(GuluDishModel *)dish 
{
    dishProfileViewController *VC=[GuluNavigationManager getVCWithNibName:@"dishProfileViewController"];
    VC.dish=dish;
    [nav pushViewController:VC animated:YES];
}

+(void)gotoCreateEvent:(UINavigationController *)nav place:(GuluPlaceModel *)place  dish:(GuluDishModel *)dish
{
    EventViewController *VC=[GuluNavigationManager getVCWithNibName:@"EventViewController"];
    [nav pushViewController:VC animated:YES];
}

+(void)gotoMissionProfile:(UINavigationController *)nav  missions:(GuluMissionModel *)mission
{
    missionProfileviewcontroller *VC=[GuluNavigationManager getVCWithNibName:@"missionProfileviewcontroller"];
    [nav pushViewController:VC animated:YES];
}


@end
