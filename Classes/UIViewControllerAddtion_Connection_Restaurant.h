//
//  UIViewControllerAddtion_Connection_Restaurant.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/16.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewControllerAddtion.h"
#import "ACNetworkManager.h"
#import "API_URL_RESTAURANT_DISH.h"

@interface UIViewController(MyAdditions_restaurant)

-(void)photoOfRestaurantConnection:(ACNetworkManager *)net restaurant:(NSString *)rid;  
-(void)dishOfRestaurantConnection:(ACNetworkManager *)net restaurant:(NSString *)rid;
-(void)reviewOfRestaurantConnection:(ACNetworkManager *)net restaurant:(NSString *)rid;

-(void)photoOfDishConnection:(ACNetworkManager *)net dish:(NSString *)did;

@end

