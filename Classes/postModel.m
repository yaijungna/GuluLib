//
//  postModel.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/9.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "postModel.h"
#import "GULUAPPAppDelegate.h"
#import "API_URL_POST.h"
#import "API_URL_MYGULU.h"
#import "debugDefined.h"

@implementation postModel

@synthesize todoid;
@synthesize taskid, groupid;
@synthesize isThumb , isGuluapproved ;
@synthesize photo,restaurantDict,dishDict,photoDict,review;
@synthesize step;
@synthesize submitReview,deleteTodo,submitPhoto,createPlace;
@synthesize isSubmitStart;
@synthesize bestKnownFor;
@synthesize delegate;
@synthesize dataModel;


DECLARE_PROPERTIES(
                   DECLARE_PROPERTY(@"submitReview", @"@\"GuluGeneralHTTPClient\""),
                   DECLARE_PROPERTY(@"deleteTodo", @"@\"GuluGeneralHTTPClient\""),
                   DECLARE_PROPERTY(@"submitPhoto", @"@\"GuluPostImage\""),
                   DECLARE_PROPERTY(@"createPlace", @"@\"GuluCreateNewPlace\"")
                   )


#pragma mark -

- (id)init {
	
	if(self=[super init])
	{
        self.taskid=@"";
        self.groupid=@"";
        self.todoid=@"";
        
        self.dataModel=[[[PostDataModel alloc] init] autorelease];
        
	}
	return self;
}

- (void) dealloc
{
    
	[photo release];
	[restaurantDict release];
	[dishDict release];
	[photoDict release];
	[review release];
	[bestKnownFor release];
    
	[todoid release];
    [taskid release];
    [groupid release];
    
    //=================
    
    [submitReview release];
    [deleteTodo release];
    [submitPhoto release];
    [createPlace release];
    
     delegate=nil;
    
    [dataModel release];
    
	[super dealloc];
}


- (void)save
{
    dataModel.photo=photo;
    dataModel.restaurantDict=restaurantDict;
    dataModel.dishDict=dishDict;
    dataModel.photoDict=photoDict;
    dataModel.review=review;
    dataModel.bestKnownFor=bestKnownFor;
    dataModel.todoid=todoid;
    dataModel.taskid=taskid;
    dataModel.groupid=groupid;
    dataModel.isThumb=isThumb;
    dataModel.isGuluapproved=isGuluapproved;
    
    [dataModel save];
}

- (void)removeFromBD
{
    [dataModel deleteObject];
}


- (void)importDataModel:(PostDataModel *)data
{   
    self.dataModel=data;
    self.photo=data.photo;
    self.restaurantDict=data.restaurantDict;
    self.dishDict=data.dishDict;
    self.photoDict=data.photoDict;
    self.review=data.review;
    self.bestKnownFor=data.bestKnownFor;
    self.todoid=data.todoid;
    self.taskid=data.taskid;
    self.groupid=data.groupid;
    self.isThumb=data.isThumb;
    self.isGuluapproved=data.isGuluapproved;
}

#pragma mark -
#pragma mark upload Function Methods

- (void)submitReviewStart
{
    step=submitReviewStep;
	self.submitReview=[[[GuluGeneralHTTPClient alloc] init] autorelease];
    submitReview.delegate=self;
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    
    [dict setObject:[dishDict objectForKey:@"id"] forKey:@"did"];
    [dict setObject:[dishDict objectForKey:@"name"] forKey:@"dish_name"];
	[dict setObject:[restaurantDict objectForKey:@"id"] forKey:@"rid"];
	[dict setObject:review  forKey:@"review_content"];
	[dict setObject:[photoDict objectForKey:@"id"] forKey:@"photo_id"];
	[dict setObject:[NSString stringWithFormat:@"%d",isThumb] forKey:@"thumb"];
	[dict setObject:[NSString stringWithFormat:@"%d",isGuluapproved] forKey:@"gulu_approve"];
	[dict setObject:bestKnownFor forKey:@"best_known"];
    [dict setObject:groupid forKey:@"group_id"];
	[dict setObject:taskid forKey:@"tid"];
    
    [submitReview createRequest:URL_POST_CREATE_REVIEW info:dict];
    [submitReview startRequest];
    
}

- (void)deleteTodoStart
{
	self.deleteTodo=[[[GuluGeneralHTTPClient alloc] init] autorelease];
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];    
    [dict setObject:todoid forKey:@"todo_id"];
    [submitReview createRequest:URL_TODO_DELETE info:dict];
    [submitReview startRequest];
}

- (void)createPlaceStart
{
    step=createPlaceStep;
    self.createPlace=[[[GuluCreateNewPlace alloc] initWithInfo:[restaurantDict objectForKey:@"name"] 
                                                   phonenumber:[restaurantDict objectForKey:@"phone"] 
                                                       address:[restaurantDict objectForKey:@"address"]
                                                          city:[restaurantDict objectForKey:@"city"]
                                                           lng:[restaurantDict objectForKey:@"longitude"] 
                                                           lan:[restaurantDict objectForKey:@"latitude"] 
                                                           pid:[photoDict objectForKey:@"id"]]autorelease];
    createPlace.delegate=self;
    [createPlace startCreatingPlace];
}


- (void)submitPhotoStart
{
    step=postImageStep;
    self.submitPhoto=[[[GuluPostImage alloc] initWithPhoto:photo] autorelease];
    submitPhoto.delegate=self;
    [submitPhoto startSubmitPhoto];
}

#pragma mark -

- (void)GuluGeneralHTTPClientSuccessed:(id)sender info:(id)info;
{
    if(sender==submitReview)
    {
        if(![todoid isEqualToString:@""] && todoid!=nil)
        {
            [self deleteTodoStart];
        }
        
        [delegate postSuccessed:self info:info];
    }
    if(sender==createPlace)
    {
        if([info count]==0) 
        {
            NSError *error=nil;
            [delegate postFailed:self error:error];
        }
        else
        {
            self.restaurantDict=info;
            [self submitReviewStart];
        }
    }
    if(sender==submitPhoto)
    {
        self.photoDict=info;
        
        if(isSubmitStart)
        {
            if([info count]==0) 
            {
                NSError *error;
                [delegate postFailed:self error:error];
                return;
            }
            if([restaurantDict objectForKey:@"id"]==nil)
            {
                [self createPlaceStart];
            }
            else
            {
                [self submitReviewStart];
            }    
        }
    }
}

- (void)GuluGeneralHTTPClientFailed:(id)sender error:(NSError *)error
{
    
    ACLog(@"Failed At Step %d", step);
    
    if(sender==submitReview)
    {
        isSubmitStart=NO;
        [delegate postFailed:self error:error];    
    }
    if(sender==createPlace)
    {
        ACLog(@"Failed At Step %d", step);
        
        isSubmitStart=NO;
        [delegate postFailed:self error:error]; 
    }
    if(sender==submitPhoto)
    {
        ACLog(@"Failed At Step %d", step);
        
        if(isSubmitStart)
        {
            isSubmitStart=NO;
            [delegate postFailed:self error:error];   
        }
    }
}

#pragma mark -
#pragma mark submit

- (void)submit
{
    isSubmitStart=YES;
    
    if(!submitPhoto.isRequestRuinning)  //photo is not uploading now.
    {
        if( [photoDict objectForKey:@"id"])  //photo uploading is finished
        {
            if(![restaurantDict objectForKey:@"id"])
            {
                [self createPlaceStart];
            }
            else
            {
                [self submitReviewStart];
            }
        }
        else 
        {
            [self submitPhotoStart];        
        }
    }
    else //photo is uploading now, so wait.
    {
        
    }
}


@end




