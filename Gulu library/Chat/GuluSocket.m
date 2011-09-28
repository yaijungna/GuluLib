//
//  GuluSocket.m
//  GULUAPP
//
//  Created by alan on 11/9/14.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluSocket.h"

@implementation GuluSocket

@synthesize messageID;
@synthesize data;

@synthesize iStream,oStream;
@synthesize delegate;

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


-(void) connectToServerUsingStream:(NSString *)urlStr 
                            portNo: (uint) portNo 
{	
    if (![urlStr isEqualToString:@""]) 
	{
        NSURL *website = [NSURL URLWithString:urlStr];
        if (!website) 
		{
            return;
        } 
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

-(void) disconnect {
    [iStream close];
    [oStream close];
}

-(void) writeToOutputStream:(NSMutableData *) messageData
{	
	const uint8_t *buf = [messageData mutableBytes]  ;
	NSInteger length=[messageData length];
    
	int len=[oStream write:buf maxLength:length];   
    
	if (len > 0){
		ACLog(@"Send message to chat server successfully");}
}

-(void) writeDataToServer:(NSMutableData *) messageData
{
	messageID++; 
	    
    NSOperationQueue *someQueue = [NSOperationQueue mainQueue];
    NSInvocationOperation *invocationOp1 = [[NSInvocationOperation alloc]  initWithTarget:self
                                                                                 selector:@selector(writeToOutputStream:)
                                                                                   object:messageData] ;
    [someQueue addOperation:invocationOp1]; 
    [invocationOp1 release];
}


#pragma mark -

-(NSInteger) calculateLenthOfData :(NSData *)theData
{
    NSRange range = NSMakeRange(0,4);
    NSData *subData = [theData subdataWithRange:range];
    
    uint32_t  *datalength = malloc(1);
    [subData getBytes:datalength length:4];
    uint32_t   theLength= NSSwapBigIntToHost(datalength[0]);
    free(datalength);
    
    return  theLength;
}

-(void) handleInputStream
{
    while ([iStream hasBytesAvailable])
	{
        NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
        
        uint8_t buffer[32768];
        int iStreamlength;
        
        iStreamlength=[iStream read:buffer maxLength:sizeof(buffer)];
        
        if(iStreamlength <=0) {
            ACLog(@"No data to send in iStream.");
            return;
        }  
        
        NSMutableData *append=[NSMutableData dataWithBytes:buffer length:iStreamlength] ;
        [data appendData:append];
        NSInteger messageLength=[self calculateLenthOfData:data];
        
        NSLog(@"messageLength = %d",messageLength);
        NSLog(@"[data length] = %d",[data length]);
        
        
        while ([data length] >= messageLength  )
        {
            NSRange range = NSMakeRange(4,messageLength);
            NSMutableData *newData=[NSMutableData dataWithData:[data subdataWithRange:range]] ;
            
            NSError *derror;
            CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
            NSDictionary *tempDict = [djsonDeserializer deserializeAsDictionary:newData error:&derror];
            NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:tempDict];
            
            [delegate GuluSocketDelegateDidFinishReciveData:dict];
            [data replaceBytesInRange:NSMakeRange(0, 4+messageLength) withBytes:nil length:0];
            
            if([data length]>=4){
                messageLength=[self calculateLenthOfData:data];
                
                NSLog(@" After messageLength = %d",messageLength);
                NSLog(@" After [data length] = %d",[data length]);
            }
        }
        
        [pool drain];
    }
}	

/*
 * NSStreamEventNone -- No event has occurred.
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
			if (stream == iStream){
        //        ACLog(@"HasBytesAvailable");
				[self handleInputStream];
			}	
		} break;
			
		case NSStreamEventNone:
        {
			ACLog(@"EventNone");
		} break;
			
		case NSStreamEventErrorOccurred:
        {
            if(stream == iStream){
                ACLog(@"ErrorOccurred");
                [delegate GuluSocketDelegateDidConnectError];
            }
		} break;
			
		case NSStreamEventEndEncountered:
        {
			ACLog(@"EndEncountered");
		} break;
			
		case NSStreamEventOpenCompleted:
        {
            if(stream == iStream){
                ACLog(@"OpenCompleted");       
                [delegate GuluSocketDelegateDidConnectOpen];
            } 
		} break;
		case NSStreamEventHasSpaceAvailable:
        {
		//	ACLog(@"HasSpaceAvailable");
		} break;
    }
}
@end
    
    
