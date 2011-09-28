//
//  UIViewControllerAddtion_Connection_SigninSignUp.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/16.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "UIViewControllerAddtion_Connection_SigninSignUp.h"


@implementation UIViewController(MyAdditions_signinsignup)


-(void)siginConnection:(ACNetworkManager *)net username:(NSString *)name password:(NSString *)pw  
{	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:name forKey:@"name_email"];
	[dict setObject:pw forKey:@"password"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"signin" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_USER_SIGNIN
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	
}

-(void)sigupConnection:(ACNetworkManager *)net username:(NSString *)name password:(NSString *)pw  email:(NSString *)email
{	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:name forKey:@"username"];
	[dict setObject:pw forKey:@"password"];
	[dict setObject:email forKey:@"email"];
	[dict setObject:@"0" forKey:@"phone"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"signup" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_USER_SIGNUP
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];	
}

-(void)getUserObjByFBRandomTokenConnection:(ACNetworkManager *)net facebook:(NSString *)token 
{	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:token forKey:@"fb_token"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"getUser" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_USER_FACEBOOK_GET_USER
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
