//
//  PostLandingViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/7.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACCameraViewController.h"
#import "UIViewControllerAddtion.h"


@interface PostLandingViewController : UIViewController<ACCameraViewControllerDelegate> {
	ACCameraViewController *imagePicker;
	TopMenuBarView *topView;
	BottomMenuBarView *bottomView;

}

- (IBAction)gotoCamera;
- (IBAction)gotoPostWithoutCamera;

@end
