//
//  GuluAPIAccessManager.h
//  GULUAPP
//
//  Created by alan on 11/9/7.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluHttpRequest.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"
#import "debugDefined.h"
#import "GuluTypeDefine.h"

#import "GuluErrorMessageModel.h"


@protocol GuluAPIAccessManagerDelegate<NSObject>

- (void)GuluAPIAccessManagerSuccessed:(GuluHttpRequest*)httpRequest info:(id)info;
- (void)GuluAPIAccessManagerFailed:(GuluHttpRequest*)httpRequest info:(id)info;

@end

@interface GuluAPIAccessManager : NSObject
{
    NSString *sessionKey;
    NSString *uid;
    float latitude; 
    float longitude;
    
    GuluErrorMessageModel *errorModel;
}

@property(nonatomic,retain) NSString *sessionKey;
@property(nonatomic,retain) NSString *uid;
@property(nonatomic,assign) float latitude; 
@property(nonatomic,assign) float longitude;

@property(nonatomic,retain) GuluErrorMessageModel *errorModel;


+ (id)sharedManager;

- (void)initUserIDandSeesionKey:(NSString *)userID sessionKey:(NSString *)session lat:(float)lat lng:(float)lng;

- (GuluHttpRequest *)createNewGuluRequestWithURL:(NSString *)URL target:(id)target;
- (void)setupRequestWithData:(GuluHttpRequest*)Request  keyValueInfo:(NSMutableDictionary*)dict;

- (id)decodeJSONFromGuluRequest:(GuluHttpRequest*)Request;

//====private====
- (void)APIRequestFinish:(id)httpRequest returnData:(id)data;
- (void)APIRequestFail:(id)httpRequest returnData:(id)data;
//===============

@end

