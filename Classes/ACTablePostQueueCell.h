//
//  ACTablePostQueueCell.h
//  GULUAPP
//
//  Created by alan on 11/9/5.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ACTableViewCell.h"

@interface ACTablePostQueueCell : ACTableViewCell
{
    IBOutlet UILabel  *label;
    IBOutlet UIImageView *leftImageview;
    
    IBOutlet UIButton  *btn1;
    
    IBOutlet UIProgressView *progress;
    IBOutlet UIActivityIndicatorView *spinner;
}

@property (nonatomic,retain) UILabel  *label;
@property (nonatomic,retain) UIImageView *leftImageview;

@property (nonatomic,retain) UIButton  *btn1;

@property (nonatomic,retain) UIProgressView *progress;
@property (nonatomic,retain) UIActivityIndicatorView *spinner;


-(void)progresReadyToStart;
-(void)progresFinish;

@end
