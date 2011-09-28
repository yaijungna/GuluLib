//
//  TempModel.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "postModel.h"
#import "inviteModel.h"
#import "missionModel.h"
#import "taskModel.h"

@interface TempModel : NSObject {

	postModel *postObj;
	inviteModel *inviteObj;
    missionModel *missionObj;
    taskModel *taskObj;
    

}

+ (id)sharedManager;


@property (nonatomic,retain) postModel *postObj;
@property (nonatomic,retain) inviteModel *inviteObj;
@property (nonatomic,retain) missionModel *missionObj;
@property (nonatomic,retain) taskModel *taskObj;


@end
