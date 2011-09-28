//
//  ACButtonWIthButtomTitle.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ACButtonWIthBottomTitle : UIView {
	UIButton	*btn;
	UILabel		*btnTitleLabel;
	UIImageView *imgView;
	UIImage *hightlightImage;
	UIImage *normalImage;
}

@property(nonatomic,retain) UIButton	*btn;
@property(nonatomic,retain) UILabel		*btnTitleLabel;
@property(nonatomic,retain) UIImageView *imgView;
@property(nonatomic,retain) UIImage		*hightlightImage;
@property(nonatomic,retain) UIImage		*normalImage;

- (void)setImageViewSize :(CGSize)imageSize;

@end
