//
//  GuluContactModel.h
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"

#import "GuluTypeDefine.h"

@interface GuluContactModel : GuluModel
{
    NSString *first_name;
    NSString *last_name;
    NSString *email;
    NSString *profile_pic;
    NSString *gulu_user_id;
    BOOL is_favorited;
}

@property (nonatomic,retain) NSString *first_name;
@property (nonatomic,retain) NSString *last_name;
@property (nonatomic,retain) NSString *email;
@property (nonatomic,retain) NSString *profile_pic;
@property (nonatomic,retain) NSString *gulu_user_id;
@property (nonatomic,assign) BOOL is_favorited;

@end

