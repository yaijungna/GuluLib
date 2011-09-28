//
//  ACPagableScrollView.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol ACPagableScrollViewDelegate

-(NSInteger ) ACPagableScrollViewNumberOfPage;
-(NSInteger ) ACPagableScrollViewStartAtIndex;
-(void) ACPagableScrollViewAtIndexOfScrollView : (id)viewAtIndex currentIndex:(NSInteger)index;
-(NSString *) ACPagableScrollViewClassOfView;

@end


@interface ACPagableScrollView : UIScrollView  <UIScrollViewDelegate>{
	id <ACPagableScrollViewDelegate> ACDelegate;
	id viewLeft;
	id viewMiddle;
	id viewRight;
	NSMutableArray *Array;
	NSInteger currentIndex;
	NSInteger lastIndex;
}
@property (nonatomic,retain) id <ACPagableScrollViewDelegate> ACDelegate;
@property (nonatomic,retain) id viewLeft;
@property (nonatomic,retain) id viewMiddle;
@property (nonatomic,retain) id viewRight;

-(void)initScrollView;
-(void)resetFrame :(NSInteger)page;
-(int) getCurrentPage;
-(void)gotoCurrentPage : (NSInteger) index;

@end
