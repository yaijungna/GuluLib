//
//  GuluTableViewCell_Comment.h
//  GULUAPP
//
//  Created by alan on 11/9/20.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "GuluTableViewCell.h"
#import "UILabel+Custom.h"
#import "UIButton+Custom.h"
#import "LibraryConfig.h"

@interface GuluTableViewCell_Comment : GuluTableViewCell
{
    UILabel  *contentLabel;
    UILabel  *timeLabel;
    UIButton *userNameBtn;
    UIImageView *userImageview;
    UIImageView *backGroundImageview;
}

@property (nonatomic,retain)UILabel  *contentLabel;
@property (nonatomic,retain)UILabel  *timeLabel;
@property (nonatomic,retain)UIButton *userNameBtn;
@property (nonatomic,retain)UIImageView *userImageview;
@property (nonatomic,retain)UIImageView *backGroundImageview;


@end

