//
//  GuluAPIAccessManager+Favorite+Like.m
//  GULUAPP
//
//  Created by alan on 11/9/9.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluAPIAccessManager+Favorite+Like.h"

@implementation GuluAPIAccessManager(Favorite_like)

#pragma mark -
#pragma mark favorite

- (GuluHttpRequest *)favoriteSomething :(id)target            
                 target_id:(NSString *)target_id
               target_type:(GuluTargetType)target_type
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(target_id,@"Pass a null object.");
    
    NSString *URL=@"";
    NSString *keyString=@"";
    
    switch (target_type) {
        case GuluTargetType_photo:
            
            break;
        case GuluTargetType_review:
            URL=URL_FAVORITE_ADD_REVIEW;
            keyString=@"rid";
            break;
        case GuluTargetType_dish:
            URL=URL_FAVORITE_ADD_DISH;
            keyString=@"did";
            break;
        case GuluTargetType_place:
            URL=URL_FAVORITE_ADD_RESTAURANT;
             keyString=@"rid";
            break;
        case GuluTargetType_mission:
            URL=URL_FAVORITE_ADD_MISSION;
             keyString=@"mid";
            break;
        case GuluTargetType_user:
            URL=URL_FAVORITE_ADD_FRIEND;
            keyString=@"uid";
            break;
            
        default:
            break;
    }

    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:target_id forKey:keyString];
    [dict setObject:[NSString stringWithFormat:@"%d",target_type] forKey:@"target_type"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(favoriteSomethingFinish:)];
    [http setDidFailSelector:@selector(favoriteSomethingFail:)];
    [http startAsynchronous];
    
    return  http;
}


- (void)favoriteSomethingFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    [self APIRequestFinish:request returnData:info];
}

-(void)favoriteSomethingFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark unfavorite

- (GuluHttpRequest *)unfavoriteSomething :(id)target            
                   target_id:(NSString *)target_id
                 target_type:(GuluTargetType)target_type
{
    
    NSAssert(target,@"Pass a null object.");
    NSAssert(target_id,@"Pass a null object.");
    
    NSString *URL=@"";
    NSString *keyString=@"";
    
    switch (target_type) {
        case GuluTargetType_photo:
            
            break;
        case GuluTargetType_review:
            URL=URL_FAVORITE_REMOVE_REVIEW;
            keyString=@"rid";
            break;
        case GuluTargetType_dish:
            URL=URL_FAVORITE_REMOVE_DISH;
            keyString=@"did";
            break;
        case GuluTargetType_place:
            URL=URL_FAVORITE_REMOVE_RESTAURANT;
            keyString=@"rid";
            break;
        case GuluTargetType_mission:
            URL=URL_FAVORITE_REMOVE_MISSION;
            keyString=@"mid";
            break;
        case GuluTargetType_user:
            URL=URL_FAVORITE_REMOVE_FRIEND;
            keyString=@"uid";
            break;
            
        default:
            break;
    }

    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:target_id forKey:keyString];
    [dict setObject:[NSString stringWithFormat:@"%d",target_type] forKey:@"target_type"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(unfavoriteSomethingFinish:)];
    [http setDidFailSelector:@selector(unfavoriteSomethingFail:)];
    [http startAsynchronous];
    
    return  http;
}

- (void)unfavoriteSomethingFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    [self APIRequestFinish:request returnData:info];
}

-(void)unfavoriteSomethingFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark like

- (GuluHttpRequest *)likeSomething :(id)target            
             target_id:(NSString *)target_id
           target_type:(GuluTargetType)target_type
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(target_id,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:target_id forKey:@"target_id"];
    [dict setObject:[NSString stringWithFormat:@"%d",target_type] forKey:@"target_type"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_LIKE
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(likeSomethingFinish:)];
    [http setDidFailSelector:@selector(likeSomethingFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)likeSomethingFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
  
    [self APIRequestFinish:request returnData:info];
}

-(void)likeSomethingFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark unlike

- (GuluHttpRequest *)unlikeSomething :(id)target            
               target_id:(NSString *)target_id
             target_type:(GuluTargetType)target_type
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(target_id,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:target_id forKey:@"target_id"];
    [dict setObject:[NSString stringWithFormat:@"%d",target_type] forKey:@"target_type"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_DISLIKE
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(unlikeSomethingFinish:)];
    [http setDidFailSelector:@selector(unlikeSomethingFail:)];
    [http startAsynchronous];

    return http;
    
}

- (void)unlikeSomethingFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    [self APIRequestFinish:request returnData:info];
}

-(void)unlikeSomethingFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


#pragma mark -
#pragma mark check Favoriteds

- (GuluHttpRequest *)checkTargetIfFavorited :(id)target            
                                   target_id:(NSString *)target_id
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(target_id,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:target_id forKey:@"serial"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_FAVORITE_CHECK
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(checkTargetIfFavoritedFinish:)];
    [http setDidFailSelector:@selector(checkTargetIfFavoritedFail:)];
    [http startAsynchronous];
    
    return http;
    
}

- (void)checkTargetIfFavoritedFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    [self APIRequestFinish:request returnData:info];
}

-(void)checkTargetIfFavoritedFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}






@end
