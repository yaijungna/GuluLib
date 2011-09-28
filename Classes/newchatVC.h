//
//  chatRoomViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/6.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_Invite.h"
#import "AppStrings_chat.h"
#import "ChatTextFieldView.h"
#import "ChatEventHeaderView.h"

#import "ACSocket.h"
#import "ACSocketAddSendRecieveMethod.h"
#import "chatModel.h"

#import "GuluChatManager.h"

@interface newchatVC : UIViewController  <GuluChatManagerDelegate ,chatDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource> 

{
	TopMenuBarView *topView;
	UITableView *table;
	UIView *myView;
	ChatTextFieldView *chatView;
    
    chatModel *chat;
    
	NSMutableArray *chatArray;   
	NSMutableDictionary *chatDictionary;
	NSMutableDictionary *participatesDict;
    NSString *UUID; //user uuid
    NSString *myUUID; //session uuid 
    NSString *chatID;
    NSString *createWithUserUUID;
    
    GuluChatManager *manager;

    
    
}

@property (nonatomic,retain)NSMutableDictionary *chatDictionary;
@property (nonatomic,retain)NSMutableArray *chatArray;
@property (nonatomic,retain)NSMutableDictionary *participatesDict;
@property (nonatomic,retain)NSString *UUID;
@property (nonatomic,retain)NSString *myUUID;
@property (nonatomic,retain)NSString *chatID;
@property (nonatomic,retain)chatModel *chat;


@end
