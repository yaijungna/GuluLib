//
//  ACConnection.m
//
//  Created by chen alan on 2011/5/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACConnection.h"

#define TIMEOUT 30

@implementation ACConnection

@synthesize delegate;
@synthesize queueUploadProgressIndicator;
@synthesize queueDownloadProgressIndicator;

- (id)init {
	[super init];
	
	queue=[[ASINetworkQueue alloc] init];
	[queue setShouldCancelAllRequestsOnFailure:YES];
	[queue setShowAccurateProgress:YES];
	[queue setQueueDidFinishSelector:@selector(queueComplete)];
	
	return self;
}

- (void) dealloc
{
	[queue cancelAllOperations];
	[queue release]; queue=nil;
	[queueUploadProgressIndicator release];
	[queueDownloadProgressIndicator release];
	[super dealloc];
}

//========================================

- (void) cancelAllRequests
{
	NSArray *array=[queue operations];
	
	for(ASIFormDataRequest *request in array ){
		request.delegate=nil;
		request=nil;
	}
	[queue cancelAllOperations];
}

- (void) initPostRequest:(NSString *)URL 
		 valueDictionary:(NSMutableDictionary *)dict 
				 timeout:(NSInteger)timeoutInt 
				  tagStr:(NSString *)tag
  uploadProgressDelegate:(id)uploadProgressIndicator
downloadProgressDelegate:(id)downloadProgressIndicator
				   other:(id)otherObj

{	
	NSURL *reqURL = [NSURL URLWithString:URL];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:reqURL];
	[request setAllowCompressedResponse:YES];
	
	NSArray *keys=[dict allKeys];
	
	if(timeoutInt==0)
		timeoutInt=TIMEOUT;
	
	
	for(NSString *key  in keys)
	{
		id valueObj=[dict objectForKey:key];
		
		if([valueObj isKindOfClass:[NSData class]])
		{
			[request setData:valueObj withFileName:@"app.jpg" andContentType:@"image/jpeg" forKey:key];
		}
		else if([valueObj isKindOfClass:[NSString class]])
		{
			[request setPostValue:valueObj forKey:key];
		}
	}
	[request setDidFinishSelector:@selector(RequestDone:)];
	[request setDidFailSelector:@selector(RequestFailed:)];
	[request setDownloadProgressDelegate:downloadProgressIndicator];
	[request setUploadProgressDelegate:uploadProgressIndicator];
	[request setShowAccurateProgress:YES]; 
	[request setTimeOutSeconds:timeoutInt];
	[request setDelegate:self];
	[request setShouldAttemptPersistentConnection:NO];
	[queue setDelegate:self];
	[queue setUploadProgressDelegate:queueUploadProgressIndicator];
	[queue setDownloadProgressDelegate:queueDownloadProgressIndicator];
	[queue addOperation:request];
	[queue go];
}

- (void)RequestDone:(ASIFormDataRequest *)request
{	
	[delegate ACConnectionSuccess:request];
	
	/*
	NSData *data= [request responseData];
	NSError *derror;
	
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	NSArray *array = [djsonDeserializer deserializeAsArray:data error:&derror];
	 
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	NSDictionary *array = [djsonDeserializer deserializeAsDictionary:data error:&derror];

	NSLog(@"%@",array);
	 */

}

- (void)RequestFailed:(ASIFormDataRequest *)request
{
	NSError *error = [request error];
	NSLog(@"[ACConnection.m] RequestFailed error= %@",error);
	[delegate ACConnectionFailed:request];
}

//===============================================
-(void) queueComplete
{
	NSLog(@"[ACConnection.m] queueComplete");
	[delegate ACConnectionQueueComplete];
}


@end
