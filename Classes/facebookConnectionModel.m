//
//  facebookConnectionModel.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/14.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "facebookConnectionModel.h"


@implementation facebookConnectionModel

@synthesize fbToken;
@synthesize urlString;
@synthesize delegate;


- (void)dealloc {
	[fbToken release];
	[urlString release];
	[network release];
    [super dealloc];
}


#pragma mark -
#pragma mark facebook Function Methods


- (void) getFBRandomToken
{
	network=[[ACNetworkManager alloc] init];
	
	//NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	
	ASIFormDataRequest *request= [network createNewRequest:URL_USER_FACEBOOK_GET_TOKEN
									keyValueDictionary:nil 
									 addtionDictionary:nil];
	//[dict release];
	[request setRequestMethod:@"POST"];
	request.delegate=self;
	[request setDidFinishSelector:@selector(getFBRandomTokenSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[network addRequestToRequestsQueue:request];
}


- (void) getFBRandomTokenSuccess:(ASIFormDataRequest *)request
{
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	NSDictionary *tempDict = [djsonDeserializer deserializeAsDictionary:data1 error:&derror];
	
	if(tempDict==nil || [tempDict isEqual:[NSNull null]] || [tempDict count]==0 )
	{
		[delegate facebookGetTokenFail];
		return;
	}
	else if([tempDict objectForKey:@"errorMessage"])
	{
		[delegate facebookGetTokenFail];
		return;
	}
	else
	{
		self.fbToken =[[[NSString alloc] initWithString:[tempDict objectForKey:@"fb_token"]] autorelease];
		self.urlString=[NSString stringWithFormat:@"%@?fb_token=%@",URL_USER_FACEBOOK_CONNECT_WEB,fbToken];
		[delegate facebookGetTokenSuccess];
	}
}

-(void) ACConnectionFailed:(ASIFormDataRequest *)request
{
	[delegate facebookGetTokenFail];
}

-(void) cancelGetFBRandomToken
{
	[network cancelAllRequestsInRequestsQueue];
}


@end
