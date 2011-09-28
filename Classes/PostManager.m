//
//  PostManager.m
//  GULUAPP
//
//  Created by alan on 11/9/5.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "PostManager.h"

@implementation PostManager

@synthesize  dataQueueArray;
@synthesize  postQueueArray;
@synthesize  delegate;

static id sharedMyManager_queue = nil;


+ (id)sharedManager {
	@synchronized(self){
        if(sharedMyManager_queue == nil)
            sharedMyManager_queue = [[super alloc] init];
    }
    return sharedMyManager_queue;
}


- (id)init
{
    self = [super init];
    if (self) {
        
        self.dataQueueArray=[NSMutableArray arrayWithArray:[PostDataModel allObjects]];
        self.postQueueArray=[[[NSMutableArray alloc] init] autorelease];
        
        for(id data in dataQueueArray)
        {
            postModel *post=[[[postModel alloc] init] autorelease];
            post.delegate=self;
            [post importDataModel:data];
            [postQueueArray addObject:post];            
        }
    }
    
    return self;
}


- (void) dealloc
{
    [dataQueueArray release];
    [postQueueArray release];
	
    [super dealloc];
}

#pragma mark -
#pragma mark post Methods

-(void)postRveview:(NSInteger)index
{
    postModel *post=[postQueueArray objectAtIndex:index];
   
    [delegate postManagerSubmitAtIndex:index];
    
    [post submit];
 }

-(void)addToQueue:(postModel *)post
{
    post.delegate=self;
    [post save];
    [dataQueueArray addObject:post.dataModel];
    [postQueueArray addObject:post];
    
    [delegate postManagerAddObjectAtIndex:[postQueueArray count]-1];
}

-(void)removeObjectFromeQueue:(postModel *)post
{
    
    NSInteger index=0;
    for(int i=0;i<[postQueueArray count] ;i++)
    {
        postModel *postInQueue=[postQueueArray objectAtIndex:i];
        
        if(post==postInQueue)
        {
            index=i;
            break;
        }
    }
    
    post.delegate=nil;
    [dataQueueArray removeObject:post.dataModel];
    [post removeFromBD];
    [postQueueArray removeObject:post];
    
    [delegate postManagerRemoveObjectAtIndex:index];
}


#pragma mark -
#pragma mark delegate Methods

- (void)postSuccessed:(id)sender info:(id)info
{
    if([info count]!=0)
    {
        ACLog(@"PostSuccessed");
        
        for(int i=0;i<[postQueueArray count] ;i++)
        {
            postModel *post=[postQueueArray objectAtIndex:i];
            
            if(post==sender)
            {
                [delegate postManagerSuccessed:i info:info];
                [self removeObjectFromeQueue:post];
                return;
            }
        }
    }
    else
    {
        ACLog(@"PostFailed");
        NSError *error;
        [self postFailed:sender error:error];
    }
}

- (void)postFailed:(id)sender error:(NSError *)error
{
    NSInteger index=0;
    for(int i=0;i<[postQueueArray count] ;i++)
    {
        postModel *post=[postQueueArray objectAtIndex:i];
        
        if(post==sender)
        {
            index=i;
            break;
        }
    }
    
    [delegate postManagerFailed:index error:error];
}

@end
