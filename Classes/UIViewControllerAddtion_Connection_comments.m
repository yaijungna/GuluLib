//
//  UIViewControllerAddtion_Connection_comments.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/20.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "UIViewControllerAddtion_Connection_comments.h"

@implementation UIViewController(MyAdditions_comments)

-(void)commentListConnection:(ACNetworkManager *)net target_id:(NSString *)target_id
{	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:target_id forKey:@"target_id"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"commentlist" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_COMMENT_LIST
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
}


-(void)commentPostConnection:(ACNetworkManager *)net target_id:(NSString *)target_id target_type:(NSString *)target_type text:(NSString *)text
{	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:target_id forKey:@"target_id"];
	[dict setObject:target_type forKey:@"target_type"];
	[dict setObject:text forKey:@"text"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"commentpost" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_COMMENT_POST
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
