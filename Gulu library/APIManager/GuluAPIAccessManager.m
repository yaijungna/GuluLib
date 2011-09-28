//
//  GuluAPIAccessManager.m
//  GULUAPP
//
//  Created by alan on 11/9/7.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluAPIAccessManager.h"

@implementation GuluAPIAccessManager

@synthesize sessionKey;
@synthesize uid;
@synthesize latitude;
@synthesize longitude;
@synthesize errorModel;

static id shared_API = nil;

+ (id)sharedManager {
	@synchronized(self){
        if(shared_API == nil){
            shared_API = [[super alloc] init];
		}
    }
    return shared_API;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)dealloc
{
    self.sessionKey=nil;
    self.uid=nil;
    self.errorModel=nil;
    [super dealloc];
}


#pragma mark -
#pragma mark function

- (void)initUserIDandSeesionKey:(NSString *)userID sessionKey:(NSString *)session lat:(float)lat lng:(float)lng
{
    self.uid=userID;
    self.sessionKey=session;
    self.latitude=lat;
    self.longitude=lng;
}

-(GuluHttpRequest *)createNewGuluRequestWithURL:(NSString *)URL 
                                         target:(id)target;
{
    NSURL *reqURL = [NSURL URLWithString:URL];
    
    GuluHttpRequest *Request=[GuluHttpRequest requestWithURL:reqURL] ;
    Request.guluTarget=target;
    
    [Request setTimeOutSeconds:60];
    [Request setAllowCompressedResponse:YES];
	[Request setShowAccurateProgress:YES]; 
	[Request setShouldAttemptPersistentConnection:NO];
    
    //==== auth data====
    [Request setPostValue:[NSString stringWithFormat:@"%f",latitude] forKey:@"lat"];
    [Request setPostValue:[NSString stringWithFormat:@"%f",longitude] forKey:@"lng"];
    [Request setPostValue:sessionKey forKey:@"session_key"];
    [Request setPostValue:uid forKey:@"uid"];
    //==================
    
    if(!uid || !sessionKey ){
        NSLog(@"UID and SessionKey are missing.\nPlease call initUserIDandSeesionKey to initialize fixedDataDictionary.");}
    
    return Request;
}

- (void)setupRequestWithData:(GuluHttpRequest*)Request  keyValueInfo:(NSMutableDictionary*)dict
{
    NSArray *keys=[dict allKeys];
    
	for(NSString *key in keys)
    {
		id valueObj=[dict objectForKey:key];
        
        if([valueObj isKindOfClass:[NSData class]])
        {
            NSString *filename=[NSString stringWithFormat:@"%d",[NSDate date]];
            NSString *namestring=[NSString stringWithFormat:@"app%u.jpg",[filename hash]];
            [Request setData:valueObj withFileName:namestring andContentType:@"image/jpeg" forKey:key];
        }
        else
        {
            [Request setPostValue:valueObj forKey:key];
        }
    }
}

- (id)decodeJSONFromGuluRequest:(GuluHttpRequest*)Request
{
    NSData *data= [Request responseData];
    NSError *derror;
    CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
    id temp=[jsonDeserializer deserialize:data error:&derror];
    
	if( temp ==nil || [temp isEqual:[NSNull null]])
	{
        NSString *webCrashLog=[[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
        ACLog(@"Web Crash: %@",webCrashLog);
        
        temp=nil;
	}
    
    if([temp isKindOfClass:[NSString class]])
    {
        ACLog(@"Web Error: %@",temp);
        temp=nil;
    }
    if([temp isKindOfClass:[NSDictionary class]])
    {
        if([temp objectForKey:@"errorMessage"])
        {
            self.errorModel=[[[GuluErrorMessageModel alloc] init] autorelease];
            [errorModel switchDataIntoModel: temp];
            temp=nil;
        }
    }
    
    return  temp;
}


- (void)APIRequestFinish:(GuluHttpRequest*)httpRequest returnData:(id)data
{
    id guluTarget=httpRequest.guluTarget;
    
    if([guluTarget respondsToSelector:@selector(GuluAPIAccessManagerSuccessed:info:)])
    {
        if(errorModel){
             [guluTarget GuluAPIAccessManagerSuccessed:httpRequest info:errorModel];
        }
        else{
            [guluTarget GuluAPIAccessManagerSuccessed:httpRequest info:data];
        }
    }
    
    self.errorModel=nil;
}

- (void)APIRequestFail:(GuluHttpRequest*)httpRequest returnData:(id)data
{
    NSError *error=[httpRequest error];
    ACLog(@"%@",error);
    
    id guluTarget=httpRequest.guluTarget;
    
    if([guluTarget respondsToSelector:@selector(GuluAPIAccessManagerFailed:info:)])
    {
        [guluTarget GuluAPIAccessManagerFailed:httpRequest info:data];
    }
}


@end
