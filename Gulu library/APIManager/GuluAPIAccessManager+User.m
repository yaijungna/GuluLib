//
//  GuluAPIAccessManager+User.m
//  GULUAPP
//
//  Created by alan on 11/9/9.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluAPIAccessManager+User.h"

@implementation GuluAPIAccessManager(User)


#pragma mark -
#pragma mark ********** USER **********

#pragma mark -
#pragma mark  get user UUID

- (GuluHttpRequest *)getUserUUID :(id)target            
                             user:(GuluUserModel *)user
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(user,@"Pass a null object.");
    NSAssert(user.ID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:user.ID forKey:@"uid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_USER_UUID
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(getUserUUIDFinish:)];
    [http setDidFailSelector:@selector(getUserUUIDFail:)];
    [http startAsynchronous];
    
    return http;


}
- (void)getUserUUIDFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    if([info isKindOfClass:[NSDictionary class]]){
        NSString *uuid=[info objectForKey: @"uuid"];
        if(uuid){
            info=uuid;}
        else{
            NSLog(@"GET UUID ERROR %@",info);
            info=nil;}
    }
    else{
        NSLog(@"GET UUID ERROR %@",info);
        info=nil;
    }
    
    [self APIRequestFinish:request returnData:info];
}

-(void)getUserUUIDFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


#pragma mark -
#pragma mark get UserVoice Token

- (GuluHttpRequest *)getUserVoiceToken:(id)target
{
    NSAssert(target,@"Pass a null object.");
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_USERVOICE_TOKEN
                                                       target:target];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(getUserVoiceTokenFinish:)];
    [http setDidFailSelector:@selector(getUserVoiceTokenFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)getUserVoiceTokenFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    
    if([info isKindOfClass:[NSDictionary class]]){
        NSString *sso_token=[info objectForKey: @"sso_token"];
        if(sso_token){
            info=sso_token;}
        else{
            NSLog(@"GET User Voice Token ERROR: %@",info);
            info=nil;}
    }
    else{
        NSLog(@"GET UUID ERROR: %@",info);
        info=nil;
    }
    
    
    [self APIRequestFinish:request returnData:info];
}

-(void)getUserVoiceTokenFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark get user info

- (GuluHttpRequest *)userInformation :(id)target            
                                 user:(GuluUserModel *)user
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(user.ID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
   [dict setObject:user.ID forKey:@"user_id"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_USER_USER_INFO
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(userInformationFinish:)];
    [http setDidFailSelector:@selector(userInformationFail:)];
    [http startAsynchronous];
    
    return http;
    
}

-(void)userInformationFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    GuluUserModel *model=[[[GuluUserModel alloc] init] autorelease];
    [model switchDataIntoModel:info];
           
    [self APIRequestFinish:request returnData:model];
}

-(void)userInformationFail:(GuluHttpRequest *)request
{
    [self APIRequestFail:request returnData:nil];
}


#pragma mark -
#pragma mark update user info

- (GuluHttpRequest *)updateUserInformation :(id)target            
                                       user:(GuluUserModel *)user
                                    picture:(UIImage *)picture
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(picture,@"Pass a null object.");
    NSAssert(user.about_me,@"Pass a null object.");
    
    NSData *imagedata= UIImageJPEGRepresentation(picture, 0.5);

    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:imagedata forKey:@"uploadedfile"];
    [dict setObject:user.about_me forKey:@"about_text"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_USER_UPLOAD_USER_INFO
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(updateUserInformationFinish:)];
    [http setDidFailSelector:@selector(updateUserInformationFail:)];
    [http startAsynchronous];
    
    return http;
    
}

-(void)updateUserInformationFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    GuluUserModel *model=[[[GuluUserModel alloc] init] autorelease];
    [model switchDataIntoModel:info];
    
    [self APIRequestFinish:request returnData:model];
}

-(void)updateUserInformationFail:(GuluHttpRequest *)request
{
    [self APIRequestFail:request returnData:nil];
}



#pragma mark -
#pragma mark ********** TODO **********
#pragma mark -
#pragma mark get todo list

- (GuluHttpRequest *)userToDoList :(id)target            
                              user:(GuluUserModel *)user
{

    NSAssert(target,@"Pass a null object.");
    NSAssert(user.ID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:user.ID forKey:@"uid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_MYGULU_TODO
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(userToDoListFinish:)];
    [http setDidFailSelector:@selector(userToDoListFail:)];
    [http startAsynchronous];
    
    return http;

}

-(void)userToDoListFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];

    NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
    
    for(NSDictionary *dict in info)
    {
        GuluTodoItemModel *model=[[[GuluTodoItemModel alloc] init] autorelease];
        [model switchDataIntoModel:dict];
        [array addObject:model];
    }
    
    [self APIRequestFinish:request returnData:array];
}

-(void)userToDoListFail:(GuluHttpRequest *)request
{
    [self APIRequestFail:request returnData:nil];
}


#pragma mark -
#pragma mark add dish to todo

- (GuluHttpRequest *)addPlaceToToDoList :(id)target            
                                place_id:(NSString *)place_id
{
    
    NSAssert(target,@"Pass a null object.");
    NSAssert(place_id,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:place_id forKey:@"rid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_TODO_ADD_RESTAURANT
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(addPlaceToToDoFinish:)];
    [http setDidFailSelector:@selector(addPlaceToToDoFail:)];
    [http startAsynchronous];
    
    return http;
}

-(void)addPlaceToToDoFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    [self APIRequestFinish:request returnData:info];
}

-(void)addPlaceToToDoFail:(GuluHttpRequest *)request
{
    [self APIRequestFail:request returnData:nil];
}

#pragma mark -
#pragma mark add dish to todo

- (GuluHttpRequest *)addDishToToDoList :(id)target            
                                dish_id:(NSString *)dish_id
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(dish_id,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:dish_id forKey:@"did"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_TODO_ADD_DISH
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(addDishToToDoFinish:)];
    [http setDidFailSelector:@selector(addDishToToDoFail:)];
    [http startAsynchronous];
    
    return http;
}

-(void)addDishToToDoFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];

    [self APIRequestFinish:request returnData:info];
}

-(void)addDishToToDoFail:(GuluHttpRequest *)request
{
    [self APIRequestFail:request returnData:nil];
}

#pragma mark -
#pragma mark complete todo

- (GuluHttpRequest *)completeToDo :(id)target            
                           todo_id:(NSString *)todo_id
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(todo_id,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
   [dict setObject:todo_id forKey:@"todo_id"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_TODO_COMPLETE
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(completeToDoFinish:)];
    [http setDidFailSelector:@selector(completeToDoFail:)];
    [http startAsynchronous];
    
    return http;
}

-(void)completeToDoFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    [self APIRequestFinish:request returnData:info];
}

-(void)completeToDoFail:(GuluHttpRequest *)request
{
    [self APIRequestFail:request returnData:nil];
}

#pragma mark -
#pragma mark delete todo

- (GuluHttpRequest *)deleteToDo:(id)target            
                        todo_id:(NSString *)todo_id
{

    NSAssert(target,@"Pass a null object.");
    NSAssert(todo_id,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:todo_id forKey:@"todo_id"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_TODO_DELETE
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(deleteToDoFinish:)];
    [http setDidFailSelector:@selector(deleteToDoFail:)];
    [http startAsynchronous];
    
    return http;
}

-(void)deleteToDoFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    [self APIRequestFinish:request returnData:info];
}

-(void)deleteToDoFail:(GuluHttpRequest *)request
{
    [self APIRequestFail:request returnData:nil];
}

#pragma mark -
#pragma mark ********** MYGULU **********

#pragma mark -
#pragma mark wall post

- (GuluHttpRequest *)userWallPost :(id)target            
                              user:(GuluUserModel *)user;
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(user.ID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:user.ID forKey:@"uid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_MYGULU_MYPOST
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(userWallPostFinish:)];
    [http setDidFailSelector:@selector(userWallPostFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)userWallPostFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
    
    for(NSDictionary *dict in info)
    {
        GuluReviewModel *model=[[[GuluReviewModel alloc] init] autorelease];
        [model switchDataIntoModel:dict];
        [array addObject:model];
    }
    
    [self APIRequestFinish:request returnData:array];
}

-(void)userWallPostFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


#pragma mark -
#pragma mark aroundme

- (GuluHttpRequest *)userAroundMe:(id)target            
                             user:(GuluUserModel *)user
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(user.ID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:user.ID forKey:@"uid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_MYGULU_AROUNDME
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(userAroundMeFinish:)];
    [http setDidFailSelector:@selector(userAroundMeFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)userAroundMeFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
    
    for(NSDictionary *dict in info)
    {
        GuluAroundMeModel *model=[[[GuluAroundMeModel alloc] init] autorelease];
        [model switchDataIntoModel:dict];
        [array addObject:model];
    }
    
    [self APIRequestFinish:request returnData:array];
}

-(void)userAroundMeFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


#pragma mark -
#pragma mark feed

- (GuluHttpRequest *)userFeed :(id)target            
                          user:(GuluUserModel *)user
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(user.ID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:user.ID forKey:@"uid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_MYGULU_FEED
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(userFeedFinish:)];
    [http setDidFailSelector:@selector(userFeedFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)userFeedFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
     NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
    
    for(NSDictionary *dict in info)
    {
        GuluWallFeedModel *model=[[[GuluWallFeedModel alloc] init] autorelease];
        [model switchDataIntoModel:dict];
        [array addObject:model];
    }
    
     [self APIRequestFinish:request returnData:array];

}

-(void)userFeedFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


#pragma mark -
#pragma mark favorite List


- (GuluHttpRequest *)userFavoritedList :(id)target            
                                   user:(GuluUserModel *)user
{
    
    NSAssert(target,@"Pass a null object.");
    NSAssert(user.ID,@"Pass a null object.");
    
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:user.ID forKey:@"user_id"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_FAVORITE_LIST
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(userFavoritedListFinish:)];
    [http setDidFailSelector:@selector(userFavoritedListFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)userFavoritedListFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
    
    for(NSDictionary *dict in info)
    {
        NSString* typeString =[dict objectForKey:@"type"];
        int type=[typeString intValue];
        NSDictionary *objectDict=[dict  objectForKey:@"object"];
        
        id model=[GuluModel getObjectByfavoriteType:type data:objectDict];
        [array addObject:model];
    }
    
    [self APIRequestFinish:request returnData:array];
}

-(void)userFavoritedListFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark ********** FRIEND **********

#pragma mark -
#pragma mark friend list
- (GuluHttpRequest *)userFriendsList :(id)target            
                                 user:(GuluUserModel *)user
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(user.ID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:user.ID forKey:@"uid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_MYGULU_FRIEND
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(userFriendsListFinish:)];
    [http setDidFailSelector:@selector(userFriendsListFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)userFriendsListFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
    
    for(NSDictionary *dict in info)
    {
        GuluContactModel *model=[[[GuluContactModel alloc] init] autorelease];
        [model switchDataIntoModel:dict];
        [array addObject:model];
    }
    
    [self APIRequestFinish:request returnData:array];
}

-(void)userFriendsListFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark add a new friend


- (GuluHttpRequest *)userAddFriend :(id)target            
                            user:(GuluUserModel *)otherUser
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(otherUser.ID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:otherUser.ID forKey:@"user_id"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_USER_ADD_FRIEND
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(userAddFriendFinish:)];
    [http setDidFailSelector:@selector(userAddFriendFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)userAddFriendFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
          
    [self APIRequestFinish:request returnData:info];
}

-(void)userAddFriendFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


#pragma mark -
#pragma mark check someon else is my friend

- (GuluHttpRequest *)areYouMyFriend :(id)target            
                             user:(GuluUserModel *)otherUser
{

    NSAssert(target,@"Pass a null object.");
    NSAssert(otherUser.ID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:otherUser.ID forKey:@"user_id"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_USER_ARE_FRIENDS
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(areYouMyFriendFinish:)];
    [http setDidFailSelector:@selector(areYouMyFriendFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)areYouMyFriendFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    [self APIRequestFinish:request returnData:info];
}

-(void)areYouMyFriendFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark add contact

- (GuluHttpRequest *)addContact :(id)target            
                         photoID:(NSString *)pid  
                           phone:(NSString *)phoneStr
                           email:(NSString *)emailStr
                        favorite:(NSString *)favoriteStr
                        nickname:(NSString *)nicknameStr
{
    
    NSAssert(target,@"Pass a null object.");
    NSAssert(pid,@"Pass a null object.");
    NSAssert(phoneStr,@"Pass a null object.");
    NSAssert(emailStr,@"Pass a null object.");
    NSAssert(favoriteStr,@"Pass a null object.");
    NSAssert(nicknameStr,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    
    [dict setObject:pid forKey:@"photo_id"];
	[dict setObject:phoneStr forKey:@"phone"];
	[dict setObject:emailStr forKey:@"email"];
	[dict setObject:favoriteStr forKey:@"favorite"];
	[dict setObject:nicknameStr forKey:@"nickname"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_FRIEND_ADD_FRIEND
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(areYouMyFriendFinish:)];
    [http setDidFailSelector:@selector(areYouMyFriendFail:)];
    [http startAsynchronous];
    
    return http;
}


- (void)addContactFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    [self APIRequestFinish:request returnData:info];
}

-(void)addContactFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}



#pragma mark -
#pragma mark ********** CHAT **********

#pragma mark -
#pragma mark Chat List

- (GuluHttpRequest *)userChatList :(id)target            
                              user:(GuluUserModel *)user
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(user,@"Pass a null object.");
    NSAssert(user.ID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:user.ID forKey:@"uid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_CHAT_CHATROOMLIST 
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(userChatListFinish:)];
    [http setDidFailSelector:@selector(userChatListFail:)];
    [http startAsynchronous];
    
    return http;

}

- (void)userChatListFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];

 //   NSLog(@"%@",info);
    
    NSMutableArray *array=[[[NSMutableArray alloc] init] autorelease];
    
    for(NSDictionary *dict in info)
    {
        GuluChatModel *model=[[[GuluChatModel alloc] init] autorelease];
        [model switchDataIntoModel:dict];
        [array addObject:model];
    }
    
    [self APIRequestFinish:request returnData:array];
}

-(void)userChatListFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

@end
