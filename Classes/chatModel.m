//
//  chatModel.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/15.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "chatModel.h"
#import "debugDefined.h"

@implementation chatModel

@synthesize delegate;
@synthesize socket;

@synthesize subscribe_message_id;
@synthesize create_message_id;
@synthesize join_message_id;

@synthesize chatUUID;
@synthesize sessionUUID;

@synthesize FriendsDict;
@synthesize participatesDict;
@synthesize historyMessageArray;

@synthesize UUID;


#pragma mark -

static id sharedMyManager_chat = nil;

+ (id) sharedManager
{    
    @synchronized(self){
        if(sharedMyManager_chat == nil){
   //         sharedMyManager_chat = [[super alloc] init];
		}
    }
    return sharedMyManager_chat;
}

- (id)init {
	
    self=[super init];
	
   // socket=[[ACSocket alloc] init];
  /*  
     socket=[[GuluSocket alloc] init];
    socket.delegate=self;
    subscribe_message_id=-1;
    join_message_id=-1;
    create_message_id=-1;
    leave_message_id=-1;
   */
    
	return self;
}


- (void) dealloc
{
    self.delegate=nil;
    
    [socket release];
    [chatUUID release];
    [sessionUUID release];
    [FriendsDict release];
    
    [participatesDict release];
    [historyMessageArray release];
    
    [UUID release];
    
	[super dealloc];
}

-(void)sendMessageToChatServer :(NSMutableDictionary *)dict
{
    
    NSLog(@"%@",dict);
    
    
	CJSONSerializer *djsonserializer = [CJSONSerializer serializer]; 
	NSString *string = [djsonserializer serializeDictionary:dict];
	
	NSData* message = [string dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableData *message_data = [NSMutableData dataWithCapacity:([message length]+sizeof(uint32_t))];
	uint32_t message_len = CFSwapInt32HostToBig((uint32_t)[message length]);
	
	[message_data appendBytes:&message_len length:sizeof(uint32_t)];
	[message_data appendData:message];
	
	[socket writeDataToServer:(NSMutableData *)message_data];
    
}

-(void)connectToChatServer 
{
    ACLog(@"Chat connectToChatServer.");
    socket.delegate=self;
	[socket connectToServerUsingStream:CHATSERVER portNo:CHATPORT];
}

-(void)subscribe:(NSString *)chatID  
    participants:(NSString *)participants
{	
    
    if(chatID==nil)
    {
        chatID=@"";
    }   
    
    if(participants==nil)
    {
        participants=@"";
    //  return;
    }   

    
    subscribe_message_id=socket.messageID;
	NSArray *array=[NSArray arrayWithObjects:chatID,nil];
	NSNumber *messageID = [NSNumber numberWithInt:socket.messageID];
	
	NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
	[dict setObject:@"subscribe" forKey:@"method"];
	[dict setObject:participants forKey:@"participant"];
	[dict setObject:array forKey:@"chats"];
	[dict setObject:messageID forKey:@"message_id"];
	
	[self sendMessageToChatServer:dict];	
}

-(void)join_chat:(NSString *)chatID 
{
    ACLog(@"join_chat celled");
    if(chatID==nil)
    {
        chatID=@"";
    }   
    
    join_message_id=socket.messageID;
	NSNumber *messageID = [NSNumber numberWithInt:socket.messageID];
	
	NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
	[dict setObject:@"join_chat" forKey:@"method"];
	[dict setObject:chatID forKey:@"chat"];
	[dict setObject:messageID forKey:@"message_id"];
	
	[self sendMessageToChatServer:dict];	
    
}

-(void)leave_chat:(NSString *)chatID  participants:(NSString *)participants
{
    leave_message_id=socket.messageID;
    NSNumber *messageID = [NSNumber numberWithInt:socket.messageID];
	
	NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
	[dict setObject:@"leave_chat" forKey:@"method"];
	[dict setObject:participants forKey:@"participant"];
	[dict setObject:chatID forKey:@"chat"];
	[dict setObject:messageID forKey:@"message_id"];
	
	[self sendMessageToChatServer:dict];	
}

-(void)create_chat:(NSString *)uid
{
    if(uid==nil)
    {
        uid=@"";
    }   
    
    create_message_id=socket.messageID;
    NSNumber *messageID = [NSNumber numberWithInt:socket.messageID];
	
	NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
	[dict setObject:@"create_chat" forKey:@"method"];
	[dict setObject:uid forKey:@"f"];
	[dict setObject:messageID forKey:@"message_id"];
	
	[self sendMessageToChatServer:dict];	
}


#pragma mark -

-(void)sendMessageToChatServer:(NSString *)chatID  message:(NSString *)message
{
	NSNumber *messageID = [NSNumber numberWithInt:socket.messageID];
    
    ACLog(@" chatID:%@  meaasage:%@",chatID,message);
   
    if(chatID==nil)
    {
       chatID=@"";
    }   
	
	NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
	[dict setObject:@"message" forKey:@"method"];
	[dict setObject:message forKey:@"message"];
	[dict setObject:chatID forKey:@"chat"];
	[dict setObject:messageID forKey:@"message_id"];
    
    
    ACLog(@"%@",dict );
	
	[self sendMessageToChatServer:dict];
}


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
    
    ACLog(@"Chat ReciveData %@",Dict);
    
    ACLog(@"subscribe_message_id %d",subscribe_message_id);
    ACLog(@"join_message_id %d",join_message_id);
    ACLog(@"create_message_id %d",create_message_id);
    ACLog(@"leave_message_id %d",leave_message_id);
    
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


}
-(void)GuluSocketDelegateDidConnectError
{
    ACLog(@"DidError: Chat connect again");
    [self performSelector:@selector(connectToChatServer) withObject:nil afterDelay:10.0];
}
-(void)GuluSocketDelegateDidConnectOpen
{
    
    [self subscribe:@"" participants:UUID];
    
}

-(void)ACSocketDelegateDidError
{
    ACLog(@"DidError: Chat connect again");
    [self performSelector:@selector(connectToChatServer) withObject:nil afterDelay:10.0];
}

-(void)ACSocketDelegateDidOpen
{
    [self subscribe:@"" participants:UUID];
}

-(void)ACSocketDelegateDidFinishReciveData:(NSMutableDictionary *)Dict
{	
/*
	NSLog(@"Chat ReciveData %@",Dict);
    
    NSLog(@"subscribe_message_id %d",subscribe_message_id);
    NSLog(@"join_message_id %d",join_message_id);
    NSLog(@"create_message_id %d",create_message_id);
    NSLog(@"leave_message_id %d",leave_message_id);
 */
    
    ACLog(@"Chat ReciveData %@",Dict);
    
    ACLog(@"subscribe_message_id %d",subscribe_message_id);
    ACLog(@"join_message_id %d",join_message_id);
    ACLog(@"create_message_id %d",create_message_id);
    ACLog(@"leave_message_id %d",leave_message_id);
    
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
}





@end
