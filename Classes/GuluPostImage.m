//
//  GuluPostImage.m
//  GULUAPP
//
//  Created by alan on 11/9/1.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluPostImage.h"
#import "API_URL_POST.h"

@implementation GuluPostImage

@synthesize photo;

- (id)initWithPhoto:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.photo=image;
    }
    
    return self;
}

- (void)startSubmitPhoto
{
    NSData *data= UIImageJPEGRepresentation(photo, 0.5);
        
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:data forKey:@"uploadedfile"];
    [self createRequest:URL_POST_UPLOAD_PHOTO info:dict];
    [self startRequest];
}

- (void)dealloc
{
    [photo release];
    [super dealloc];
}



@end
