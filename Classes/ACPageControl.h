//
//  ACPageControl.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//
/*
 How to use
 
 IBOutlet ACPageControl *pageController;
 pageController.numberOfPages=5;	
 pageController.currentPage=0;
 [pageController updateDots];
 


*/

#import <Foundation/Foundation.h>


@interface ACPageControl : UIPageControl {
	UIImage* mImageNormal;
	UIImage* mImageCurrent;
}

- (void) updateDots;

@property (nonatomic, retain) UIImage* mImageNormal;
@property (nonatomic, retain) UIImage* mImageCurrent;

@end