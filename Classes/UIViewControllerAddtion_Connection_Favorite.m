//
//  UIViewControllerAddtion_Connection_Favorite.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/16.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "UIViewControllerAddtion_Connection_Favorite.h"



@implementation UIViewController(MyAdditions_favoriteConnection)

-(void)favoriteListConnection:(ACNetworkManager *)net userID:(NSString *)uid
{
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:uid forKey:@"user_id"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"FavoriteList" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_FAVORITE_LIST
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
}


-(void)isFavoriteConnection:(ACNetworkManager *)net targetID:(NSString *)ID
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:ID forKey:@"serial"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"isFavorite" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_FAVORITE_CHECK
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];

}


-(void)unFavoriteRestaurantConnection:(ACNetworkManager *)net restaurant:(NSMutableDictionary *)restaurantDict
{
	NSString *rid=[restaurantDict objectForKey:@"id"];
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:rid forKey:@"rid"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"removeFavoriteRestaurant" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_FAVORITE_REMOVE_RESTAURANT
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	
}

-(void)unFavoriteDishConnection:(ACNetworkManager *)net dish:(NSMutableDictionary *)dishDict
{
	NSString *did=[dishDict objectForKey:@"id"];
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:did forKey:@"did"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"removeFavoriteDish" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_FAVORITE_REMOVE_DISH
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	
}

-(void)unFavoriteMissionConnection:(ACNetworkManager *)net mission:(NSMutableDictionary *)missionDict
{
	NSString *mid=[missionDict objectForKey:@"id"];
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:mid forKey:@"mid"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"removeFavoriteMission" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_FAVORITE_REMOVE_MISSION
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	
}

-(void)unFavoriteFriendConnection:(ACNetworkManager *)net user:(NSString *)user_id;
{
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:user_id forKey:@"user_id"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"removeFavoriteUser" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_FAVORITE_REMOVE_FRIEND
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	
}

-(void)favoriteFriendConnection:(ACNetworkManager *)net user:(NSString *)user_id;
{
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:user_id forKey:@"user_id"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"FavoriteUser" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_FAVORITE_ADD_FRIEND
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	
}


-(void)favoriteMissionConnection:(ACNetworkManager *)net mission:(NSMutableDictionary *)missionDict
{
	NSString *mid=[missionDict objectForKey:@"id"];
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:mid forKey:@"mid"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"addFavoriteMission" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_FAVORITE_ADD_MISSION
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	
}


-(void)favoriteRestaurantConnection:(ACNetworkManager *)net restaurant:(NSMutableDictionary *)restaurantDict
{
	NSString *rid=[restaurantDict objectForKey:@"id"];
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:rid forKey:@"rid"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"addFavoriteRestaurant" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_FAVORITE_ADD_RESTAURANT
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	
}

-(void)favoriteDishConnection:(ACNetworkManager *)net dish:(NSMutableDictionary *)dishDict
{
	NSString *did=[dishDict objectForKey:@"id"];
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:did forKey:@"did"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"addFavoriteDish" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_FAVORITE_ADD_DISH
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	
}


-(void)todoAddRestaurantConnection:(ACNetworkManager *)net restaurant:(NSMutableDictionary *)restaurantDict
{
	NSString *rid=[restaurantDict objectForKey:@"id"];
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:rid forKey:@"rid"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"addTodoRestaurant" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_TODO_ADD_RESTAURANT
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	
	

}

-(void)todoAddDishConnection:(ACNetworkManager *)net dish:(NSMutableDictionary *)dishDict
{
	
	NSString *did=[dishDict objectForKey:@"id"];
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:did forKey:@"did"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"addTodoDish" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_TODO_ADD_DISH
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];

}


-(void)likeConnection:(ACNetworkManager *)net target_id:(NSString *)target_id target_type:(NSString *)target_type
{	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:target_id forKey:@"target_id"];
	[dict setObject:target_type forKey:@"target_type"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"like" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_LIKE
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
}

-(void)disLikeConnection:(ACNetworkManager *)net target_id:(NSString *)target_id target_type:(NSString *)target_type
{	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:target_id forKey:@"target_id"];
	[dict setObject:target_type forKey:@"target_type"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"dislike" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_DISLIKE
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
