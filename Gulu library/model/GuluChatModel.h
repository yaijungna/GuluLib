//
//  GuluChatModel.h
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"
#import "GuluTypeDefine.h"

#import "GuluEventModel.h"

@interface GuluChatModel : GuluModel

{
    NSString *chat_uuid;
    NSDictionary *object;
    NSString *participant_uuid;
    GuluChatObjectType type;
    
    id objectModel;
}

@property (nonatomic,retain) NSString *chat_uuid;
@property (nonatomic,retain) NSDictionary *object;
@property (nonatomic,retain) NSString *participant_uuid;
@property (nonatomic,assign) GuluChatObjectType type;

@property (nonatomic,retain) id objectModel;


@end

