//
//  gradeDetailView.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/7.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSettings.h"
#import "ACImageLoader.h"
#import "ACCreateButtonClass.h"

@interface gradeDetailView : UIView   <ACImageDownloaderDelegate>{
    UIImageView *PhotoImageView;
	UILabel *titlelabel;
    
	ACImageLoader *imageLoader;
    
    
    UIButton *passBtn;
    UIButton *AplusBtn;
    UIButton *failBtn;
}

@property (nonatomic,retain) UIImageView *PhotoImageView;
@property (nonatomic,retain) UILabel *titlelabel;
@property (nonatomic,retain) ACImageLoader *imageLoader;

@property (nonatomic,retain) UIButton *passBtn;
@property (nonatomic,retain) UIButton *AplusBtn;
@property (nonatomic,retain) UIButton *failBtn;

@end
