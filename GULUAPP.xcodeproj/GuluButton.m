//
//  GuluButton.m
//  GULUAPP
//
//  Created by alan on 11/9/27.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluButton.h"

@implementation GuluButton

@synthesize indexPath;

- (void)dealloc {
	[indexPath release];
    [super dealloc];
}

@end
