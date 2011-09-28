//
//  ACTabBarController.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACTabBarController.h"


@implementation ACTabBarController

- (void)hideExistingTabBar
{
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
			view.hidden = YES;
			break;
		}
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
//	[self hideExistingTabBar];
}

@end
