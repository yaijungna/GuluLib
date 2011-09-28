//
//  TopMenuBarView.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/31.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "TopMenuBarView.h"

@implementation TopMenuBarView

@synthesize topBackgroundImageView,topLeftButton,topMiddleButton,topRightButton;

- (void)dealloc {
	[topBackgroundImageView release];
	[topLeftButton release];
	[topMiddleButton release];
	[topRightButton release];
    [super dealloc];
}

-(id) initTopBarView :(ButtonType)leftType middle:(ButtonType)middleType right:(ButtonType)rightType
{
	[self setBackgroundColor:[UIColor clearColor]];
	
	self.topBackgroundImageView =[[[UIImageView alloc] initWithFrame:self.frame] autorelease];
	topBackgroundImageView.image=[UIImage imageNamed:@"top-bar.png"];
	[self addSubview:topBackgroundImageView];
	
	self.topLeftButton	=[ACCreateButtonClass createButton:leftType];
	self.topMiddleButton=[ACCreateButtonClass createButton:middleType]; 
	//self.topMiddleButton=[[[UIButton alloc] init] autorelease];
	((UIButton *)topMiddleButton).showsTouchWhenHighlighted=YES;
	self.topRightButton	=[ACCreateButtonClass createButton:rightType];
	
	[self addSubview:topLeftButton];
	[self addSubview:topMiddleButton];
	[self addSubview:topRightButton];
	
	//=======================================
	
	CGSize leftSize=((UIView *)topLeftButton).frame.size;
	CGSize middleSize=((UIView *)topMiddleButton).frame.size;
	CGSize rightSize=((UIView *)topRightButton).frame.size;
	
	[topLeftButton		setFrame:CGRectMake(10, self.center.y-leftSize.height/2 , leftSize.width, leftSize.height)];
	[topMiddleButton	setFrame:CGRectMake(self.center.x-middleSize.width/2, self.center.y-middleSize.height/2, middleSize.width, middleSize.height)];
	[topMiddleButton	setFrame:CGRectMake(self.center.x-30, 0 ,60, 50)];
	[topRightButton		setFrame:CGRectMake(self.frame.size.width-10-rightSize.width, self.center.y-rightSize.height/2, rightSize.width, rightSize.height)];
	
	return self;
}


@end
