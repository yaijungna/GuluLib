//
//  GuluAPIAccessManager+Comment.h
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluAPIAccessManager.h"

#import "API_URL_COMMENTS.h"

#import "GuluCommentModel.h"

@interface GuluAPIAccessManager(Comment)

- (GuluHttpRequest *)commentsList :(id)target            
                             target_id:(NSString *)target_id;

- (GuluHttpRequest *)commentPostToTaget:(id)target  
                              target_id:(NSString *)target_id 
                            target_type:(NSString *)target_type
                                   text:(NSString *)text;

@end
