//
//  UIViewControllerAddtion_Connection_Invite.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/22.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "ACNetworkManager.h"
#import "API_URL_INVITE.h"

@interface UIViewController(MyAdditions_invite)

-(void)createEventConnection:(ACNetworkManager *)net  
				restaurantID:(NSString *)rid  
					   Title:(NSString *)titleStr
						date:(NSString *)dateStr
					contacts:(NSString *)contact_list;

-(void)attendEventConnection:(ACNetworkManager *)net  
					 eventID:(NSString *)eid;

-(void)refuseEventConnection:(ACNetworkManager *)net  
					 eventID:(NSString *)eid;

-(void)eventGuetListConnection:(ACNetworkManager *)net  
					   eventID:(NSString *)eid;

-(void)editEventConnection:(ACNetworkManager *)net  
						ID:(NSString *)eid
			  restaurantID:(NSString *)rid  
					 Title:(NSString *)titleStr
					  date:(NSString *)dateStr
				  contacts:(NSString *)contact_list;
@end
