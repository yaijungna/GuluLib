//
//  UIViewControllerAddtion_Connection_SigninSignUp.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/16.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewControllerAddtion.h"
#import "ACNetworkManager.h"
#import "API_URL_USER.h"

@interface UIViewController(MyAdditions_signinsignup)

-(void)siginConnection:(ACNetworkManager *)net username:(NSString *)name password:(NSString *)pw  ;
-(void)sigupConnection:(ACNetworkManager *)net username:(NSString *)name password:(NSString *)pw  email:(NSString *)email;
-(void)getUserObjByFBRandomTokenConnection:(ACNetworkManager *)net facebook:(NSString *)token ;

@end

