//
//  imageLoader.m
//
//  Created by chen alan on 2011/5/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACImageLoader.h"

@implementation ACImageLoader

@synthesize delegate;
@synthesize activeDownload;
@synthesize imageConnection;
@synthesize image;
@synthesize URLStr;
@synthesize indexPath;
@synthesize tagString;
@synthesize tag;
@synthesize table;

#pragma mark

- (void)dealloc
{
    
    delegate=nil;
    [self cancelDownload];
    
    
    [activeDownload release];
	
    [imageConnection cancel];
    [imageConnection release];
	
	[image release];
	[URLStr release];
	[indexPath release];
	[tagString release];
    
    [table release];
    
    
    [super dealloc];
}

- (void)startDownload
{
	if(isStart)
		return;
	isStart=YES;
	
    self.activeDownload = [NSMutableData data];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:
                             [NSURLRequest requestWithURL:
                              [NSURL URLWithString:URLStr]] delegate:self];
    self.imageConnection = conn;
    [conn release];
}

- (void)cancelDownload
{
    [self.imageConnection cancel];
    self.imageConnection = nil;
    self.activeDownload = nil;
}


#pragma mark -
#pragma mark Download support (NSURLConnectionDelegate)

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.activeDownload appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.activeDownload = nil;
    self.imageConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *imageTemp = [[[UIImage alloc] initWithData:self.activeDownload] autorelease];
    
	self.image=imageTemp;
    self.activeDownload = nil;
   // [image release];
    
    self.imageConnection = nil;
	
	[delegate ACImageDidLoad:self];
}

@end

