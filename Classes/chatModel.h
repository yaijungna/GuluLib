//
//  chatModel.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/15.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACUtility.h"
#import "ACSocket.h"
#import "ACSocketAddSendRecieveMethod.h"
#import "API_URL.h"

#import "GuluSocket.h"

@protocol chatDelegate

- (void) handleChatData:(NSMutableDictionary *)Dict;

@end

@interface chatModel : NSObject<ACSocketDelegate,GuluSocketDelegate> {
    id <chatDelegate> delegate;
   // ACSocket *socket;
    GuluSocket *socket;
    
    NSInteger subscribe_message_id;
    NSInteger join_message_id;
    NSInteger create_message_id;
    NSInteger leave_message_id;
   
    NSString *chatUUID;
    NSString *sessionUUID;
    
    NSMutableDictionary *FriendsDict;    // only id and name
    NSMutableDictionary *participatesDict;
    NSMutableArray *historyMessageArray;
    
    NSString *UUID;

}
+ (id) sharedManager;
-(void)connectToChatServer;
-(void)subscribe:(NSString *)chatID  participants:(NSString *)participants;
-(void)join_chat:(NSString *)chatID ;
-(void)leave_chat:(NSString *)chatID  participants:(NSString *)participants;
-(void)create_chat:(NSString *)uid;

//======================= message =========================

-(void)sendMessageToChatServer:(NSString *)chatID message:(NSString *)message;


@property (nonatomic,assign) id <chatDelegate> delegate;
//@property (nonatomic,retain)ACSocket *socket;
@property (nonatomic,retain)GuluSocket *socket;

@property (nonatomic) NSInteger subscribe_message_id;
@property (nonatomic) NSInteger create_message_id;
@property (nonatomic) NSInteger join_message_id;

@property (nonatomic,retain)NSString *chatUUID;
@property (nonatomic,retain)NSString *sessionUUID;

@property (nonatomic,retain)NSMutableDictionary *FriendsDict;
@property (nonatomic,retain)NSMutableDictionary *participatesDict;
@property (nonatomic,retain)NSMutableArray *historyMessageArray;

@property (nonatomic,retain) NSString *UUID; 


@end
