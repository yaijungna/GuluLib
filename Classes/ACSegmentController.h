//
//  ACSegmentController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/1.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppSettings.h"

@protocol ACSegmentControllerDelegate

@optional
- (void) touchSegmentAtIndex:(NSInteger)segmentIndex;

@end


@interface ACSegmentController : UIView {
	NSMutableArray *btnArray;
	UIImage *normalImage;
	UIImage *selectedImage;
	NSInteger selectIndex;
	id <ACSegmentControllerDelegate> delegate;
}

@property (nonatomic,assign) id <ACSegmentControllerDelegate> delegate;
@property (nonatomic,retain) UIImage *normalImage;
@property (nonatomic,retain) UIImage *selectedImage;



-(void) initCustomSegment:(NSArray *)titleArray
			  normalimage:(UIImage *)normalImg
			selectedimage:(UIImage *)selectedImg
				 textfont:(UIFont *)font;
				 
-(void) setSelectedButtonAtIndex:(NSInteger)index;

@end