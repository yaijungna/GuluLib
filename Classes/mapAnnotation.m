//
//  mapAnnotation.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/15.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "mapAnnotation.h"


@implementation mapAnnotation

@synthesize theCoordinate;
@synthesize title;
@synthesize subtitle;

- (CLLocationCoordinate2D)coordinate;
{
    return theCoordinate; 
}

- (NSString *)title
{
    return title;
}

- (NSString *)subtitle
{
    return subtitle;
}

- (void)dealloc
{
	[title release];
	title=nil;
	[subtitle release];
	subtitle=nil;
	
    [super dealloc];
}


@end
