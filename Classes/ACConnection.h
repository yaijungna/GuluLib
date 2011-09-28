//
//  ACConnection.h
//
//  Created by chen alan on 2011/5/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

/*  How to use example:

	// 1.create connection
	ACConnection *connect=[[ACConnection alloc] init];
	
	// 2.set delegate 
	connect.delegate=self;
	
	// 3.init post value dicionary
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:[NSString stringWithFormat:@"4d89e6ef217db9124e000005"] forKey:@"uid"];
	[dict setObject:data1 forKey:@"uploadedfile"];
	
	// 4. set request
	[connect initPostRequest:@"http://demo.gd/api/create_photo/"
			 valueDictionary:dict timeout:0
					  tagStr:@"test" 
	  uploadProgressDelegate:nil
	downloadProgressDelegate:nil
					   other:nil];
*/
	
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"

@protocol ACConnectionDelegate

-(void)ACConnectionSuccess:(ASIFormDataRequest *)request;
-(void)ACConnectionFailed:(ASIFormDataRequest *)request;
-(void)ACConnectionQueueComplete;

@end

@interface ACConnection : NSObject {
	ASINetworkQueue *queue;
	id <ACConnectionDelegate> delegate;
	id queueUploadProgressIndicator;
	id queueUownloadProgressIndicator;
}

@property (nonatomic,retain)id <ACConnectionDelegate> delegate;
@property (nonatomic,retain)id queueUploadProgressIndicator;
@property (nonatomic,retain)id queueDownloadProgressIndicator;

- (void) cancelAllRequests;

- (void) initPostRequest:(NSString *)URL 
		 valueDictionary:(NSMutableDictionary *)dict 
				 timeout:(NSInteger)timeoutInt 
				  tagStr:(NSString *)tag
  uploadProgressDelegate:(id)uploadProgressIndicator
downloadProgressDelegate:(id)downloadProgressIndicator
				   other:(id)otherObj;

@end
