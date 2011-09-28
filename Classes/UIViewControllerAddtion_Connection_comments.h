//
//  UIViewControllerAddtion_Connection_comments.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/20.
//  Copyright 2011 Gulu.com. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "UIViewControllerAddtion.h"
#import "ACNetworkManager.h"
#import "API_URL_COMMENTS.h"

@interface UIViewController(MyAdditions_comments)

-(void)commentListConnection:(ACNetworkManager *)net target_id:(NSString *)target_id;

-(void)commentPostConnection:(ACNetworkManager *)net 
				   target_id:(NSString *)target_id 
				 target_type:(NSString *)target_type
						text:(NSString *)text;
@end
