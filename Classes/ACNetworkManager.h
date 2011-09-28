//
//  ACNetworkManager.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/31.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "userMeModel.h"

#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"
#import "AppSettings.h"

@interface ACNetworkManager : NSObject {
	ASINetworkQueue *requestsQueue;
	ASINetworkQueue *photoRequestsQueue;
	
	userMeModel *userMe;
}
@property(nonatomic,retain)ASINetworkQueue *requestsQueue;
@property(nonatomic,assign)userMeModel *userMe;

+ (id) sharedManager;

- (ASIFormDataRequest *) createNewRequest:(NSString *)URL 
					   keyValueDictionary:(NSMutableDictionary *)dict
						addtionDictionary:(NSMutableDictionary *)addDict;

- (void) addRequestToRequestsQueue:(ASIFormDataRequest *)request;
- (void) addRequestToPhotoRequestsQueue:(ASIFormDataRequest *)request;
- (void) cancelAllRequestsInRequestsQueue;
- (void) cancelAllPhotoRequestsInRequestsQueue;
- (void) cancelSpecifyRequestInRequestsQueue:(NSString *)keyString;

@end
