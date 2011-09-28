//
//  ACNetworkManager.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/31.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACNetworkManager.h"
#import "debugDefined.h"
#import "TSAlertView.h"
#import "ACCheckConnection.h"

@implementation ACNetworkManager

static id sharedMyManager_network = nil;

@synthesize requestsQueue;
@synthesize userMe;

+ (id)sharedManager {
	@synchronized(self){
        if(sharedMyManager_network == nil)
            sharedMyManager_network = [[super alloc] init];
    }
    return sharedMyManager_network;
}

- (id)init {
	
    self=[super init];
	if(self)
	{
		requestsQueue=[[ASINetworkQueue alloc] init];
		[requestsQueue setShouldCancelAllRequestsOnFailure:NO];
		[requestsQueue setShowAccurateProgress:YES];
		
		photoRequestsQueue=[[ASINetworkQueue alloc] init];
		[photoRequestsQueue setShouldCancelAllRequestsOnFailure:NO];
		[photoRequestsQueue setShowAccurateProgress:YES];
		
		
		
		return self;
	}
	return self;
}


- (void) dealloc
{
    [self cancelAllRequestsInRequestsQueue];
    
	[requestsQueue release];
    [photoRequestsQueue release];
	[super dealloc];
}

#pragma mark -

- (void) cancelAllRequestsInRequestsQueue
{
	NSArray *array=[requestsQueue operations];
	
	for(ASIFormDataRequest *request in array ){
		request.delegate=nil;
		request=nil;}
	
	[requestsQueue cancelAllOperations];
	
	NSLog(@"[ACNetworkManager.m]cancelAllRequestsInRequestsQueue");
}

- (void) cancelAllPhotoRequestsInRequestsQueue
{
	NSArray *array=[photoRequestsQueue operations];
	
	for(ASIFormDataRequest *request in array ){
		request.delegate=nil;
		request=nil;}
	
	[photoRequestsQueue cancelAllOperations];
	
	NSLog(@"[ACNetworkManager.m]cancelAllPhotoRequestsInRequestsQueue");
}


- (void) cancelSpecifyRequestInRequestsQueue:(NSString *)keyString
{
	NSArray *array=[requestsQueue operations];
	
	for(ASIFormDataRequest *request in array )
	{
		assert(request.additionDataDictionary);
		
		if([[request.additionDataDictionary objectForKey:@"id"] isEqualToString:keyString ])
		{
			request.delegate=nil;
			request=nil;
			[request cancel];
		}
	}
}

- (ASIFormDataRequest *) createNewRequest:(NSString *)URL 
							keyValueDictionary:(NSMutableDictionary *)dict
							 addtionDictionary:(NSMutableDictionary *)addDict
{
	assert(URL);
	
	NSURL *reqURL = [NSURL URLWithString:URL];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:reqURL];
	
	NSArray *keys=[dict allKeys];
	for(NSString *key  in keys)
	{
		id valueObj=[dict objectForKey:key];
		
		if([valueObj isKindOfClass:[NSData class]])
		{
            NSString *filename=[NSString stringWithFormat:@"%d",[NSDate date]];
            
            NSString *namestring=[NSString stringWithFormat:@"app%u.jpg",[filename hash]];
            
           // ACLog(@"%@",namestring);
           // ACLog(@"%@",valueObj);
            
			[request setData:valueObj withFileName:namestring andContentType:@"image/jpeg" forKey:key];
		}
		else if([valueObj isKindOfClass:[NSString class]])
		{
			[request setPostValue:valueObj forKey:key];
		}
	}
	request.additionDataDictionary=addDict;
	
	
	//===
	
	if(userMe!=nil)
	{
		[request setPostValue:[NSString stringWithFormat:@"%f",userMe.myLocation.coordinate.latitude] forKey:@"lat"];
		[request setPostValue:[NSString stringWithFormat:@"%f",userMe.myLocation.coordinate.longitude] forKey:@"lng"];
		[request setPostValue:userMe.sessionKey forKey:@"session_key"];
		[request setPostValue:userMe.uid forKey:@"uid"];
	}
	
	//===
	
	
	[request setAllowCompressedResponse:YES];
	[request setShowAccurateProgress:YES]; 
	[request setTimeOutSeconds:TIMEOUT];
	[request setShouldAttemptPersistentConnection:NO];
	
	return request;
}

- (void) addRequestToRequestsQueue:(ASIFormDataRequest *)request
{
	assert(request);


	[requestsQueue addOperation:request];
	[requestsQueue go];
}

- (void) addRequestToPhotoRequestsQueue:(ASIFormDataRequest *)request
{
	assert(request);
	
	[photoRequestsQueue addOperation:request];
	[photoRequestsQueue go];
}




@end

