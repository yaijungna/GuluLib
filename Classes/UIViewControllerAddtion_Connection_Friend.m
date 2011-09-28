//
//  UIViewControllerAddtion_Connection_Friend.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "UIViewControllerAddtion_Connection_Friend.h"


@implementation UIViewController(MyAdditions_friend)


-(void)addFriendConnection:(ACNetworkManager *)net  
				   photoID:(NSString *)pid  
					 phone:(NSString *)phoneStr
					 email:(NSString *)emailStr
				  favorite:(NSString *)favoriteStr
				  nickname:(NSString *)nicknameStr

{
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:pid forKey:@"photo_id"];
	[dict setObject:phoneStr forKey:@"phone"];
	[dict setObject:emailStr forKey:@"email"];
	[dict setObject:favoriteStr forKey:@"favorite"];
	[dict setObject:nicknameStr forKey:@"nickname"];
	
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"addFriend" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_FRIEND_ADD_FRIEND
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
