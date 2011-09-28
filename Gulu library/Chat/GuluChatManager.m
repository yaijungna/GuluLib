//
//  GuluChatManager.m
//  GULUAPP
//
//  Created by alan on 11/9/19.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluChatManager.h"

@implementation GuluChatManager

@synthesize delegate;

@synthesize socket;
@synthesize UUID;

@synthesize subscribeMessageID;
@synthesize joinMessageID;
@synthesize createMessageID;
@synthesize hungryInfoMessageID;
@synthesize startHungryMessageID;
@synthesize stopHungryMessageID;
@synthesize amIhungryMessageID;

#pragma mark -

static id sharedMyManager_chat = nil;

+ (id) sharedManager
{    
    @synchronized(self){
        if(sharedMyManager_chat == nil){
            sharedMyManager_chat = [[super alloc] init];
		}
    }
    return sharedMyManager_chat;
}

- (id)init {
	
    self=[super init];
	if (self){
        socket=[[GuluSocket alloc] init];
        socket.delegate=self;
        
        subscribeMessageID=-1;
        joinMessageID=-1;
        createMessageID=-1;
        hungryInfoMessageID=-1;
        startHungryMessageID=-1;
        stopHungryMessageID=-1;
        amIhungryMessageID=-1;
        
    }    
	return self;
}

- (void) dealloc
{
    [socket release];
    [UUID release];
	[super dealloc];
}

-(void)sendMessageToSocket :(NSMutableDictionary *)dict
{
	CJSONSerializer *djsonserializer = [CJSONSerializer serializer]; 
	NSString *string = [djsonserializer serializeDictionary:dict];
	
	NSData* message = [string dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableData *message_data = [NSMutableData dataWithCapacity:([message length]+sizeof(uint32_t))];
	uint32_t message_len = CFSwapInt32HostToBig((uint32_t)[message length]);
	[message_data appendBytes:&message_len length:sizeof(uint32_t)];
	[message_data appendData:message];
	[socket writeDataToServer:(NSMutableData *)message_data];
}

-(void)sendMessageToChat:(NSString *)chatID  message:(NSString *)message
{
	NSNumber *messageID = [NSNumber numberWithInt:socket.messageID];
    
    if(chatID==nil){
        chatID=@"";}  

    if(message==nil){
        message=@"";}
	
	NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
	[dict setObject:@"message" forKey:@"method"];
	[dict setObject:message forKey:@"message"];
	[dict setObject:chatID forKey:@"chat"];
	[dict setObject:messageID forKey:@"message_id"];
	[self sendMessageToSocket:dict];
}

-(void)connectToChatServer
{
    ACLog(@"Start connecting...");
    socket.delegate=self;
	[socket connectToServerUsingStream:CHATSERVER portNo:CHATPORT];
}

-(void)connectToChatServerWithUUID:(NSString *)uuid 
{
    self.UUID=uuid;
    [self connectToChatServer];
}

#pragma mark -
#pragma mark chat room Function Methods

-(void)subscribe:(NSString *)chatID  
    participants:(NSString *)participants
{	    
    if(participants==nil){
        participants=@"";}   

    if(chatID==nil){
        chatID=@"";}  
    
    subscribeMessageID=socket.messageID;
	NSNumber *messageID = [NSNumber numberWithInt:socket.messageID];
	NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
	[dict setObject:@"subscribe" forKey:@"method"];
	[dict setObject:participants forKey:@"participant"];
    [dict setObject:[NSArray arrayWithObjects:chatID,nil] forKey:@"chats"];
	[dict setObject:messageID forKey:@"message_id"];
	[self sendMessageToSocket:dict];	
}

-(void)joinChatRoom:(NSString *)chatID 
{
    if(chatID==nil){
        chatID=@"";}   

    joinMessageID=socket.messageID;
	NSNumber *messageID = [NSNumber numberWithInt:socket.messageID];
	NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
	[dict setObject:@"join_chat" forKey:@"method"];
	[dict setObject:chatID forKey:@"chat"];
	[dict setObject:messageID forKey:@"message_id"];
	[self sendMessageToSocket:dict];	
}

-(void)createChatRoom:(NSString *)uid
{
    if(uid==nil){
        uid=@"";}   
    
    createMessageID=socket.messageID;
    NSNumber *messageID = [NSNumber numberWithInt:socket.messageID];
	NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
	[dict setObject:@"create_chat" forKey:@"method"];
	[dict setObject:uid forKey:@"f"];
	[dict setObject:messageID forKey:@"message_id"];
	[self sendMessageToSocket:dict];	
}

#pragma mark -
#pragma mark hungry Function Methods

-(void)getHungryInfoList
{
    hungryInfoMessageID=socket.messageID;
    NSNumber *messageID = [NSNumber numberWithInt:socket.messageID];
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"get_hungry" forKey:@"method"];
    [dict setObject:messageID forKey:@"message_id"];
    [self sendMessageToSocket:dict];
}

-(void)startHungry
{
    startHungryMessageID=socket.messageID;
    NSNumber *messageID = [NSNumber numberWithInt:socket.messageID];
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"start_hungry" forKey:@"method"];
    [dict setObject:messageID forKey:@"message_id"];
    [self sendMessageToSocket:dict];
}
-(void)stopHungry 
{
    stopHungryMessageID=socket.messageID;
    NSNumber *messageID = [NSNumber numberWithInt:socket.messageID];    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"stop_hungry" forKey:@"method"];
    [dict setObject:messageID forKey:@"message_id"];
    [self sendMessageToSocket:dict];
}

-(void)amIHungry
{
    amIhungryMessageID=socket.messageID;
    NSNumber *messageID = [NSNumber numberWithInt:socket.messageID];
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"amihungry" forKey:@"method"];
    [dict setObject:messageID forKey:@"message_id"];
    [self sendMessageToSocket:dict];
}

/*



-(void)handleSubscribeObjectData:(NSDictionary *)dict
{
    self.sessionUUID=[dict objectForKey:@"userUUID"];
    self.chatUUID=[dict objectForKey:@"chat"];
    
    self.participatesDict=[[[NSMutableDictionary alloc] init] autorelease];
    NSArray *participantsArray=[dict objectForKey:@"participants"];
    for( NSDictionary * temp in participantsArray){
        [participatesDict setObject:temp forKey:[temp objectForKey:@"uuid"]];}
    
    NSArray *messageArray=[dict objectForKey:@"messages"];
    self.historyMessageArray=[NSMutableArray arrayWithArray:messageArray];
    [historyMessageArray reverse];
}
*/
/*-(void)handleChatParticipantsObjectData:(NSDictionary *)dict
 {
 self.chatUUID=[dict objectForKey:@"chat"];
 self.FriendsDict=[NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:@"participants"]];
 
 NSLog(@"dict=%@",dict);
 NSLog(@"%@,%@",chatUUID,FriendsDict);
 
 
 }
 */

#pragma mark -

-(void)GuluSocketDelegateDidFinishReciveData:(NSMutableDictionary *)Dict
{
    ACLog(@"GuluSocketDelegateDidFinishReciveData %@",Dict);
    
    NSNumber *messageID=[Dict objectForKey:@"message_id"];
    NSNumber *numSubscribeMessageID=[NSNumber numberWithInt:subscribeMessageID];
    NSNumber *numJoinMessageID=[NSNumber numberWithInt:joinMessageID];
    NSNumber *numCreateMessageID=[NSNumber numberWithInt:createMessageID];
    NSNumber *numHungryInfoMessageID=[NSNumber numberWithInt:hungryInfoMessageID];
    NSNumber *numStartHungryMessageID=[NSNumber numberWithInt:startHungryMessageID];
    NSNumber *numStopHungryMessageID=[NSNumber numberWithInt:stopHungryMessageID];
    NSNumber *numAmIhungryMessageID=[NSNumber numberWithInt:amIhungryMessageID];
    
    BOOL success;
    if([Dict objectForKey:@"success"]){
        success=[[Dict objectForKey:@"success"] boolValue];}
    
    if( [messageID isEqualToNumber:numSubscribeMessageID])
    {
        
    }
    else if( [messageID isEqualToNumber:numJoinMessageID])
    {
        
    }
    else if( [messageID isEqualToNumber:numCreateMessageID])
    {
        
    }
    else if( [messageID isEqualToNumber:numHungryInfoMessageID])
    {
        
    }
    else if( [messageID isEqualToNumber:numStartHungryMessageID])
    {
        
    }
    else if( [messageID isEqualToNumber:numStopHungryMessageID])
    {
        
    }
    else if( [messageID isEqualToNumber:numAmIhungryMessageID])
    {
        
    }
    else
    {
    
        
    }
    
    [delegate GuluChatManagerDelegateDidFinishReciveData:Dict];
    
    /*
    
	if ([[Dict objectForKey:@"message_id"] isEqualToNumber:[NSNumber numberWithInt:subscribe_message_id]]) 
	{
        NSNumber *success=[Dict objectForKey:@"success"];
        
        if([success isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            NSArray *chatsArr = [Dict objectForKey:@"chats"];
            
            if(chatsArr==nil || [chatsArr count]==0)
                return;
            
            NSDictionary *chatDict = [chatsArr objectAtIndex:0];
            
            [self handleSubscribeObjectData:chatDict];
        }
        else
        {
            NSLog(@"subscribe error");
        }
        //====================
        
    }
    if ([[Dict objectForKey:@"message_id"] isEqualToNumber:[NSNumber numberWithInt:join_message_id]]) 
    {
        ACLog(@"join chat room");
        
        NSNumber *isSuccess=    [Dict objectForKey:@"success"];
        
        if([isSuccess isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            // [self handleChatParticipantsObjectData:Dict];
            
            NSDictionary *chatDict = [Dict objectForKey:@"chat"];
            [self handleSubscribeObjectData:chatDict];
        }
        else
        {
            NSLog(@"join error");
        }
    }
    if ([[Dict objectForKey:@"message_id"] isEqualToNumber:[NSNumber numberWithInt:create_message_id]]) 
    {
        ACLog(@"create chat room");
        
        NSNumber *isSuccess=    [Dict objectForKey:@"success"];
        
        if([isSuccess isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            //  [self handleChatParticipantsObjectData:Dict];
            
            NSDictionary *chatDict = [Dict objectForKey:@"chat"];
            [self handleSubscribeObjectData:chatDict];
        }
        else
        {
            NSLog(@"create error");
        }
    }
    
    //=============================
    
    if([[Dict objectForKey:@"type"] isEqualToString:@"participant"])// who join this caht room 
    {
        [participatesDict setObject:Dict forKey:[Dict objectForKey:@"uuid"]];
    }	
    if([[Dict objectForKey:@"type"] isEqualToString:@"message"])  //handle message
	{
        //    [historyMessageArray addObject:Dict];
	}
    if([[Dict objectForKey:@"type"] isEqualToString:@"broadcast"])  //handle broadcast
	{
        //    [historyMessageArray addObject:Dict];
	}
    
    [delegate handleChatData:Dict];
   */ 
    
}

-(void)GuluSocketDelegateDidConnectError
{
    
}

-(void)GuluSocketDelegateDidConnectOpen
{
     [self subscribe:@"" participants:UUID];
}

@end