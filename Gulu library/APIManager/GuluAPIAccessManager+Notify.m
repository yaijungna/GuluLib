//
//  GuluAPIAccessManager+Notify.m
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluAPIAccessManager+Notify.h"

@implementation  GuluAPIAccessManager(Notify)

#pragma mark -
#pragma mark get all Notifications

- (GuluHttpRequest *)allNotifications :(id)target
{
    NSAssert(target,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_NOTIFY_ALL
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(allNotificationsFinish:)];
    [http setDidFailSelector:@selector(allNotificationsFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)allNotificationsFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
    
    for(NSDictionary *dict in info)
    {
        GuluNotificationModel *model=[[[GuluNotificationModel alloc] init] autorelease];
        [model switchDataIntoModel:dict];
        [array addObject:model];
    }
     
    [self APIRequestFinish:request returnData:array];
}

-(void)allNotificationsFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark unReadNotifications

- (GuluHttpRequest *)unReadNotifications :(id)target
{
    NSAssert(target,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_NOTIFY_UNREAD
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(unReadNotificationsFinish:)];
    [http setDidFailSelector:@selector(unReadNotificationsFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)unReadNotificationsFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
    
    for(NSDictionary *dict in info)
    {
        GuluNotificationModel *model=[[[GuluNotificationModel alloc] init] autorelease];
        [model switchDataIntoModel:dict];
        [array addObject:model];
    }
    
    [self APIRequestFinish:request returnData:array];
}

-(void)unReadNotificationsFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


#pragma mark -
#pragma mark set All Notifications To Be Seen

- (GuluHttpRequest *)markAllNotificationsToBeSeen :(id)target
{
    NSAssert(target,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_NOTIFY_ALL_SEEN
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(markAllNotificationsToBeSeeFinish:)];
    [http setDidFailSelector:@selector(markAllNotificationsToBeSeeFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)markAllNotificationsToBeSeeFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    [self APIRequestFinish:request returnData:info];
    
}

-(void)markAllNotificationsToBeSeeFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark respond Friend's Request

- (GuluHttpRequest *)respondFriendsRequestNotification:(id)target  
                                              senderID:(NSString *)senderID 
                                               respond:(NSString *)respond
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(senderID,@"Pass a null object.");
    NSAssert(respond,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:senderID forKey:@"user_id"];
    [dict setObject:respond forKey:@"respond"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_NOTIFY_RESPOND_FRIENDS
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(respondFriendsRequestNotificationFinish:)];
    [http setDidFailSelector:@selector(respondFriendsRequestNotificationFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)respondFriendsRequestNotificationFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];

    [self APIRequestFinish:request returnData:info];
}

-(void)respondFriendsRequestNotificationFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


@end
