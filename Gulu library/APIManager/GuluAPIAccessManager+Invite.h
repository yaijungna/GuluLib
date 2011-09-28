//
//  GuluAPIAccessManager+Invite.h
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluAPIAccessManager.h"

#import "GuluEventModel.h"
#import "GuluGuestModel.h"

#import "API_URL_INVITE.h"

@interface GuluAPIAccessManager(Invite)


- (GuluHttpRequest *)createEvent :(id)target 
                            event:(GuluEventModel *)event;

- (GuluHttpRequest *)attendEvent :(id)target 
                            event:(GuluEventModel *)event;

- (GuluHttpRequest *)refuseEvent :(id)target 
                            event:(GuluEventModel *)event;

- (GuluHttpRequest *)guestListOfEvent :(id)target 
                            event:(GuluEventModel *)event;
  
- (GuluHttpRequest *)editEvent :(id)target 
                            event:(GuluEventModel *)event;



@end




