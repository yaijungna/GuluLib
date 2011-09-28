//
//  loadingSpinnerAndMessageView.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/30.
//  Copyright 2011 Gulu.com. All rights reserved.
//
/*
 How to use
 
 loadingSpinnerAndMessageView *loadingview=[[loadingSpinnerAndMessageView alloc] init];
 CGSize frameSize=[loadingview setMessageAndAdjustFrameSizeToFitMessage:nil frameSize:CGSizeMake(self.view.frame.size.width,200)];
 loadingview.frame=CGRectMake(self.view.center.x-frameSize.width/2, self.view.center.y-frameSize.height/2, frameSize.width, frameSize.height);	
 [self.view addSubview:loadingview];

 */



#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


@interface loadingSpinnerAndMessageView : UIView {
	UIImageView *backGroundImgView;
	UIActivityIndicatorView *loadingSpinner;
	UILabel *loadingLabel;
}

-(CGSize ) setMessageAndAdjustFrameSizeToFitMessage:(NSString*) message_string frameSize:(CGSize) maxSize;

@end
