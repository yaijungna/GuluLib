//
//  UIViewControllerAddtion_Connection_Friend.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "ACNetworkManager.h"
#import "API_URL_INVITE.h"

@interface UIViewController(MyAdditions_friend)

-(void)addFriendConnection:(ACNetworkManager *)net  
				   photoID:(NSString *)pid  
					 phone:(NSString *)phoneStr
					 email:(NSString *)emailStr
				  favorite:(NSString *)favoriteStr
				  nickname:(NSString *)nicknameStr;

@end
