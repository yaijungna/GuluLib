//
//  UIViewControllerAddtion_Connection_chat.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/21.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "UIViewControllerAddtion_Connection_chat.h"


@implementation UIViewController(MyAdditions_chat)


-(void)chatListConnection:(ACNetworkManager *)net;
{
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"chatList" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_CHAT_CHATROOMLIST
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	
}

@end
