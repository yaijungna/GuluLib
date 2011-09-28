//
//  UserHeaderView.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/17.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACImageLoader.h"
#import "AppSettings.h"

@interface UserHeaderView : UIView{
	UIImageView *imageView;
    UIButton *nameBtn;
    NSIndexPath *indexPath;
    UILabel *rightLabel;
}

@property (nonatomic,retain) UIImageView *imageView;
@property (nonatomic,retain) UIButton *nameBtn;
@property (nonatomic,retain) NSIndexPath *indexPath;
@property (nonatomic,retain) UILabel *rightLabel;

@end



