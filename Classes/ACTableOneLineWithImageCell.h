//
//  ACTableOneLineWithImageCell.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/19.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ACTableViewCell.h"

@interface ACTableOneLineWithImageCell : ACTableViewCell {
	IBOutlet UIImageView *rightImageview;
	IBOutlet UILabel  *label1;
	IBOutlet UIImageView *leftImageview;
	IBOutlet UISwitch *switcher;
	BOOL isExpand;
}

@property (nonatomic,retain) UIImageView *rightImageview;
@property (nonatomic,retain) UILabel  *label1;
@property (nonatomic,retain) UIImageView *leftImageview;
@property (nonatomic,retain) UISwitch *switcher;
@property (nonatomic) BOOL isExpand;

-(void)setRightImageDown;
-(void)setRightImageRight;
-(void)setArrowDirection;


@end
