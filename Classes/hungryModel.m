//
//  hungryModel.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/15.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "hungryModel.h"
#import "GULUAPPAppDelegate.h"
#import "debugDefined.h"

@implementation hungryModel

@synthesize hungryBlackFriendsDict;
@synthesize hungryChatsArray;
@synthesize hungryFriendsDict;
@synthesize hungryStatus;

- (id)initWithUUID :(NSString *)_UUID {
	
    self=[super init];
    
   appDelegate = (GULUAPPAppDelegate *) [[UIApplication sharedApplication] delegate];
	
    hungryBlackFriendsDict=[[NSMutableDictionary alloc] init ];
    
    self.UUID=_UUID;
    hungryGet_message_id=-1;
    hungryStart_message_id=-1;
    hungryStop_message_id=-1;
    
    if(UUID && ![UUID isEqualToString:@""])
    {
        [self connectToChatServerAgain];    
    }
	return self;
}

- (void) dealloc
{
    [hungryBlackFriendsDict release];
    [hungryChatsArray release];
    [hungryFriendsDict release];
 
	[super dealloc];
}

-(void)chcekAndRemoveBlockedUser
{
 /*   NSArray *arr =[hungryFriendsDict allKeys];
    
    for(NSString *uuidstr  in  arr)
    {
        if( [hungryBlackFriendsDict objectForKey:uuidstr] )
        {
            [hungryFriendsDict removeObjectForKey:uuidstr];
        }
    }
  */
    
   // NSLog(@" %@",hungryChatsArray);
   // NSLog(@" %@",hungryFriendsDict);

   // ACLog(@" %@",hungryChatsArray);
   // ACLog(@" %@",hungryFriendsDict);

    
    
    for( NSDictionary *chatDict in hungryChatsArray )
    {
     //   NSString *chatUUID=[chatDict objectForKey:@"chat"];
        NSArray *participatesArr=[chatDict objectForKey:@"participants"];
       
      //  BOOL isInThisChat;
        
        for(NSDictionary *dict  in participatesArr)
        {
            NSString *user_id=[dict objectForKey:@"user_id"];
            [hungryFriendsDict removeObjectForKey:user_id];
        }
        /*
        NSLog(@"amInThisChat %d",amInThisChat);
        
        if(amInThisChat)
        {
            for(NSDictionary *dict  in participatesArr)
            {
                NSString *user_id=[dict objectForKey:@"user_id"];
                
                if(![appDelegate.userMe.uid isEqualToString:user_id])
                {
                    [hungryFriendsDict removeObjectForKey:user_id];
                }
            }
        }
         */
    }
    

   // NSLog(@" %@",hungryChatsArray);
   // NSLog(@" %@",hungryFriendsDict);
    
   // ACLog(@" %@",hungryChatsArray);
   // ACLog(@" %@",hungryFriendsDict);

    
    
}

-(void)get_hungry
{
    hungryGet_message_id=socket.messageID;
    NSNumber *messageID = [NSNumber numberWithInt:socket.messageID];
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"get_hungry" forKey:@"method"];
    [dict setObject:messageID forKey:@"message_id"];
    
    [socket sendMessageToChatServer:dict];
}


-(void)start_hungry
{
    hungryStart_message_id=socket.messageID;
    NSNumber *messageID = [NSNumber numberWithInt:socket.messageID];
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"start_hungry" forKey:@"method"];
    [dict setObject:messageID forKey:@"message_id"];
    
    [socket sendMessageToChatServer:dict];
  
}

-(void)stop_hungry 
{    
    hungryStop_message_id=socket.messageID;
    NSNumber *messageID = [NSNumber numberWithInt:socket.messageID];
    
   NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"stop_hungry" forKey:@"method"];
    [dict setObject:messageID forKey:@"message_id"];
    
    [socket sendMessageToChatServer:dict];
}

-(void)amihungry 
{    
    amihungry_message_id=socket.messageID;
    NSNumber *messageID = [NSNumber numberWithInt:socket.messageID];
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"amihungry" forKey:@"method"];
    [dict setObject:messageID forKey:@"message_id"];
    
    [socket sendMessageToChatServer:dict];
}


#pragma mark -

-(void)connectToChatServerAgain
{
    if(UUID && ![UUID isEqualToString:@""])
    {
        ACLog(@"hungry connectToChatServerAgain");
        [self connectToChatServer];
    }
    else
    {
        ACLog(@"hungry not connectToChatServerAgain");
    }
}

-(void)ACSocketDelegateDidOpen
{
    [self subscribe:@"" participants:UUID];
}

-(void)ACSocketDelegateDidError
{
    self.hungryFriendsDict=nil;
    self.hungryChatsArray=nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChatTable" object:nil];
    
    [self performSelector:@selector(connectToChatServerAgain) withObject:nil afterDelay:10.0];

    
    ACLog(@" %@",UUID);
}

-(void)ACSocketDelegateDidFinishReciveData:(NSMutableDictionary *)Dict
{	
//	NSLog(@"Hungry ReciveData %@",Dict);
    ACLog(@"Hungry ReciveData %@",Dict);
    
	if ([[Dict objectForKey:@"message_id"] isEqualToNumber:[NSNumber numberWithInt:subscribe_message_id]]) 
	{
        NSNumber *success=[Dict objectForKey:@"success"];
        
        if([success isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            [self get_hungry];
            [self amihungry];
            
            ACLog(@"subscribe ok");

        }
        else
        {
           // NSLog(@"subscribe error");
             ACLog(@"subscribe error");
        }
    }
    if ([[Dict objectForKey:@"message_id"] isEqualToNumber:[NSNumber numberWithInt:hungryGet_message_id]]) 
    {
        NSNumber *isSuccess=[Dict objectForKey:@"success"];
        
        if([isSuccess isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hungryStatusNotify" object:nil];
            
            self.hungryFriendsDict=[NSMutableDictionary dictionaryWithDictionary:[Dict objectForKey:@"friends"]];
            self.hungryChatsArray=[NSMutableArray arrayWithArray:[Dict objectForKey:@"chats"]];
            
          //  NSLog(@"%@",hungryChatsArray);
           // NSLog(@"%@",hungryFriendsDict);
            
          //  NSLog(@"---");
            
            ACLog(@"Get hungry ok");
            
        }
        else
        {
            //NSLog(@"Get hungry error");
            ACLog(@"Get hungry error");

        }

    }

    if ([[Dict objectForKey:@"message_id"] isEqualToNumber:[NSNumber numberWithInt:hungryStart_message_id]]) 
    {
        NSNumber *isSuccess=[Dict objectForKey:@"success"];

        if([isSuccess isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            hungryStatus=YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hungryStatusNotify" object:nil];
            
            self.hungryFriendsDict=[NSMutableDictionary dictionaryWithDictionary:[Dict objectForKey:@"friends"]];
            self.hungryChatsArray=[NSMutableArray arrayWithArray:[Dict objectForKey:@"chats"]];
            
          //  NSLog(@"%@",hungryChatsArray);
          //  NSLog(@"%@",hungryFriendsDict);
            
          //  NSLog(@"hungry Start ok");
            
         //   NSLog(@"---");
            
             ACLog(@"Start hungry ok");
            
        }
        else
        {
            //NSLog(@"Start hungry error");
            ACLog(@"Start hungry error");
        }
    }
    if ([[Dict objectForKey:@"message_id"] isEqualToNumber:[NSNumber numberWithInt:hungryStop_message_id]]) 
    {
         NSNumber *isSuccess=[Dict objectForKey:@"success"];
        
        if([isSuccess isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            hungryStatus=NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hungryStatusNotify" object:nil];
          //  self.hungryFriendsDict=nil;
           // self.hungryChatsArray=nil;
            [self get_hungry];
           // NSLog(@"Stop hungry ok = %@",Dict);
            
            ACLog(@"Stop hungry ok");
        }
        else
        {
            //NSLog(@"Stop hungry error");
            ACLog(@"Stop hungry error");

        }
    }
    
       
    //============================================================
    
    if ([[Dict objectForKey:@"type"] isEqualToString:@"showchat"]) 
    {
        NSDictionary *dataDict=[Dict objectForKey:@"data"];
          
        NSString *chatID=[dataDict objectForKey:@"chat"];
        
        BOOL AlreadyExist=NO;
        
        for( NSDictionary *dictTemp in hungryChatsArray)
        {
            if([[dictTemp objectForKey:@"chat"] isEqualToString:chatID])
            {
                AlreadyExist=YES;   
            }
        }
        
        if(!AlreadyExist)
        {
            [hungryChatsArray addObject:dataDict];
        }
        
        ACLog(@"showchat ok");
      //  NSLog(@"showchat ok");
      //  NSLog(@"---");
    }
    
    if ([[Dict objectForKey:@"type"] isEqualToString:@"hidechat"]) 
    {
        NSDictionary *dataDict=[Dict objectForKey:@"data"];
        NSString *chatID=[dataDict objectForKey:@"chat"];
        
        for(  NSDictionary *dict in historyMessageArray)
        {
            if([dict objectForKey:[NSString stringWithFormat:@"%@",chatID]])
            {
                [hungryChatsArray removeObject:dict];
                
               // NSLog(@"hidechat ok");
                
                 ACLog(@"hidechat ok");
                break;
            }
        }
    }
    
    //===========================================================
    
    if ([[Dict objectForKey:@"type"] isEqualToString:@"start"]) 
    {
        NSDictionary *dict=[Dict objectForKey:@"data"];
        NSString *value =[[dict allValues] objectAtIndex:0];
        NSString *key =[[dict allKeys] objectAtIndex:0];
        [hungryFriendsDict setObject:value forKey:key];
        
      //  NSLog(@"start %@",hungryFriendsDict);
         ACLog(@"start ok");
    }
    
    if ([[Dict objectForKey:@"type"] isEqualToString:@"stop"]) 
    {
        NSDictionary *dict=[Dict objectForKey:@"data"];
        NSString *key =[[dict allKeys] objectAtIndex:0];
        
        
        [hungryBlackFriendsDict removeObjectForKey:key];
        [hungryFriendsDict removeObjectForKey:key];
        [self get_hungry];
        
        // NSLog(@"stop ok");
        ACLog(@"stop ok");
    }
    
    //============================================================
    
    if ([[Dict objectForKey:@"type"] isEqualToString:@"expire"]) 
    {
        hungryStatus=NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hungryStatusNotify" object:nil];
        //  self.hungryFriendsDict=nil;
        // self.hungryChatsArray=nil;
        [self get_hungry];
    }
    
    //=============================
    
    if ([Dict objectForKey:@"hungry"]) 
    {
        if([[Dict objectForKey:@"hungry"] isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            
            ACLog(@"Am I hungry YES");
            hungryStatus=YES;
        }
        else
        {
            ACLog(@"Am I hungry NO");
             hungryStatus=NO;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hungryStatusNotify" object:nil];
    }
    
    //=========================

    
    
    
    [self chcekAndRemoveBlockedUser];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChatTable" object:nil];

}



@end
