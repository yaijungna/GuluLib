//
//  ACSocketAddSendRecieveMethod.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/1.
//  Copyright 2011 Gulu.com. All rights reserved.
//


#import "ACSocketAddSendRecieveMethod.h"


@implementation ACSocket (SendRecieve)


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
	
	[self writeToServer:(NSMutableData *)message_data];
 
}


@end
