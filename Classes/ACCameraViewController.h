//
//  ACCameraViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h> 
#import "ACCameraView.h"

@protocol ACCameraViewControllerDelegate

- (void)ACCameraViewControllerDelegateDidFinishPickingImage:(UIImage *)image;
- (void)ACCameraViewControllerDelegateCancelImagePicker;

@end

@interface ACCameraViewController : UIImagePickerController <UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
	id<ACCameraViewControllerDelegate> ACDelegate;
	ACCameraView *cameraControlLayout;
}

+ (id)sharedManager;

-(void)changeToLibraryMode;
-(void)changeToCameraMode;

@property(nonatomic,assign) id <ACCameraViewControllerDelegate> ACDelegate;

@end
