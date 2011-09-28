//
//  FriendHeaderView.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/20.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "FriendHeaderView.h"


@implementation FriendHeaderView

@synthesize btn1;
@synthesize btn2;
@synthesize btn3;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		UIImageView *bgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width ,frame.size.height)];
		[self addSubview:bgView];
		[bgView release];
		bgView.image=[UIImage imageNamed:@"large-list-box-1.png"];
			
		self.backgroundColor=[UIColor clearColor];
		
	
		self.btn1=[ACCreateButtonClass createButton:ButtonTypeAddFriends];
		[btn1 setFrame:CGRectMake(frame.size.width/2-btn1.frame.size.width/2, 7, btn1.frame.size.width, btn1.frame.size.height)];
		[self addSubview:btn1];
        
        [btn1.btnTitleLabel setTextColor:darkBrownColor];
		
    }
    return self;
}

- (void)dealloc {
	[btn1 release];
	[btn2 release];
	[btn3 release];
    [super dealloc];
}

@end
