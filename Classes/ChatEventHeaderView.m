//
//  ChatEventHeaderView.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChatEventHeaderView.h"


@implementation ChatEventHeaderView

@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize rightBtn;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) 
	{
		UIImageView *bg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		[self addSubview: bg];
		[bg release];
		bg.image=[UIImage imageNamed:@"chat-header-1.png"];
		
		self.label1=[[[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width-20, 25)] autorelease];
		self.label2=[[[UILabel alloc] initWithFrame:CGRectMake(10, 25, frame.size.width-20, 25)] autorelease];
		self.label3=[[[UILabel alloc] initWithFrame:CGRectMake(10, 50, frame.size.width-20, 25)] autorelease];
		self.rightBtn=[ACCreateButtonClass createButton:ButtonTypeGuestsList];
		[rightBtn setFrame:CGRectMake(320-rightBtn.frame.size.width, 10, rightBtn.frame.size.width, rightBtn.frame.size.height)];

		
		[self addSubview:label1];
		[self addSubview:label2];
		[self addSubview:label3];
		[self addSubview:rightBtn];
		
		
	}
    return self;
}

- (void)dealloc {
	[label1 release];
	[label2 release];
	[label3 release];
	[rightBtn release];
	
    [super dealloc];
}


@end
