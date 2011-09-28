//
//  ACSocket.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/26.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSStreamAdditions.h"
#import "CJSONDeserializer.h"


@protocol ACSocketDelegate

-(void)ACSocketDelegateDidFinishReciveData:(NSMutableDictionary *)Dict;
-(void)ACSocketDelegateDidError;
-(void)ACSocketDelegateDidOpen;

@end


@interface ACSocket : NSObject <NSStreamDelegate> {
	id <ACSocketDelegate>  delegate;
	
	NSInputStream *iStream;
	NSOutputStream *oStream;
	NSMutableData *data;
	
	NSInteger messageID;
}

@property(nonatomic,assign) id <ACSocketDelegate>  delegate;
@property(nonatomic) NSInteger messageID;
@property(nonatomic, retain) NSMutableData *data;

@property(nonatomic, retain)NSInputStream *iStream;
@property(nonatomic, retain)NSOutputStream *oStream;

- (void) connectToServerUsingStream:(NSString *)urlStr 
							 portNo:(uint) portNo ;

- (void) disconnect;

- (void) writeToServer:(NSMutableData *) messageData;

@end
