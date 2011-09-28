//
//  ACButtonWithLeftImage.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/19.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppSettings.h"

@interface ACButtonWithLeftImage : UIButton {
	UIImageView *leftImageView;
	UILabel *textlabel;
}

@property (nonatomic,retain) UIImageView *leftImageView;
@property (nonatomic,retain) UILabel *textlabel;

- (CGSize)SizeTofit : (NSString *)text  textFont:(UIFont *)textfont ;

@end
