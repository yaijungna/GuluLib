//
//  UIViewControllerAddtion.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "UIViewControllerAddtion.h"
#import "API_URL_FAVORITE.h"
#import "mapViewController.h"
#import "GuluMapViewController.h"

@implementation UIViewController(MyAdditions_moreview)

-(void)gotoMap:(GuluPlaceModel *)place
{
    /*
	mapViewController *VC=[[mapViewController alloc] initWithNibName:@"mapViewController" bundle:nil];	
	VC.place=place;
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];
    */
    GuluMapViewController *VC=[[GuluMapViewController alloc] init];	
	VC.place=place;
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];
}


@end
