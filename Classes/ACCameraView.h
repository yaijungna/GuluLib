//
//  ACCameraView.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/30.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopMenuBarView.h"
#import "BottomMenuBarView.h"

@interface ACCameraView : UIView {
	UIButton *cameraFlashButton;
	UIButton *cameraFrontRearButton;
	
	TopMenuBarView *topView;
	BottomMenuBarView *bottomView;
}

@property (nonatomic ,retain) UIButton *cameraFlashButton;
@property (nonatomic ,retain) UIButton *cameraFrontRearButton;
@property (nonatomic ,retain) TopMenuBarView *topView;
@property (nonatomic ,retain) BottomMenuBarView *bottomView;

@end
