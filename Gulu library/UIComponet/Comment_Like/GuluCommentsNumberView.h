//
//  GuluCommentsNumberView.h
//  GULUAPP
//
//  Created by alan on 11/9/21.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuluCommentsNumberView : UIView
{
    UIImageView *commentImageView;
    UILabel *commentStringLabel;
    UIButton *commentButton;
    
    NSInteger numOfComment;
}

@property(nonatomic,retain)UIImageView *commentImageView;
@property(nonatomic,retain)UILabel *commentStringLabel;
@property(nonatomic,retain)UIButton *commentButton;

@property(nonatomic)NSInteger numOfComment;

@end
