//
//  GuluAPIAccessManager+Invite.m
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluAPIAccessManager+Invite.h"

@implementation GuluAPIAccessManager(Invite)

#pragma mark -
#pragma mark create a event

- (GuluHttpRequest *)createEvent :(id)target 
                            event:(GuluEventModel *)event
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(event,@"Pass a null object.");
    NSAssert(event.restaurant.ID,@"Pass a null object.");
    NSAssert(event.title,@"Pass a null object.");
    NSAssert(event.start_time,@"Pass a null object.");
    NSAssert(event.guest_list,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:event.restaurant.ID forKey:@"rid"];
	[dict setObject:event.title forKey:@"title"];
	[dict setObject:[NSString stringWithFormat:@"%f",event.start_time] forKey:@"date"];
	[dict setObject:[event contactListString] forKey:@"contact_list"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_INVITE_CREATE_EVENT
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(createEventFinish:)];
    [http setDidFailSelector:@selector(createEventFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)createEventFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    [self APIRequestFinish:request returnData:info];
    
}

-(void)createEventFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


#pragma mark -
#pragma mark attend a event


- (GuluHttpRequest *)attendEvent :(id)target 
                            event:(GuluEventModel *)event
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(event,@"Pass a null object.");
    NSAssert(event.ID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:event.ID forKey:@"eid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_INVITE_ATTENDE_EVENT
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(attendEventFinish:)];
    [http setDidFailSelector:@selector(attendEventFail:)];
    [http startAsynchronous];
    
    return http;
 
}

- (void)attendEventFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    [self APIRequestFinish:request returnData:info];
    
}

-(void)attendEventFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


#pragma mark -
#pragma mark refuse to attend a event

- (GuluHttpRequest *)refuseEvent :(id)target 
                            event:(GuluEventModel *)event
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(event,@"Pass a null object.");
    NSAssert(event.ID,@"Pass a null object.");

    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:event.ID forKey:@"eid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_INVITE_REFUSE_EVENT
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(refuseEventFinish:)];
    [http setDidFailSelector:@selector(refuseEventFail:)];
    [http startAsynchronous];
    
    return http;
    
}

- (void)refuseEventFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    [self APIRequestFinish:request returnData:info];
    
}

-(void)refuseEventFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark guest list of event

- (GuluHttpRequest *)guestListOfEvent :(id)target 
                                 event:(GuluEventModel *)event
{
    
    NSAssert(target,@"Pass a null object.");
    NSAssert(event,@"Pass a null object.");
    NSAssert(event.ID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:event.ID forKey:@"eid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_INVITE_GUESTLIST
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(guestListOfEventFinish:)];
    [http setDidFailSelector:@selector(guestListOfEventFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)guestListOfEventFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    GuluGuestModel *model=[[[GuluGuestModel alloc] init] autorelease];
    [model switchDataIntoModel:info];
    
    [self APIRequestFinish:request returnData:model];
    
}

-(void)guestListOfEventFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


#pragma mark -
#pragma mark edit a event

- (GuluHttpRequest *)editEvent :(id)target 
                          event:(GuluEventModel *)event
{
    
    NSAssert(target,@"Pass a null object.");
    NSAssert(event,@"Pass a null object.");
    NSAssert(event.ID,@"Pass a null object.");
    NSAssert(event.restaurant.ID,@"Pass a null object.");
    NSAssert(event.title,@"Pass a null object.");
    NSAssert(event.start_time,@"Pass a null object.");
    NSAssert(event.guest_list,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:event.ID forKey:@"eid"];
	[dict setObject:event.restaurant.ID forKey:@"rid"];
	[dict setObject:event.title forKey:@"title"];
	[dict setObject:[NSString stringWithFormat:@"%f",event.start_time] forKey:@"date"];
	[dict setObject:[event contactListString] forKey:@"contact_list"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_INVITE_EDIT
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(editEventFinish:)];
    [http setDidFailSelector:@selector(editEventFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)editEventFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    [self APIRequestFinish:request returnData:info];
    
}

-(void)editEventFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}



@end
