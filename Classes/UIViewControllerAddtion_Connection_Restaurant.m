//
//  UIViewControllerAddtion_Connection_Restaurant.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/16.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "UIViewControllerAddtion_Connection_Restaurant.h"


@implementation UIViewController(MyAdditions_restaurant)

-(void)photoOfRestaurantConnection:(ACNetworkManager *)net restaurant:(NSString *)rid  
{	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:rid forKey:@"rid"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"restaurantphoto" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_RESTAURANT_PHOTO
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
}

-(void)dishOfRestaurantConnection:(ACNetworkManager *)net restaurant:(NSString *)rid  
{	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:rid forKey:@"rid"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"restaurantdish" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_RESTAURANT_DISH
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
}

-(void)reviewOfRestaurantConnection:(ACNetworkManager *)net restaurant:(NSString *)rid  
{	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:rid forKey:@"rid"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"restaurantreview" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_RESTAURANT_REVIEW
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
}

-(void)photoOfDishConnection:(ACNetworkManager *)net dish:(NSString *)did
{

	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:did forKey:@"did"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"dishphoto" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_DISH_PHOTO
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
