//
//  ACButtonWIthButtomTitle.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACButtonWIthBottomTitle.h"
#import "AppSettings.h"

@implementation ACButtonWIthBottomTitle

@synthesize btn;
@synthesize btnTitleLabel;
@synthesize imgView;
@synthesize hightlightImage;
@synthesize normalImage;


- (void)dealloc {
	[btn release];
	[btnTitleLabel release];
	[imgView release];
	[hightlightImage release];
	[normalImage release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)Frame
{
	if(self=[super initWithFrame:Frame])
	{
		CGSize size=Frame.size;
		
		self.btn=[[[UIButton alloc] init] autorelease];
		self.imgView=[[[UIImageView alloc] init] autorelease];
		self.btnTitleLabel=[[[UILabel alloc] init] autorelease];
		
		[btn setFrame:CGRectMake(0, 0, size.width, size.height)];
		[imgView setFrame:CGRectMake(0, 0, size.width, size.height*3/4)];
		[btnTitleLabel setFrame:CGRectMake(0, size.height*3/4, size.width, size.height*1/4)];
		
		[self addSubview:imgView];
		[self addSubview:btnTitleLabel];
		[self addSubview:btn];
		
		//[imgView release];
		//[btnTitleLabel release];
		//[btn release];
		
		[btnTitleLabel setTextAlignment:UITextAlignmentCenter];
		btnTitleLabel.backgroundColor=[UIColor clearColor];
		
	//	[btn setBackgroundImage:[UIImage imageNamed:@"mask.png"] forState:UIControlStateHighlighted];
		[btn addTarget:self action:@selector(changeBackgroundImageTohightlight) forControlEvents:UIControlEventTouchDown];
		[btn addTarget:self action:@selector(changeBackgroundImageToNormal) forControlEvents:UIControlEventTouchUpInside];
		[btn addTarget:self action:@selector(changeBackgroundImageToNormal) forControlEvents:UIControlEventTouchUpOutside];
	//	btn.alpha=0.1;
	}
	
	return self;
}

- (void)setImageViewSize :(CGSize)imageSize
{	
	[imgView setFrame:CGRectMake(self.frame.size.width/2-imageSize.width/2, 5, imageSize.width, imageSize.height)];
	[btnTitleLabel setFrame:CGRectMake(0 ,self.frame.size.height-15,self.frame.size.width ,15)];
}

- (void)changeBackgroundImageTohightlight
{	
	imgView.image=hightlightImage;
    [btnTitleLabel setTextColor:[UIColor whiteColor]];
}

- (void)changeBackgroundImageToNormal
{	
	imgView.image=normalImage;
    [btnTitleLabel setTextColor:lightBrownColor];
}

- (void)changeBackgroundImageToSelect
{	
	if(btn.selected)
	{
		btn.selected=NO;
		imgView.image=normalImage;
	}
	else 
	{
		btn.selected=YES;
		imgView.image=hightlightImage;
	}
}

- (void)changeBackgroundImageTohightlight2
{	
	imgView.image=hightlightImage;
}

- (void)changeBackgroundImageToNormal2
{	
	imgView.image=normalImage;
}



@end
