//
//  GuluAPIAccessManager+Search.m
//  GULUAPP
//
//  Created by alan on 11/9/7.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluAPIAccessManager+Search.h"

@implementation GuluAPIAccessManager(Search)



#pragma mark -
#pragma mark search place


- (GuluHttpRequest *)searchPlace :(id)target  
          searchTerm:(NSString *)searchTerm   
                 lat:(float)lat 
                 lng:(float)lng
{
    
    NSAssert(target,@"Pass a null object.");
    NSAssert(searchTerm,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:searchTerm forKey:@"term"];
    [dict setObject:[NSString stringWithFormat:@"%f",lat] forKey:@"lat"];
    [dict setObject:[NSString stringWithFormat:@"%f",lng] forKey:@"lng"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_SEARCH_RESTAURANT
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(searchPlaceFinish:)];
    [http setDidFailSelector:@selector(searchPlaceFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)searchPlaceFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
    
    for(NSDictionary *dict in info)
    {
        GuluPlaceModel *model=[[[GuluPlaceModel alloc] init] autorelease];
        [model switchDataIntoModel:dict];
        [array addObject:model];
    }
    
    [self APIRequestFinish:request returnData:array];
}

-(void)searchPlaceFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}



#pragma mark -
#pragma marksearch dish

- (GuluHttpRequest *)searchDish :(id)target 
         searchTerm:(NSString *)searchTerm   
                lat:(float)lat 
                lng:(float)lng
{
    
    NSAssert(target,@"Pass a null object.");
    NSAssert(searchTerm,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:searchTerm forKey:@"term"];
    [dict setObject:[NSString stringWithFormat:@"%f",lat] forKey:@"lat"];
    [dict setObject:[NSString stringWithFormat:@"%f",lng] forKey:@"lng"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_SEARCH_DISH
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(searchDishFinish:)];
    [http setDidFailSelector:@selector(searchDishFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)searchDishFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];

    
    NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
    
    for(NSDictionary *dict in info)
    {
        GuluDishModel *model=[[[GuluDishModel alloc] init] autorelease];
        [model switchDataIntoModel:dict];
        [array addObject:model];
    }
    
    [self APIRequestFinish:request returnData:array];
}

-(void)searchDishFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma marksearch mission

- (GuluHttpRequest *)searchMission :(id)target 
                         searchTerm:(NSString *)searchTerm  
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(searchTerm,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:searchTerm forKey:@"term"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_SEARCH_MISSION
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(searchMissionFinish:)];
    [http setDidFailSelector:@selector(searchMissionFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)searchMissionFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
    
    for(NSDictionary *dict in info)
    {
        GuluMissionModel *model=[[[GuluMissionModel alloc] init] autorelease];
        [model switchDataIntoModel:dict];
        [array addObject:model];
    }
    
    [self APIRequestFinish:request returnData:array];
}

-(void)searchMissionFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}






@end