//
//  ChatTextFieldView.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/21.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ChatTextFieldView.h"


@implementation ChatTextFieldView


@synthesize addButton , chatTextField;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) 
	{
		UIImageView *bg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)];
		[self addSubview: bg];
		[bg release];
		bg.image=[UIImage imageNamed:@"large-list-box-1.png"];
		
	/*	addButton =[[UIButton alloc] initWithFrame:CGRectMake(10, 12, 30, 30)];
		[self addSubview: addButton];
		[addButton release];
		[addButton setBackgroundImage:[UIImage imageNamed:@"inactive-add-icon-1.png"] forState:UIControlStateNormal ];
	*/	
	//	chatTextField= [[UITextField alloc] initWithFrame:CGRectMake(50, 10, 260, 34)];
		chatTextField= [[UITextField alloc] initWithFrame:CGRectMake(10, 3, 300, 34)];
		[self addSubview:chatTextField];
		[chatTextField release];
	
    }
    return self;
}


- (void)dealloc {
    [super dealloc];
}


@end
