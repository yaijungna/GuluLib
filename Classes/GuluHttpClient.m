//
//  GuluHttpClient.m
//  GULUAPP
//
//  Created by alan on 11/8/31.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluHttpClient.h"

@implementation GuluHttpClient

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

/*
-(ASIFormDataRequest *)makeRequest:(NSString *)URL
{
    NSURL *reqURL = [NSURL URLWithString:URL];
    ASIFormDataRequest *Request = [ASIFormDataRequest requestWithURL:reqURL];
    
 // [Request setTimeOutSeconds:30];
    [Request setDelegate:self];
    [Request setAllowCompressedResponse:YES];
	[Request setShowAccurateProgress:YES]; 
	[Request setShouldAttemptPersistentConnection:NO];
    [Request setDidFinishSelector:@selector(requestSucceeded:) ];
    [Request setDidFailSelector:@selector(requestFailed:)];
    return  Request;
}

- (void)prepareWithRequest:(ASIFormDataRequest*)Request  keyValueInfo:(NSMutableDictionary*)dict
{
    NSArray *keys=[dict allKeys];
	for(NSString *key in keys)
    {
		id valueObj=[dict objectForKey:key];
        [Request setPostValue:valueObj forKey:key];
    }
}

- (void)requestFinished:(id)object
{
    // implement by subclass
}

- (void)requestFinishedFailed:(NSError*)error
{
    // implement by subclass
}


- (void)requestSucceeded:(ASIFormDataRequest *)Request
{
    NSData *data= [Request responseData];
    NSError *derror;
    CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
    id temp=[djsonDeserializer deserialize:data error:&derror];
    
//    NSLog(@"%@",temp);
    
	if( temp ==nil || [temp isEqual:[NSNull null]])
	{
        ACLog(@"No Data");
        temp=nil;
        ACLog(@"%@",[[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease]);
	}
    
    if([temp isKindOfClass:[NSString class]])
    {
        ACLog(@"Error: %@",temp);
        temp=nil;
    }
    
    [self requestFinished:temp];
}

- (void)requestFailed:(ASIFormDataRequest *)Request
{
    NSError *error=[Request error];
    ACLog(@"%@",error);
    
    [self requestFinishedFailed:error];
}

 */
- (void)dealloc
{
    [super dealloc];
}



@end
