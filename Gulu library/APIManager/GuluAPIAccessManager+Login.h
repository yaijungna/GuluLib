//
//  GuluAPIAccessManager+Login.h
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluAPIAccessManager.h"
#import "GuluUserModel.h"

#import "API_URL_USER.h"


@interface GuluAPIAccessManager(Login)


- (GuluHttpRequest *)signin :(id)target 
           username_or_email:(NSString *)nameEmail
                    password:(NSString *)pw;

- (GuluHttpRequest *)signup :(id)target 
                   username:(NSString *)name
                   password:(NSString *)pw
                      email:(NSString *)email
                      phone:(NSString *)phone;

- (GuluHttpRequest *)getFaceBookLogingToken :(id)target ;

- (GuluHttpRequest *)getUserObjectByFBToken :(id)target 
                                    facebookToken:(NSString *)fbtoken ;


@end
