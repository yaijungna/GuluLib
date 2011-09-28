//
//  GuluAPIAccessManager+Search.h
//  GULUAPP
//
//  Created by alan on 11/9/7.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluAPIAccessManager.h"

#import "API_URL_SEARCH.h"

#import "GuluPlaceModel.h"
#import "GuluDishModel.h"
#import "GuluMissionModel.h"

@interface GuluAPIAccessManager(Search)

- (GuluHttpRequest *)searchPlace :(id)target 
          searchTerm:(NSString *)searchTerm   
                 lat:(float)lat 
                 lng:(float)lng;


- (GuluHttpRequest *)searchDish :(id)target 
         searchTerm:(NSString *)searchTerm   
                lat:(float)lat 
                lng:(float)lng;

- (GuluHttpRequest *)searchMission :(id)target 
                         searchTerm:(NSString *)searchTerm  ;

@end
