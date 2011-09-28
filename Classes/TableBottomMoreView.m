//
//  TableBottomMoreView.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/30.
//  Copyright 2011 Gulu.com. All rights reserved.
//


/*

 how to use:
 
 TableBottomMoreView *bottomview=[[TableBottomMoreView alloc] initWithFrame:CGRectMake(0, 0, table.frame.size.width, 40)];
 table.tableFooterView=bottomview;
 [bottomview autorelease];

 */

#import "TableBottomMoreView.h"


@implementation TableBottomMoreView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		[self setBackgroundColor:[UIColor clearColor]];		
		
		backGroundImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
		[self addSubview:backGroundImgView];
		[backGroundImgView release];
		
		tableLoadingMoreSpinner=[[UIActivityIndicatorView alloc] init];
		[tableLoadingMoreSpinner setHidesWhenStopped:YES];
		[tableLoadingMoreSpinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
		tableLoadingMoreSpinner.frame=CGRectMake(self.frame.size.width/2-18,4,36,36);
		[self addSubview:tableLoadingMoreSpinner];
		[tableLoadingMoreSpinner release];
		[tableLoadingMoreSpinner startAnimating];

    }
    return self;
}



@end
