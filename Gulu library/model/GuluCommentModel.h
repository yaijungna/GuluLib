//
//  GuluCommentModel.h
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"
#import "GuluUserModel.h"
#import "GuluTypeDefine.h"

@interface GuluCommentModel : GuluModel
{
    NSString *comment;
    NSString *post_id;
    float submit_date;
    float time_ago;
    GuluUserModel *user;
}

@property (nonatomic,retain) NSString *comment;
@property (nonatomic,retain) NSString *post_id;
@property (nonatomic,assign) float submit_date;
@property (nonatomic,assign) float time_ago;
@property (nonatomic,retain) GuluUserModel *user;

@end
