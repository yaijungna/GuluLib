//
//  UIViewControllerAddtion_Connection_Post.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "UIViewControllerAddtion_Connection_Post.h"


@implementation UIViewController(MyAdditions_post)


-(void)uploadPhotoConnection:(ACNetworkManager *)net  
				   imageData:(NSData *)imagedata;

{
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:imagedata forKey:@"uploadedfile"];
	
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"uploadPhoto" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_POST_UPLOAD_PHOTO
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	
}

-(void)bestKnownForConnection:(ACNetworkManager *)net  
					   serial:(NSString *)serial
{
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:serial forKey:@"serial"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"bestknownfor" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_POST_BEST_KNOWN_FOR_TAG
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
}


- (void)creatNewRestaurant :(ACNetworkManager *)net 
                 restaurant:(NSMutableDictionary *)restaurantDict 
                   photo_id:(NSString *)pid
{	
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:[restaurantDict objectForKey:@"name"] forKey:@"name"];
	[dict setObject:[restaurantDict objectForKey:@"latitude"] forKey:@"latitude"];
	[dict setObject:[restaurantDict objectForKey:@"longitude"] forKey:@"longitude"];
	[dict setObject:[restaurantDict objectForKey:@"address"] forKey:@"address"];
	[dict setObject:[restaurantDict objectForKey:@"phone"] forKey:@"phone"];
	[dict setObject:[restaurantDict objectForKey:@"city"] forKey:@"city"];
	[dict setObject:pid forKey:@"photo_id"];

	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"createrestaurant" forKey:@"id"];
    
   	
	ASIFormDataRequest *request= [net createNewRequest:URL_POST_CREATE_RESTAURANT
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
}

- (void)submitReview:(ACNetworkManager *)net 
           postModel:(postModel *)post
             isThumb:(NSString *)isThumb
      isGuluapproved:(NSString *)isGuluapproved
{	
    ACLog(@"%@",post);
    ACLog(@"%@",post.restaurantDict);
    ACLog(@"%@",post.dishDict);
    ACLog(@"%@",post.review);
    ACLog(@"%@",post.photoDict);
    
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];

	[dict setObject:[post.restaurantDict objectForKey:@"id"] forKey:@"rid"];
	[dict setObject:[post.dishDict objectForKey:@"id"] forKey:@"did"];
	[dict setObject:[post.dishDict objectForKey:@"name"] forKey:@"dish_name"];
	[dict setObject:post.review  forKey:@"review_content"];
	[dict setObject:[post.photoDict objectForKey:@"id"] forKey:@"photo_id"];
	[dict setObject:isThumb forKey:@"thumb"];
	[dict setObject:isGuluapproved forKey:@"gulu_approve"];
	[dict setObject:post.bestKnownFor forKey:@"best_known"];
    
    [dict setObject:post.groupid forKey:@"group_id"];
	[dict setObject:post.taskid forKey:@"tid"];
    
    NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"createreview" forKey:@"id"];

	ASIFormDataRequest *request= [net createNewRequest:URL_POST_CREATE_REVIEW
                                        keyValueDictionary:dict 
                                         addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];	
	[net addRequestToRequestsQueue:request];
}





@end
