//
//  oneLineTableHeaderView.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/21.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "oneLineTableHeaderView.h"


@implementation oneLineTableHeaderView


@synthesize bg;
@synthesize label1;
@synthesize rightBtn;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) 
	{
		bg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		[self addSubview:bg];
		bg.image=[UIImage imageNamed:@"more-list-box-1.png"];
        bg.alpha=0.8;
		
		label1=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width-20, frame.size.height)];
		[self addSubview:label1];
    }
    return self;
}

- (void)dealloc {
	[bg release];
	[label1 release];
	[rightBtn release];
    [super dealloc];
}


@end
