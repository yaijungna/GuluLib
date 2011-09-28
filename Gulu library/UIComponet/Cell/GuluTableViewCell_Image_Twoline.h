//
//  GuluTableViewCell_Image_Twoline.h
//  GULUAPP
//
//  Created by alan on 11/9/16.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuluTableViewCell.h"
#import "UILabel+Custom.h"

@interface GuluTableViewCell_Image_Twoline : GuluTableViewCell
{
    UILabel  *label1;
    UILabel  *label2;
    UIImageView *leftImageview;
    id viewForMore;
}

@property (nonatomic,retain)UILabel  *label1;
@property (nonatomic,retain)UILabel  *label2;
@property (nonatomic,retain)UIImageView *leftImageview;
@property (nonatomic,retain)id viewForMore;

@end
