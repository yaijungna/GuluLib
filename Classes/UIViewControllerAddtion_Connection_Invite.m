//
//  UIViewControllerAddtion_Connection_Invite.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/22.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "UIViewControllerAddtion_Connection_Invite.h"


@implementation UIViewController(MyAdditions_invite)


-(void)createEventConnection:(ACNetworkManager *)net  
				restaurantID:(NSString *)rid  
					   Title:(NSString *)titleStr
						date:(NSString *)dateStr
					contacts:(NSString *)contact_list

{
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:rid forKey:@"rid"];
	[dict setObject:titleStr forKey:@"title"];
	[dict setObject:dateStr forKey:@"date"];
	[dict setObject:contact_list forKey:@"contact_list"];
	
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"createEvent" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_INVITE_CREATE_EVENT
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];

}

-(void)attendEventConnection:(ACNetworkManager *)net  
					 eventID:(NSString *)eid
{
	
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:eid forKey:@"eid"];

	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"attendEvent" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_INVITE_ATTENDE_EVENT
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	
	
	
	
}

-(void)refuseEventConnection:(ACNetworkManager *)net  
					 eventID:(NSString *)eid
{

	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:eid forKey:@"eid"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"refuseEvent" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_INVITE_REFUSE_EVENT
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	

}

-(void)eventGuetListConnection:(ACNetworkManager *)net  
					 eventID:(NSString *)eid
{
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:eid forKey:@"eid"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"eventGuestList" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_INVITE_GUESTLIST
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	
	
}

-(void)editEventConnection:(ACNetworkManager *)net  
						ID:(NSString *)eid
			  restaurantID:(NSString *)rid  
					 Title:(NSString *)titleStr
					  date:(NSString *)dateStr
				  contacts:(NSString *)contact_list

{
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:eid forKey:@"eid"];
	[dict setObject:rid forKey:@"rid"];
	[dict setObject:titleStr forKey:@"title"];
	[dict setObject:dateStr forKey:@"date"];
	[dict setObject:contact_list forKey:@"contact_list"];
	
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"editEvent" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_INVITE_EDIT
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
