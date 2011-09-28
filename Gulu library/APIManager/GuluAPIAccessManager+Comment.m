//
//  GuluAPIAccessManager+Comment.m
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluAPIAccessManager+Comment.h"

@implementation GuluAPIAccessManager(Comment)


#pragma mark -
#pragma mark comment list


- (GuluHttpRequest *)commentsList :(id)target            
                         target_id:(NSString *)target_id
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(target_id,@"Pass a null object.");

    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:target_id forKey:@"target_id"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_COMMENT_LIST
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(commentsListFinish:)];
    [http setDidFailSelector:@selector(commentsListFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)commentsListFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
    
    for(NSDictionary *dict in info)
    {
        GuluCommentModel *model=[[[GuluCommentModel alloc] init] autorelease];
        [model switchDataIntoModel:dict];
        [array addObject:model];
    }
    
    [self APIRequestFinish:request returnData:array];
}

-(void)commentsListFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark comment post


- (GuluHttpRequest *)commentPostToTaget:(id)target  
                              target_id:(NSString *)target_id 
                            target_type:(NSString *)target_type
                                   text:(NSString *)text
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(target_id,@"Pass a null object.");
    NSAssert(target_type,@"Pass a null object.");
    NSAssert(text,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:target_id forKey:@"target_id"];
	[dict setObject:target_type forKey:@"target_type"];
	[dict setObject:text forKey:@"text"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_COMMENT_POST
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(commentPostToTagetFinish:)];
    [http setDidFailSelector:@selector(commentPostToTagetFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)commentPostToTagetFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    GuluCommentModel *model=[[[GuluCommentModel alloc] init] autorelease];
    [model switchDataIntoModel:info];
    
    [self APIRequestFinish:request returnData:model];
}

-(void)commentPostToTagetFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}




@end
