//
//  GuluAPIAccessManager+Login.m
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluAPIAccessManager+Login.h"


@implementation GuluAPIAccessManager(Login)

#pragma mark -
#pragma mark signin

- (GuluHttpRequest *)signin :(id)target 
                   username_or_email:(NSString *)nameEmail
                   password:(NSString *)pw
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(nameEmail,@"Pass a null object.");
    NSAssert(pw,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:nameEmail forKey:@"name_email"];
	[dict setObject:pw forKey:@"password"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_USER_SIGNIN
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(signinFinish:)];
    [http setDidFailSelector:@selector(signinFail:)];
    [http startAsynchronous];
    
    return http;
    
}

- (void)signinFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    if([info isKindOfClass:[GuluErrorMessageModel class]])
    {
        [self APIRequestFinish:request returnData:info];
    }
    else
    {
        NSDictionary *data=[info objectForKey:@"user"];
        NSString *session_key=[info objectForKey:@"session_key"];
        
        self.sessionKey=session_key;
        
        GuluUserModel *model=[[[GuluUserModel alloc] init] autorelease];
        [model switchDataIntoModel:data];
        
        [self APIRequestFinish:request returnData:model];
    }
}

-(void)signinFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


#pragma mark -
#pragma mark signup

- (GuluHttpRequest *)signup :(id)target 
                   username:(NSString *)name
                   password:(NSString *)pw
                      email:(NSString *)email
                      phone:(NSString *)phone
{
    
    NSAssert(target,@"Pass a null object.");
    NSAssert(name,@"Pass a null object.");
    NSAssert(pw,@"Pass a null object.");
    NSAssert(email,@"Pass a null object.");
    NSAssert(phone,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:name forKey:@"username"];
	[dict setObject:pw forKey:@"password"];
	[dict setObject:email forKey:@"email"];
	[dict setObject:phone forKey:@"phone"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_USER_SIGNUP
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(signupFinish:)];
    [http setDidFailSelector:@selector(signupFail:)];
    [http startAsynchronous];
    
    return http;

}

- (void)signupFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    [self APIRequestFinish:request returnData:info];
}

-(void)signupFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark get fb token to login

- (GuluHttpRequest *)getFaceBookLogingToken :(id)target 
{
    NSAssert(target,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_USER_FACEBOOK_GET_TOKEN
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(getFaceBookLogingTokenFinish:)];
    [http setDidFailSelector:@selector(getFaceBookLogingTokenFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)getFaceBookLogingTokenFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    if([info isKindOfClass:[NSDictionary class]]){
        NSString *fb_token=[info objectForKey: @"fb_token"];
        if(fb_token){
            info=fb_token;}
        else{
            NSLog(@"GET FB TOKEN ERROR %@",info);
            info=nil;}
    }
    else{
        NSLog(@"GET FB TOKEN ERROR %@",info);
        info=nil;
    }
    [self APIRequestFinish:request returnData:info];
}

-(void)getFaceBookLogingTokenFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark get user object by fb token

- (GuluHttpRequest *)getUserObjectByFBToken :(id)target 
                               facebookToken:(NSString *)fbtoken 
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(fbtoken,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:fbtoken forKey:@"fb_token"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_USER_FACEBOOK_GET_USER
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(getUserObjectByFBTokenFinish:)];
    [http setDidFailSelector:@selector(getUserObjectByFBTokenFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)getUserObjectByFBTokenFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSDictionary *data=[info objectForKey:@"user"];
    NSString *session_key=[info objectForKey:@"session_key"];
    
    self.sessionKey=session_key;
    
    GuluUserModel *model=[[[GuluUserModel alloc] init] autorelease];
    [model switchDataIntoModel:data];
    
    [self APIRequestFinish:request returnData:model];
}

-(void)getUserObjectByFBTokenFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


@end
