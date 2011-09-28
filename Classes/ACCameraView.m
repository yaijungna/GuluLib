//
//  ACCameraView.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/30.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACCameraView.h"

@implementation ACCameraView

@synthesize cameraFlashButton, cameraFrontRearButton;
@synthesize topView, bottomView;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		[self setBackgroundColor:[UIColor clearColor]];
		
		cameraFlashButton=[[UIButton alloc] initWithFrame:CGRectMake(15, 60, 25, 35)];
		cameraFrontRearButton=[[UIButton alloc] initWithFrame:CGRectMake(245, 60, 60, 35)];
		topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
		bottomView=[[[BottomMenuBarView alloc] initWithFrame:CGRectMake(0, 430, 320, 50)] initCameraBottomBarView:ButtonTypePhotoAlbum second:ButtonTypeTakePicture];
		
		UIImageView *camerabg=[[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
		camerabg.image=[UIImage imageNamed:@"Camera-cut-out-BG.png"];
		
		[self addSubview:camerabg];
		[self addSubview:cameraFlashButton];
		[self addSubview:cameraFrontRearButton];
		[self addSubview:topView];
		[self addSubview:bottomView];
		
				
		[cameraFlashButton setBackgroundImage:[UIImage imageNamed:@"inactive-flash-icon.png"] forState:UIControlStateNormal];
		[cameraFrontRearButton setBackgroundImage:[UIImage imageNamed:@"inactive-camera-flip-icon.png"] forState:UIControlStateNormal];
    
	}
    return self;
}


- (void)dealloc {
	[cameraFlashButton release];
    [cameraFrontRearButton release];
    [topView release];
    [bottomView release];
    // GMC		[camerabg release];
	
    [super dealloc];
}


@end
