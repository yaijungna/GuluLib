//
//  GuluAnnotation.m
//  GULUAPP
//
//  Created by alan on 11/9/27.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluAnnotation.h"

@implementation GuluAnnotation

@synthesize theCoordinate;
@synthesize title;
@synthesize subtitle;

- (CLLocationCoordinate2D)coordinate;{
    return theCoordinate; 
}

- (NSString *)title{
    return title;
}

- (NSString *)subtitle{
    return subtitle;
}

- (void)dealloc
{
	[title release];
	[subtitle release];
	
    [super dealloc];
}


@end
