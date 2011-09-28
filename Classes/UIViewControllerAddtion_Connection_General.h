//
//  UIViewControllerAddtion_Connection_General.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/11.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "UIViewControllerAddtion.h"
#import "ACNetworkManager.h"
#import "API_URL_GENERAL.h"

@interface UIViewController(MyAdditions_generalConnection)

- (void)generalObjectConnection :(ACNetworkManager *)network objectID:(NSString *)objectID objectType: (NSString *)objectType;

- (void)getUserUUIDConnection :(ACNetworkManager *)network ;

- (void)getUserVoiceTokenConnection :(ACNetworkManager *)network ;

@end

