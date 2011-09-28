//
//  ACSocketAddSendRecieveMethod.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/1.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJSONSerializer.h"
#import "CJSONDeserializer.h"
#import "ACSocket.h"

@interface ACSocket (SendRecieve)

-(void)sendMessageToChatServer :(NSMutableDictionary *)dict;

@end
