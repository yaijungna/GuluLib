//
//  GuluGeneralHTTPClient.m
//  GULUAPP
//
//  Created by alan on 11/8/31.
//  Copyright 2011年 gulu.com. All rights reserved.
//



#import "GuluGeneralHTTPClient.h"

@implementation GuluGeneralHTTPClient

@synthesize delegate;
@synthesize isRequestRuinning;
@synthesize returnObject;
@synthesize request;
@synthesize tagString;
@synthesize tag;
@synthesize tagIndexPath;
@synthesize tagObject;

@synthesize target,finishSelector,failSelector;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    delegate=nil;
    [self cancelRequest];
    self.returnObject=nil;
    self.tagString=nil;
    self.tagIndexPath=nil;
    self.tagObject=nil;
    [super dealloc];
}

-(void)createRequest :(NSString *)URLStr info:(NSMutableDictionary *)dict
{
    [self cancelRequest];
    self.request = [self makeRequest:URLStr];
    
    NSArray *keys=[dict allKeys];
	for(NSString *key in keys)
    {
		id valueObj=[dict objectForKey:key];
        
        if([valueObj isKindOfClass:[NSData class]])
        {
            NSString *filename=[NSString stringWithFormat:@"%d",[NSDate date]];
            NSString *namestring=[NSString stringWithFormat:@"app%u.jpg",[filename hash]];
            [request setData:valueObj withFileName:namestring andContentType:@"image/jpeg" forKey:key];
            [dict removeObjectForKey:key];
            break;
        }
    }
    
    [self prepareWithRequest:request keyValueInfo:dict];
}

-(void)startRequest
{
    isRequestRuinning=YES;
    [request startAsynchronous];
}

-(void)cancelRequest 
{
    isRequestRuinning=NO;
    request.delegate=nil;
    [request cancel];
    self.request=nil;
}

- (void)requestFinished:(id)object
{
    isRequestRuinning=NO;
    self.returnObject=object;
    if([delegate respondsToSelector:@selector(GuluGeneralHTTPClientSuccessed:info:)])
    {
        [delegate GuluGeneralHTTPClientSuccessed:[self autorelease] info:object];
    }
}

- (void)requestFinishedFailed:(NSError*)error
{
    isRequestRuinning=NO;
    if([delegate respondsToSelector:@selector(GuluGeneralHTTPClientFailed:error:)])
    {
        [delegate GuluGeneralHTTPClientFailed:[self autorelease] error:(NSError*)error];
    }
}



@end
