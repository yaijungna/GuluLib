//
//  CustomPagingScrollViewContoller.h
//  guluapp
//
//  Created by chen alan on 2011/5/2.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACPagableScrollView.h"



@interface CustomPagingScrollViewContoller : UIViewController <UIScrollViewDelegate,ACPagableScrollViewDelegate>{
	ACPagableScrollView *pageView;
}


@end



