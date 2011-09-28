//
//  PostManager.h
//  GULUAPP
//
//  Created by alan on 11/9/5.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "postModel.h"


@protocol PostManagerDelegate

- (void)postManagerSubmitAtIndex:(NSInteger)index;

- (void)postManagerRemoveObjectAtIndex:(NSInteger)index;
- (void)postManagerAddObjectAtIndex:(NSInteger)index;

- (void)postManagerSuccessed:(NSInteger)index info:(id)info;
- (void)postManagerFailed:(NSInteger)index error:(NSError *)error;

@end


@interface PostManager : NSObject<PostDelegate>
{
    NSMutableArray *dataQueueArray;
    NSMutableArray *postQueueArray;
    
    id<PostManagerDelegate>delegate;
}


@property (nonatomic,retain) NSMutableArray *dataQueueArray;
@property (nonatomic,retain) NSMutableArray *postQueueArray;
@property (nonatomic,assign) id<PostManagerDelegate>delegate;

+ (id)sharedManager;

-(void)addToQueue:(postModel *)post;
-(void)removeObjectFromeQueue:(postModel *)post;

-(void)postRveview:(NSInteger)index;

@end
