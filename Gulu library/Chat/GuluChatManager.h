//
//  GuluChatManager.h
//  GULUAPP
//
//  Created by alan on 11/9/19.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJSONSerializer.h"
#import "GuluSocket.h"
#import "API_URL.h"


@protocol GuluChatManagerDelegate

-(void)GuluChatManagerDelegateDidFinishReciveData:(NSMutableDictionary *)resultDictionary;

@end


@interface GuluChatManager : NSObject<GuluSocketDelegate> 
{
    id <GuluChatManagerDelegate> delegate;
    
    GuluSocket *socket;
    NSString *UUID;
    
    NSInteger subscribeMessageID;
    NSInteger joinMessageID;
    NSInteger createMessageID;
    NSInteger hungryInfoMessageID;
    NSInteger startHungryMessageID;
    NSInteger stopHungryMessageID;
    NSInteger amIhungryMessageID;
}

+ (id) sharedManager;
-(void)connectToChatServerWithUUID:(NSString *)uuid ;
-(void)sendMessageToChat:(NSString *)chatID  message:(NSString *)message;

-(void)subscribe:(NSString *)chatID  participants:(NSString *)participants;
-(void)joinChatRoom:(NSString *)chatID ;
-(void)createChatRoom:(NSString *)uid;
-(void)getHungryInfoList;
-(void)startHungry;
-(void)stopHungry ;
-(void)amIHungry ;

@property(nonatomic,assign)id <GuluChatManagerDelegate> delegate;

@property (nonatomic,retain)GuluSocket *socket;
@property (nonatomic,retain) NSString *UUID; 

@property (nonatomic)NSInteger subscribeMessageID;
@property (nonatomic)NSInteger joinMessageID;
@property (nonatomic)NSInteger createMessageID;
@property (nonatomic)NSInteger hungryInfoMessageID;
@property (nonatomic)NSInteger startHungryMessageID;
@property (nonatomic)NSInteger stopHungryMessageID;
@property (nonatomic)NSInteger amIhungryMessageID;


@end
