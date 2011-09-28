//
//  ACSlider.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/9.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACSlider.h"
#import "AppSettings.h"


@implementation ACSlider

@synthesize delegate;

-(void) addBackgroundImage:(CGRect)frame
{
	UIImage *image=[UIImage imageNamed:@"slider-1.png"];
	CGRect rect= CGRectMake(0, 0, frame.size.width,  frame.size.height);
	UIImage *imageNew;
	
	UIGraphicsBeginImageContext(rect.size);
	[image drawInRect:rect];
	imageNew = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	
	UIImageView *imgBg=[[UIImageView alloc] initWithImage:imageNew];
	imgBg.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
	[self addSubview:imgBg];
	[imgBg release];
}

-(void) setupArrow
{
	arrowImageView =[[UIImageView alloc] initWithFrame:CGRectMake(110,self.frame.size.height/2-15, 30, 30)];
	arrowImageView.image = [UIImage imageNamed:@"slider-arrow-1.png"];
	[self addSubview:arrowImageView];	
	[arrowImageView release];
}

-(void) setupLabel
{
	sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(150,0, self.frame.size.width-150-10, self.frame.size.height)] ;
	sliderLabel.textAlignment=UITextAlignmentCenter;
	sliderLabel.backgroundColor=[UIColor clearColor];
	sliderLabel.font=[UIFont fontWithName:FONT_NORMAL size:10];
	sliderLabel.numberOfLines=2;
	sliderLabel.textColor=TEXT_COLOR;
	sliderLabel.text=NSLocalizedString(@"Slide to nominate this place to be \"Gulu Approved\"",@"[sliderbar]");
	[self addSubview:sliderLabel];
	[sliderLabel release];
	
}

-(UIImage *) setupThumbImage
{
	UIImage *image=[UIImage imageNamed:@"gulu-approved-stamp-button-1.png"];
	CGRect rect= CGRectMake(0, 0, 100, 50);
	UIImage *imageNew;
	
	UIGraphicsBeginImageContext(rect.size);
	[image drawInRect:rect];
	imageNew = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return imageNew;
	
}

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) 
	{
		[self addBackgroundImage:frame];
		[self setupArrow];
		[self setupLabel];
		
		self.continuous=YES;
		self.backgroundColor = [UIColor clearColor];	
		UIImage *stetchLeftTrack = [[UIImage imageNamed:@"ClearBackGround.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0];
		UIImage *stetchRightTrack = [[UIImage imageNamed:@"ClearBackGround.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0];
		[self setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
		[self setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
		[self setThumbImage: [self setupThumbImage] forState:UIControlStateNormal];
		self.minimumValue = 0.0;
		self.maximumValue = 1.0;
		self.continuous = NO;
		self.value = 0.02;
		[self addTarget:self action:@selector(sliderAction) forControlEvents:UIControlEventValueChanged];
		[self addTarget:self action:@selector(hideSliderBarLabel) forControlEvents:UIControlEventTouchDown];
		
		
	}
	return self;
}

-(void)hideSliderBarLabel
{
	arrowImageView.hidden=YES;
	sliderLabel.hidden=YES;
}

-(void)showSliderBarLabel
{
	arrowImageView.hidden=NO;
	sliderLabel.hidden=NO;
}

-(void)sliderAction
{	
	
	if (self.value < 0.98)
	{
		[self setValue: 0.02 animated: YES];
		[self showSliderBarLabel];
	}
	else 
	{	
		[self hideSliderBarLabel];
		[self setValue: 0.98 animated: NO];
		[delegate slideToEndAction];
		
	}
}



@end
