//
//  GuluAPIAccessManager+User.h
//  GULUAPP
//
//  Created by alan on 11/9/9.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluAPIAccessManager.h"

#import "API_URL_GENERAL.h"
#import "API_URL_USER.h"
#import "API_URL_MYGULU.h"
#import "API_URL_CHAT.h"
#import "API_URL_FAVORITE.h"
#import "API_URL_INVITE.h"

#import "GuluReviewModel.h"
#import "GuluUserModel.h"
#import "GuluChatModel.h"
#import "GuluTodoItemModel.h"
#import "GuluAroundMeModel.h"
#import "GuluWallFeedModel.h"
#import "GuluContactModel.h"

@interface GuluAPIAccessManager(User)

#pragma mark -
#pragma mark USER

- (GuluHttpRequest *)getUserUUID :(id)target            
                          user:(GuluUserModel *)user;

- (GuluHttpRequest *)getUserVoiceToken:(id)target ;

- (GuluHttpRequest *)userInformation :(id)target            
                              user:(GuluUserModel *)user;

- (GuluHttpRequest *)updateUserInformation :(id)target            
                                       user:(GuluUserModel *)user
                                    picture:(UIImage *)picture;


#pragma mark -
#pragma mark TODO

- (GuluHttpRequest *)userToDoList :(id)target            
                              user:(GuluUserModel *)user;

- (GuluHttpRequest *)addPlaceToToDoList :(id)target            
                                place_id:(NSString *)place_id;

- (GuluHttpRequest *)addDishToToDoList :(id)target            
                                dish_id:(NSString *)dish_id;

- (GuluHttpRequest *)completeToDo :(id)target            
                           todo_id:(NSString *)todo_id;

- (GuluHttpRequest *)deleteToDo:(id)target            
                        todo_id:(NSString *)todo_id;

#pragma mark -
#pragma mark MyGULU


- (GuluHttpRequest *)userWallPost :(id)target            
                              user:(GuluUserModel *)user;

- (GuluHttpRequest *)userAroundMe:(id)target            
                              user:(GuluUserModel *)user;

- (GuluHttpRequest *)userFeed :(id)target            
                                   user:(GuluUserModel *)user;


- (GuluHttpRequest *)userFavoritedList :(id)target            
                                   user:(GuluUserModel *)user;

#pragma mark -
#pragma mark Friend

- (GuluHttpRequest *)userFriendsList :(id)target            
                                 user:(GuluUserModel *)user;

- (GuluHttpRequest *)userAddFriend :(id)target            
                                 user:(GuluUserModel *)otherUser;

- (GuluHttpRequest *)areYouMyFriend :(id)target            
                               user:(GuluUserModel *)otherUser;

- (GuluHttpRequest *)addContact :(id)target            
                         photoID:(NSString *)pid  
                           phone:(NSString *)phoneStr
                           email:(NSString *)emailStr
                        favorite:(NSString *)favoriteStr
                        nickname:(NSString *)nicknameStr;

#pragma mark -
#pragma mark Chat List

- (GuluHttpRequest *)userChatList :(id)target            
                              user:(GuluUserModel *)user;


@end
