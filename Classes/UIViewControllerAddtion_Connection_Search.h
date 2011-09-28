//
//  UIViewControllerAddtion_Connection_Search.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/16.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "UIViewControllerAddtion.h"
#import "ACNetworkManager.h"
#import "API_URL_SEARCH.h"
#import "API_URL_POST.h"

@interface UIViewController(MyAdditions_searchConnection)

- (void)searchNearDishbyPlace:(ACNetworkManager *)network  restaurant:(NSString *)rid; 
- (void)searchRestaurantConnection :(ACNetworkManager *)network  searchTerm:(NSString *)term   nearby: (CLLocation *)location;
- (void)searchDishConnection :(ACNetworkManager *)network  searchTerm:(NSString *)term nearby: (CLLocation *)location;
- (void)searchMissionConnection :(ACNetworkManager *)network  searchTerm:(NSString *)term;

- (void)searchDishAndPlacesConnection :(ACNetworkManager *)network  searchTerm:(NSString *)term;


@end

