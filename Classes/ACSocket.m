//
//  ACSocket.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/26.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACSocket.h"
#import "debugDefined.h"

@implementation ACSocket

@synthesize delegate;
@synthesize messageID;
@synthesize data;

@synthesize iStream,oStream;

- (id)init {
    
    self=[super init];
    self.data=[[[NSMutableData alloc] initWithCapacity:0] autorelease];

	return self;
}

- (void)dealloc {
    [self disconnect];
    
    [iStream release];
    [oStream release];
	[data release];
	
    [super dealloc];
}

-(void) disconnect {
    [iStream close];
    [oStream close];
    
    [iStream release];
    [oStream release];
    
    iStream=nil;
    oStream=nil;
    
    self.data=[[[NSMutableData alloc] initWithCapacity:0] autorelease];
}

-(void) connectToServerUsingStream:(NSString *)urlStr 
                            portNo:(uint) portNo 
{	
    [self disconnect];
    
    if (![urlStr isEqualToString:@""]) 
	{
        NSURL *website = [NSURL URLWithString:urlStr];
        if (!website) {
            return;} 
		else 
		{
			[NSStream getStreamsToHostNamed:urlStr
									   port:portNo 
								inputStream:&iStream
							   outputStream:&oStream];
     
            [iStream retain];
            [oStream retain];
            
            [iStream setDelegate:self];
            [oStream setDelegate:self];
            
            [iStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                               forMode:NSDefaultRunLoopMode];
            
            [oStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                               forMode:NSDefaultRunLoopMode];
            [oStream open];
            [iStream open];  
        }
	} 
}

-(void) writeToOutputStream:(NSMutableData *) messageData
{	
	const uint8_t *buf = [messageData mutableBytes]  ;
	NSInteger length=[messageData length];
	int len=[oStream write:buf maxLength:length];   
    
	if (len > 0)	{
		ACLog(@"GuluSoket sends message successfully");}
    else	{
		ACLog(@"GuluSoket sends message failed.");}
}

-(void) writeToServer:(NSMutableData *) messageData
{
	messageID++; 
	NSInteger length=[messageData length];
	
	if (length > 0 ) {
        ACLog(@"GuluSoket write to chat server start with data: %@",messageData);
    }
    else{
        ACLog(@"GuluSoket no data to send.");
        return ;
    }

    NSOperationQueue *someQueue = [NSOperationQueue mainQueue];
    NSInvocationOperation *invocationOp1 = [[NSInvocationOperation alloc]  initWithTarget:self
                                                                                 selector:@selector(writeToOutputStream:)
                                                                                   object:messageData] ;
    [someQueue addOperation:invocationOp1]; 
    [invocationOp1 release];
}

-(int) getLengthOfGuluMessageData:(NSData *)messageData
{
    NSRange range = NSMakeRange(0,4);
    NSData *tempData = [messageData subdataWithRange:range];
    
    uint32_t  *templength = malloc(1);
    [tempData getBytes:templength length:4];
    int  length = NSSwapBigIntToHost(templength[0]);
    free(templength);
    
    return length;

}

-(void) handleInputStream
{
    while ([iStream hasBytesAvailable])
	{
        NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
        
        uint8_t buffer[32768];
        int iStreamLength;
        
        iStreamLength=[iStream read:buffer maxLength:sizeof(buffer)];
        if(iStreamLength <=0) {
            ACLog(@"iStream read data failed.");
            return;
        }
        
        
        NSMutableData *append=[NSMutableData dataWithBytes:buffer length:iStreamLength] ;
        [data appendData:append];
        
        NSInteger messageLength=[self getLengthOfGuluMessageData:data];
        
        ACLog(@"message length   = %d",messageLength);
        ACLog(@"recieving length = %d",[data length]);
        
        if([data length] >= messageLength)
        {
            while ([data length] >= messageLength  ) 
            {
                ACLog(@"Start to parse data from chat server.");
                
                NSRange range2 = NSMakeRange(4,messageLength);
                NSMutableData *newData=[NSMutableData dataWithData:[data subdataWithRange:range2]] ;
                
                NSError *derror;
                CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
                NSDictionary *tempDict = [djsonDeserializer deserializeAsDictionary:newData error:&derror];
                NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:tempDict];
                [delegate ACSocketDelegateDidFinishReciveData:dict];
                [data replaceBytesInRange:NSMakeRange(0, 4+messageLength) withBytes:nil length:0];
                ACLog(@"Finishing parsing data from chat server.");
                
                if([data length]>=4)
                {
                    messageLength=[self getLengthOfGuluMessageData:data];
                    
                    ACLog(@"message length   = %d",messageLength);
                    ACLog(@"recieving length = %d",[data length]);
                }
            }
        }
        else
        {
            ACLog(@"Waiting for data coming.");
        }
        
        
        [pool drain];
    }
}	

/*
 
 * NSStreamEventNone -- No event has occurred
 * NSStreamEventOpenCompleted -- The open has completed successfully.
 * NSStreamEventHasBytesAvailable -- The stream has bytes to be read.
 * NSStreamEventHasSpaceAvailable -- The stream can accept bytes for writing.
 * NSStreamEventErrorOccurred -- An error has occurred on the stream.
 * NSStreamEventEndEncountered -- The end of the stream has been reached. 
 
 */

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    
	switch(eventCode) {
        case NSStreamEventHasBytesAvailable:
        {
            if (stream == iStream)
			{
                ACLog(@"iStream hasBytesAvailable");
				[self handleInputStream];
			}	
		} break;
			
		case NSStreamEventErrorOccurred:
        {
        //    if (stream == iStream)
		//	{
                ACLog(@"iStream ErrorOccurred");
               [delegate ACSocketDelegateDidError];
                [self disconnect];
		//	}	
		} break;
			
		case NSStreamEventOpenCompleted:
        {
            if(stream == iStream)
            {
                ACLog(@"iStream OpenCompleted");
                [delegate ACSocketDelegateDidOpen]; 
            } 
		} break;
            
        case NSStreamEventNone:
        {
            ACLog(@"EventNone");
        } break;
        case NSStreamEventHasSpaceAvailable:
        {
            ACLog(@"HasSpaceAvailable");
        } break;
		
    }
    
    /*
     
     //	NSLog(@"[ACSocket.m]%@",stream);
     
     switch(eventCode) {
     case NSStreamEventHasBytesAvailable:
     {
     ACLog(@"HasBytesAvailable");
     
     if (stream == iStream)
     {
     [self handleInputStream];
     }	
     } break;
     
     case NSStreamEventNone:
     {
     ACLog(@"EventNone");
     } break;
     
     case NSStreamEventErrorOccurred:
     {
     ACLog(@"ErrorOccurred");
     [delegate ACSocketDelegateDidError];
     delegate=nil;
     } break;
     
     case NSStreamEventEndEncountered:
     {
     ACLog(@"EndEncountered");
     } break;
     
     case NSStreamEventOpenCompleted:
     {
     ACLog(@"OpenCompleted");
     
     if(stream == iStream)
     {
     [delegate ACSocketDelegateDidOpen]; 
     } 
     } break;
     case NSStreamEventHasSpaceAvailable:
     {
     ACLog(@"HasSpaceAvailable");
     } break;
     }

     
     */
}

@end
