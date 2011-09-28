//
//  missionDetailView.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/4.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSettings.h"
#import "ACImageLoader.h"

@interface missionDetailView : UIView   <ACImageDownloaderDelegate>{
    UIImageView *PhotoImageView;
	UILabel *titlelabel;
    UILabel *subtitlelabel;
	UITextView *aboutView;
    UILabel *bottomLabel;
    
	ACImageLoader *imageLoader;
}

@property (nonatomic,retain) UIImageView *PhotoImageView;
@property (nonatomic,retain) UILabel *titlelabel;
@property (nonatomic,retain) UILabel *subtitlelabel;
@property (nonatomic,retain) UITextView *aboutView;
@property (nonatomic,retain) UILabel *bottomLabel;
@property (nonatomic,retain) ACImageLoader *imageLoader;

@end
