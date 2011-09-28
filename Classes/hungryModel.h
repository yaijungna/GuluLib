//
//  hungryModel.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/15.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chatModel.h"


@class GULUAPPAppDelegate;


@interface hungryModel : chatModel {

    NSMutableDictionary *hungryBlackFriendsDict; //hungry
    NSMutableDictionary *hungryFriendsDict; //hungry
    NSMutableArray *hungryChatsArray; //hungry   
    
    NSInteger hungryGet_message_id;
    NSInteger hungryStart_message_id;
    NSInteger hungryStop_message_id;
    NSInteger amihungry_message_id;
    
    
    BOOL hungryStatus;
    BOOL isWaitingForConnect;
    
    GULUAPPAppDelegate *appDelegate;
}

//======================= hungry =========================

- (id)initWithUUID :(NSString *)_UUID ;
-(void)chcekAndRemoveBlockedUser;

-(void)get_hungry;
-(void)start_hungry;
-(void)stop_hungry ;
-(void)connectToChatServerAgain;
-(void)amihungry ;

@property (nonatomic,retain)NSMutableDictionary *hungryBlackFriendsDict;
@property (nonatomic,retain)NSMutableDictionary *hungryFriendsDict; 
@property (nonatomic,retain)NSMutableArray *hungryChatsArray; 
@property (nonatomic)  BOOL hungryStatus;


@end
