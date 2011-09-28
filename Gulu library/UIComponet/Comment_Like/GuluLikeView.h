//
//  GuluLikeView.h
//  GULUAPP
//
//  Created by alan on 11/9/21.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuluLikeView : UIView
{
    UIImageView *starImageView;
    UILabel *likeStringLabel;
    UIButton *likeButton;
    
    NSInteger numOfLike;
}

@property(nonatomic,retain)UIImageView *starImageView;
@property(nonatomic,retain)UILabel *likeStringLabel;
@property(nonatomic,retain)UIButton *likeButton;

@property(nonatomic)NSInteger numOfLike;

@end
