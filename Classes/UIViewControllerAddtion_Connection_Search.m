//
//  UIViewControllerAddtion_Connection_Search.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/16.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "UIViewControllerAddtion_Connection_Search.h"


@implementation UIViewController(MyAdditions_searchConnection)


- (void)searchNearDishbyPlace:(ACNetworkManager *)network  
                   restaurant:(NSString *)rid   
                      
{
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:rid forKey:@"rid"];

	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"dishofrestaurant" forKey:@"id"];
	
	ASIFormDataRequest *request= [network createNewRequest:URL_POST_GET_DISH_BY_RID 
                                        keyValueDictionary:dict 
                                         addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[network addRequestToRequestsQueue:request];
}



- (void)searchRestaurantConnection :(ACNetworkManager *)network  searchTerm:(NSString *)term   nearby: (CLLocation *)location
{	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:term forKey:@"term"];
//    [dict setObject:@"40" forKey:@"rtn_num"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"restaurantSearch" forKey:@"id"];
	
	ASIFormDataRequest *request= [network createNewRequest:URL_SEARCH_RESTAURANT
										keyValueDictionary:dict 
										 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[network addRequestToRequestsQueue:request];
}

- (void)searchDishConnection :(ACNetworkManager *)network  searchTerm:(NSString *)term nearby: (CLLocation *)location
{		
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:term forKey:@"term"];

	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"dishSearch" forKey:@"id"];
	
	ASIFormDataRequest *request= [network createNewRequest:URL_SEARCH_DISH
										keyValueDictionary:dict 
										 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[network addRequestToRequestsQueue:request];
}


- (void)searchMissionConnection :(ACNetworkManager *)network  searchTerm:(NSString *)term
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:term forKey:@"term"];
    
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"missionSearch" forKey:@"id"];
	
	ASIFormDataRequest *request= [network createNewRequest:URL_SEARCH_MISSION
										keyValueDictionary:dict 
										 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[network addRequestToRequestsQueue:request];
}

- (void)searchDishAndPlacesConnection :(ACNetworkManager *)network  searchTerm:(NSString *)term;
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:term forKey:@"term"];
    
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"dishPlaceSearch" forKey:@"id"];
	
	ASIFormDataRequest *request= [network createNewRequest:URL_SEARCH_DISH_PLACE
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
