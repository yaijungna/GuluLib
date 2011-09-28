//
//  GuluEventModel.h
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"

#import "GuluUserModel.h"
#import "GuluPlaceModel.h"
#import "GuluEventModel.h"
#import "GuluGuestModel.h"

#import "GuluTypeDefine.h"


@interface GuluEventModel : GuluModel
{
    GuluUserModel *inviter;
    NSString *title;
    GuluPlaceModel *restaurant;
    float start_time;
    GuluEventStatus status;
    NSArray *guest_list;  //GuluGuestModel Array
}

@property(nonatomic,retain) GuluUserModel *inviter;
@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) GuluPlaceModel *restaurant;
@property(nonatomic,assign) float start_time;
@property(nonatomic,assign) GuluEventStatus status;
@property(nonatomic,retain) NSArray *guest_list;

-(NSString *) contactListString;

@end



