//
//  GuluTableViewCell_BigPhoto.h
//  GULUAPP
//
//  Created by alan on 11/9/21.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "GuluTableViewCell.h"
#import "UILabel+Custom.h"
#import "UIButton+Custom.h"

#import "GuluLikeView.h"
#import "GuluCommentsNumberView.h"
#import "LibraryConfig.h"

@interface GuluTableViewCell_BigPhoto: GuluTableViewCell
{
    UIImageView *bigImageview;
    UIButton   *Btn1;
    UIButton   *Btn2;
    UILabel *contentLabel;
    UILabel *atLabel;
    id viewForMore;
    GuluLikeView *likeView;
    GuluCommentsNumberView *commentView;
}


@property (nonatomic,retain)UIImageView *bigImageview;
@property (nonatomic,retain)UIButton   *Btn1;
@property (nonatomic,retain)UIButton   *Btn2;
@property (nonatomic,retain)UILabel *contentLabel;
@property (nonatomic,retain)UILabel *atLabel;
@property (nonatomic,retain)id viewForMore;
@property (nonatomic,retain)GuluLikeView *likeView;
@property (nonatomic,retain)GuluCommentsNumberView *commentView;

@end
