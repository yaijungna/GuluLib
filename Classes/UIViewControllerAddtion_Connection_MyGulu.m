//
//  UIViewControllerAddtion_Connection_MyGulu.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/19.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "UIViewControllerAddtion_Connection_MyGulu.h"

@implementation UIViewController(MyAdditions_mygulu)

-(void)mypostConnection:(ACNetworkManager *)net  
{
	
	/***
	 @todo - 2011-06-24 - appDelegate.userMe.uid is not set and app crashing
	 */
	@try {
		NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
		
		NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
		[ADDdict setObject:@"mypost" forKey:@"id"];
		
		ASIFormDataRequest *request= [net createNewRequest:URL_MYGULU_MYPOST
										keyValueDictionary:dict 
										 addtionDictionary:ADDdict];
		[dict release];
		[ADDdict release];
		
		request.delegate=self;
		[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
		[request setDidFailSelector:@selector(ACConnectionFailed:)];
		
		[net addRequestToRequestsQueue:request];	
	}
	@catch (NSException * e) {
		/// @todo 2011-06-24 we are getting ready for the app store so no time to research this crash.
	}
	@finally {
		/// @todo need to check to make sure we are in a stable state
	}
}

-(void)aroundMeConnection:(ACNetworkManager *)net  
{	
	/***
	 @todo - 2011-06-24 - see above
	 */
	@try {
		NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
		
		NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
		[ADDdict setObject:@"aroundme" forKey:@"id"];
		
		ASIFormDataRequest *request= [net createNewRequest:URL_MYGULU_AROUNDME
										keyValueDictionary:dict 
										 addtionDictionary:ADDdict];
		[dict release];
		[ADDdict release];
		
		request.delegate=self;
		[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
		[request setDidFailSelector:@selector(ACConnectionFailed:)];
		
		[net addRequestToRequestsQueue:request];
	}
	@catch (NSException * e) {
		/// @todo 2011-06-24 we are getting ready for the app store so no time to research this crash.
	}
	@finally {
		/// @todo need to check to make sure we are in a stable state
	}
}


-(void)toDoListConnection:(ACNetworkManager *)net 
{
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"todolist" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_MYGULU_TODO
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	
}


-(void)feedConnection:(ACNetworkManager *)net
{
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"feed" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_MYGULU_FEED
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	

}

-(void)friendConnection:(ACNetworkManager *)net 
{
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"friend" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_MYGULU_FRIEND
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
}

-(void)completeToDoConnection:(ACNetworkManager *)net ID:(NSString *)todo_id
{
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:todo_id forKey:@"todo_id"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"completeToDo" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_TODO_COMPLETE
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];


}

-(void)deleteToDoConnection:(ACNetworkManager *)net ID:(NSString *)todo_id
{
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:todo_id forKey:@"todo_id"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"deleteToDo" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_TODO_DELETE
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];

}


-(void)userInfoConnection:(ACNetworkManager *)net ID:(NSString *)user_id
{
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:user_id forKey:@"user_id"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"userinfo" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_USER_USER_INFO
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];

}


-(void)updateUserInfoConnection:(ACNetworkManager *)net  
				   imageData:(NSData *)imagedata

{
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:imagedata forKey:@"uploadedfile"];
	
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"updateuserinfo" forKey:@"id"];
  //  [ADDdict setObject:@"" forKey:@"about_text"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_USER_UPLOAD_USER_INFO
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	
}

-(void)addFriendConnection:(ACNetworkManager *)net user_id:(NSString *)user_id;
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:user_id forKey:@"user_id"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"addfriend" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_USER_ADD_FRIEND
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
    
    
}

-(void)areFiendsConnection:(ACNetworkManager *)net user_id:(NSString *)user_id
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:user_id forKey:@"user_id"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"arefriends" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_USER_ARE_FRIENDS
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
