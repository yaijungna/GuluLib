//
//  Invite_SearchRestaurantViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchRestaurantViewController.h"
#import "SearchDishViewController.h"


@interface Invite_SearchRestaurantViewController : UIViewController  <SearchRestaurantDelegate>{
	TopMenuBarView *topView;
	BottomMenuBarView *bottomView;
    SearchRestaurantViewController *searchVC;
    //SearchDishViewController *searchVC;
    IBOutlet UIView *myView;
    IBOutlet UITextField *searchTextField;

}

@end
