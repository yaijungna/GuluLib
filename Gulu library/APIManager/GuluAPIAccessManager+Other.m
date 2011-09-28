//
//  GuluAPIAccessManager+Other.m
//  GULUAPP
//
//  Created by alan on 11/9/9.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluAPIAccessManager+Other.h"

@implementation GuluAPIAccessManager(Other)


#pragma mark -
#pragma mark  get gulu Object 

- (GuluHttpRequest *)getObject :(id)target            
                      target_id:(NSString *)target_id
                    target_type:(GuluTargetType)target_type
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(target_id,@"Pass a null object.");
    NSAssert(target_type,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:[NSString stringWithFormat:@"%d",target_type] forKey:@"object_type"];
    [dict setObject:target_id forKey:@"object_id"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_GENERAL_OBJECT
                                                       target:target];
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(getObjectFinish:)];
    [http setDidFailSelector:@selector(getObjectFail:)];
    [http startAsynchronous];
    
    return http;
    
    
}
- (void)getObjectFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSString* typeString =[info objectForKey:@"object_type"];
    int type=[typeString intValue];
    NSDictionary *objectDict=[info  objectForKey:@"object"];
    
    id model=[GuluModel getObjectByObjectType:type data:objectDict];
   
    [self APIRequestFinish:request returnData:model];
}

-(void)getObjectFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark register Device

- (GuluHttpRequest *)registerDeviceForNotification:(id)target            
                                       deviceToken:(NSString *)deviceToken
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(deviceToken,@"Pass a null object.");
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_REGISTER_DEVICE_ID
                                                       target:target];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(registerDeviceForNotificationFinish:)];
    [http setDidFailSelector:@selector(registerDeviceForNotificationFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)registerDeviceForNotificationFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    [self APIRequestFinish:request returnData:info];
}

-(void)registerDeviceForNotificationFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


@end
