//
//  UIViewControllerAddtion_Connection_Notify.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "UIViewControllerAddtion_Connection_Notify.h"


@implementation UIViewController(MyAdditions_notify)

- (void)allNotificationConnection : (ACNetworkManager *)network
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"allnotification" forKey:@"id"];
	
	ASIFormDataRequest *request= [network createNewRequest:URL_NOTIFY_ALL
										keyValueDictionary:dict 
										 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[network addRequestToRequestsQueue:request];
}

- (void)unreadNotificationConnection :(ACNetworkManager *)network
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"unreadnotification" forKey:@"id"];
	
	ASIFormDataRequest *request= [network createNewRequest:URL_NOTIFY_UNREAD
										keyValueDictionary:dict 
										 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[network addRequestToRequestsQueue:request]; 
}

- (void)setAllToBeSeenNotificationConnection :(ACNetworkManager *)network
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"allseennotification" forKey:@"id"];
	
	ASIFormDataRequest *request= [network createNewRequest:URL_NOTIFY_ALL_SEEN
										keyValueDictionary:dict 
										 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[network addRequestToRequestsQueue:request]; 
}


- (void)respondFriendNotificationConnection :(ACNetworkManager *)network  senderID:(NSString*)uid  status:(NSString *)respond
{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:uid forKey:@"user_id"];
    [dict setObject:respond forKey:@"respond"];
    
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"respondfriendnotification" forKey:@"id"];
	
	ASIFormDataRequest *request= [network createNewRequest:URL_NOTIFY_RESPOND_FRIENDS
										keyValueDictionary:dict 
										 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[network addRequestToRequestsQueue:request];

    
    
}


@end