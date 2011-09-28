//
//  GuluAPIAccessManager+PlaceDish.m
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluAPIAccessManager+PlaceDish.h"

@implementation GuluAPIAccessManager(PlaceDish)


#pragma mark -
#pragma mark best know for list

- (GuluHttpRequest *)bestKnownForTags :(id)target 
                              ridORdid:(NSString *)targetid
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(targetid,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:targetid forKey:@"serial"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_POST_BEST_KNOWN_FOR_TAG
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(bestKnownForTagsFinish:)];
    [http setDidFailSelector:@selector(bestKnownForTagsFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)bestKnownForTagsFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSArray *list=[info objectForKey:@"tags"];
    
    [self APIRequestFinish:request returnData:list];
}

-(void)bestKnownForTagsFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark dishes in place

- (GuluHttpRequest *)dishesOfPlace :(id)target 
                            placeID:(NSString *)placeID
{ 
    NSAssert(target,@"Pass a null object.");
    NSAssert(placeID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:placeID forKey:@"rid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_RESTAURANT_DISH
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(dishesOfPlaceFinish:)];
    [http setDidFailSelector:@selector(dishesOfPlaceFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)dishesOfPlaceFinish:(GuluHttpRequest *)request
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

-(void)dishesOfPlaceFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


#pragma mark -
#pragma mark reviews in place

- (GuluHttpRequest *)reviewsOfPlace :(id)target 
                             placeID:(NSString *)placeID
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(placeID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:placeID forKey:@"rid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_RESTAURANT_REVIEW
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(reviewsOfPlaceFinish:)];
    [http setDidFailSelector:@selector(reviewsOfPlaceFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)reviewsOfPlaceFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
    
    for(NSDictionary *dict in info)
    {
        GuluReviewModel *model=[[[GuluReviewModel alloc] init] autorelease];
        [model switchDataIntoModel:dict];
        [array addObject:model];
    }
    
    [self APIRequestFinish:request returnData:array];
}

-(void)reviewsOfPlaceFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


#pragma mark -
#pragma mark photos of place

- (GuluHttpRequest *)photosOfPlace :(id)target 
                            placeID:(NSString *)placeID
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(placeID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:placeID forKey:@"rid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_RESTAURANT_PHOTO
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(photosOfPlaceFinish:)];
    [http setDidFailSelector:@selector(photosOfPlaceFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)photosOfPlaceFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
    
    for(NSDictionary *dict in info)
    {
        GuluPhotoModel *model=[[[GuluPhotoModel alloc] init] autorelease];
        [model switchDataIntoModel:dict];
        [array addObject:model];
    }
    
    [self APIRequestFinish:request returnData:array];
}

-(void)photosOfPlaceFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


#pragma mark -
#pragma mark photos of dish

- (GuluHttpRequest *)photosOfDish :(id)target 
                            dishID:(NSString *)dishID
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(dishID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:dishID forKey:@"did"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_DISH_PHOTO
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(photosOfDishFinish:)];
    [http setDidFailSelector:@selector(photosOfDishFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)photosOfDishFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
   
    NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
    
    for(NSDictionary *dict in info)
    {
        GuluPhotoModel *model=[[[GuluPhotoModel alloc] init] autorelease];
        [model switchDataIntoModel:dict];
        [array addObject:model];
    }
    
    [self APIRequestFinish:request returnData:array];
}

-(void)pphotosOfDishFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}




@end
