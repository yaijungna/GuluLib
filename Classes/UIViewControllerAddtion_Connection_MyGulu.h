//
//  UIViewControllerAddtion_Connection_MyGulu.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/19.
//  Copyright 2011 Gulu.com. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "UIViewControllerAddtion.h"
#import "ACNetworkManager.h"
#import "API_URL_MYGULU.h"

@interface UIViewController(MyAdditions_mygulu)

-(void)mypostConnection:(ACNetworkManager *)net ;  
-(void)aroundMeConnection:(ACNetworkManager *)net ;
-(void)toDoListConnection:(ACNetworkManager *)net ;
-(void)feedConnection:(ACNetworkManager *)net ;
-(void)friendConnection:(ACNetworkManager *)net ;

-(void)completeToDoConnection:(ACNetworkManager *)net ID:(NSString *)todo_id;
-(void)deleteToDoConnection:(ACNetworkManager *)net ID:(NSString *)todo_id;

-(void)userInfoConnection:(ACNetworkManager *)net ID:(NSString *)user_id;

-(void)updateUserInfoConnection:(ACNetworkManager *)net  
                      imageData:(NSData *)imagedata;

-(void)addFriendConnection:(ACNetworkManager *)net user_id:(NSString *)user_id;
-(void)areFiendsConnection:(ACNetworkManager *)net user_id:(NSString *)user_id;

@end
