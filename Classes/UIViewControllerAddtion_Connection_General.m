//
//  UIViewControllerAddtion_Connection_General.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/11.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "UIViewControllerAddtion_Connection_General.h"


@implementation UIViewController(MyAdditions_generalConnection)

- (void)generalObjectConnection :(ACNetworkManager *)network objectID:(NSString *)objectID objectType: (NSString *)objectType
{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:objectID forKey:@"object_id"];
    [dict setObject:objectType forKey:@"object_type"];
    
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"generalobject" forKey:@"id"];
	
	ASIFormDataRequest *request= [network createNewRequest:URL_GENERAL_OBJECT
										keyValueDictionary:dict 
										 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[network addRequestToRequestsQueue:request];

}

- (void)getUserUUIDConnection :(ACNetworkManager *)network 
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"userUUID" forKey:@"id"];
	
	ASIFormDataRequest *request= [network createNewRequest:URL_USER_UUID
										keyValueDictionary:dict 
										 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[network addRequestToRequestsQueue:request];



}

- (void)getUserVoiceTokenConnection :(ACNetworkManager *)network 
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"uservoice" forKey:@"id"];
	
	ASIFormDataRequest *request= [network createNewRequest:URL_USERVOICE_TOKEN
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