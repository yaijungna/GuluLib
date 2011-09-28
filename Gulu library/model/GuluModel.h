//
//  GuluModel.h
//  GULUAPP
//
//  Created by alan on 11/9/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluBasicModel.h"
#import "GuluTypeDefine.h"


@interface GuluModel : GuluBasicModel
{
    NSString *ID;
}

@property(nonatomic,retain) NSString *ID;

+(id)getObjectByObjectType :(GuluTargetType)object_type  
                            data:(NSDictionary *)dataDictionary;

+(id)getObjectByfavoriteType :(GuluFavoriteType)favorite_type  
                         data:(NSDictionary *)dataDictionary;

+(id)getObjectByTodoType :(GuluToDoObjectType)todo_type  
                     data:(NSDictionary *)dataDictionary;

+(id)getObjectByChatType :(GuluChatObjectType)chat_type  
                     data:(NSDictionary *)dataDictionary;

+ (NSString *)getGuluResultErrorMessage:(NSDictionary *)result;

+ (GuluFriendStatus)getFriendStatus:(NSDictionary *)result;



@end

