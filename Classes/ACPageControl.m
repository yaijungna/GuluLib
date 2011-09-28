//
//  ACPageControl.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACPageControl.h"

@implementation ACPageControl

@synthesize mImageNormal;
@synthesize mImageCurrent;

- (void) dealloc
{
	[mImageNormal release];
	[mImageCurrent release];
	[super dealloc];
}


/** override to update dots */
- (void) setCurrentPage:(NSInteger)currentPage
{
	[super setCurrentPage:currentPage];
	
	// update dot views
	[self updateDots];
}

/** override to update dots */
- (void) updateCurrentPageDisplay
{
	[super updateCurrentPageDisplay];
	
	// update dot views
	[self updateDots];
}

/** Override setImageNormal */
- (void) setImageNormal:(UIImage*)image
{
	[mImageNormal release];
	mImageNormal = [image retain];
	
	// update dot views
	[self updateDots];
}

/** Override setImageCurrent */
- (void) setImageCurrent:(UIImage*)image
{
	[mImageCurrent release];
	mImageCurrent = [image retain];
	
	// update dot views
	[self updateDots];
}

/** Override to fix when dots are directly clicked */
- (void) endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event 
{
	[super endTrackingWithTouch:touch withEvent:event];
	
	[self updateDots];
}

#pragma mark - (Private)

- (void) updateDots
{
	if(!mImageCurrent ){
		self.mImageCurrent =[UIImage imageNamed:@"selected-bubble-1.png"]; }
	
	if( !mImageNormal){
		self.mImageNormal =[UIImage imageNamed:@"unselected-bubble-1.png"]; }
	
	NSArray* dotViews = self.subviews;
	for(int i = 0; i < dotViews.count; ++i)
	{
		UIImageView* dot = [dotViews objectAtIndex:i];
		[dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, 15,15)];
		// Set image
		dot.image = (i == self.currentPage) ? mImageCurrent : mImageNormal;
	}
	
	
}

@end