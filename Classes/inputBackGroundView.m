//
//  inputBackGroundView.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/13.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "inputBackGroundView.h"

@implementation inputBackGroundView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        bg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		bg.image=[ACUtility createRoundedRectImage:[UIImage imageNamed:@"large-input-bg.png"] size:CGSizeMake(frame.size.width, frame.size.height)];
		[self addSubview:bg];
		bg.alpha=0.7;
		
    }
    return self;
}
- (void)dealloc {
	[bg release];
    [super dealloc];
}


@end
