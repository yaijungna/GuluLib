//
//  GuluAPIAccessManager+Post.m
//  GULUAPP
//
//  Created by alan on 11/9/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluAPIAccessManager+Post.h"

@implementation GuluAPIAccessManager(Post)



#pragma mark -
#pragma mark Post image

- (GuluHttpRequest *)postImage :(id)target 
             photo:(UIImage *)photo
{

    NSAssert(target,@"Pass a null object.");
    NSAssert(photo,@"Pass a null object.");
    
    NSData *data= UIImageJPEGRepresentation(photo, 0.5);
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:data forKey:@"uploadedfile"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_POST_UPLOAD_PHOTO
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(postImageFinish:)];
    [http setDidFailSelector:@selector(postImageFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)postImageFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    GuluPhotoModel *model=[[[GuluPhotoModel alloc] init] autorelease];
    [model switchDataIntoModel:info];
    
    [self APIRequestFinish:request returnData:model];
}

-(void)postImageFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark create place

- (GuluHttpRequest *)createNewPlace :(id)target 
            placeObject:(GuluPlaceModel *)placeObject;
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(placeObject,@"Pass a null object.");
    
    NSAssert(placeObject.name,@"Pass a null object.");
    NSAssert(placeObject.address,@"Pass a null object.");
    NSAssert(placeObject.city,@"Pass a null object.");
    NSAssert(placeObject.ID,@"Pass a null object."); 
    NSAssert(placeObject.phone,@"Pass a null object.");
    
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    
    [dict setObject:placeObject.name forKey:@"name"];
    [dict setObject:[NSString stringWithFormat:@"%f",placeObject.latitude] forKey:@"latitude"];
    [dict setObject:[NSString stringWithFormat:@"%f",placeObject.longitude] forKey:@"longitude"];
    [dict setObject:placeObject.address forKey:@"address"];
    [dict setObject:placeObject.city forKey:@"city"];
    [dict setObject:placeObject.phone forKey:@"phone"];
    [dict setObject:placeObject.ID forKey:@"photo_id"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_POST_CREATE_RESTAURANT
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(createNewPlaceFinish:)];
    [http setDidFailSelector:@selector(createNewPlaceFail:)];
    [http startAsynchronous];
    
    return http;
}


- (void)createNewPlaceFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    GuluPlaceModel *obj=[[[GuluPlaceModel alloc] init] autorelease];
    [obj switchDataIntoModel:info];

    [self APIRequestFinish:request returnData:obj];
    
}

-(void)createNewPlaceFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark create place

- (GuluHttpRequest *)createNewReview :(id)target 
            reviewObject:(GuluReviewModel*)reviewObject
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(reviewObject,@"Pass a null object.");
    
    NSAssert(reviewObject.restaurant.ID,@"Pass a null object.");
    NSAssert(reviewObject.content,@"Pass a null object.");
    NSAssert(reviewObject.photo.ID,@"Pass a null object.");
    NSAssert(reviewObject.thumb,@"Pass a null object.");
    
    if(reviewObject.dish.ID==nil){
        reviewObject.dish.ID=@"";}
    if(reviewObject.dish.name==nil){
        reviewObject.dish.name=@"";}
    
    NSString *bestKnownFor;
    if(reviewObject.dish.best_known){
        bestKnownFor=reviewObject.dish.best_known;}
    else  if(reviewObject.restaurant.best_known){
        bestKnownFor=reviewObject.restaurant.best_known;}
    else{
        bestKnownFor=@"";}
    
    if(reviewObject.task_id==nil){
        reviewObject.task_id=@"";}
    if(reviewObject.group_id==nil){
        reviewObject.group_id=@"";}
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:reviewObject.dish.ID forKey:@"did"];
    [dict setObject:reviewObject.dish.name forKey:@"dish_name"];
    [dict setObject:reviewObject.restaurant.ID forKey:@"rid"];
    [dict setObject:reviewObject.content  forKey:@"review_content"];
    [dict setObject:reviewObject.photo.ID forKey:@"photo_id"];
    [dict setObject:[NSString stringWithFormat:@"%d",reviewObject.thumb] forKey:@"thumb"];
    [dict setObject:[NSString stringWithFormat:@"%d",reviewObject.restaurant.is_gulu_approved] forKey:@"gulu_approve"];
    
    [dict setObject:bestKnownFor forKey:@"best_known"];
    [dict setObject:reviewObject.group_id forKey:@"group_id"];
    [dict setObject:reviewObject.task_id forKey:@"tid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_POST_CREATE_REVIEW
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(createNewReviewFinish:)];
    [http setDidFailSelector:@selector(createNewReviewFail:)];
    [http startAsynchronous];
    
    return http;
}


- (void)createNewReviewFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSLog(@"%@",info);
    
    
 //   [self APIRequestFinish:request returnData:obj];
    
}

-(void)createNewReviewFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}




@end
