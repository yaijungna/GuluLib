//
//  GuluSocket.h
//  GULUAPP
//
//  Created by alan on 11/9/14.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "debugDefined.h"
#import "NSStream+additions.h"
#import "CJSONDeserializer.h"


@protocol GuluSocketDelegate

-(void)GuluSocketDelegateDidFinishReciveData:(NSMutableDictionary *)Dict;
-(void)GuluSocketDelegateDidConnectError;
-(void)GuluSocketDelegateDidConnectOpen;

@end


@interface GuluSocket : NSObject <NSStreamDelegate> {
	NSInputStream *iStream;
	NSOutputStream *oStream;
    NSInteger messageID;
	
	NSMutableData *data;
    
    id <GuluSocketDelegate>delegate;
}

@property(nonatomic, retain)NSInputStream *iStream;
@property(nonatomic, retain)NSOutputStream *oStream;
@property(nonatomic) NSInteger messageID;
@property(nonatomic, retain) NSMutableData *data;
@property(nonatomic, assign)id <GuluSocketDelegate>delegate;

- (void) connectToServerUsingStream:(NSString *)urlStr 
							 portNo:(uint) portNo ;
- (void) disconnect;
- (void) writeDataToServer:(NSMutableData *) messageData;

@end
