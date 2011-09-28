//
//  UIButton+Custom.h
//  GULUAPP
//
//  Created by alan on 11/9/21.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LibraryConfig.h"

@interface UIButton (Custom)

- (void)customizeLabelToGuluStyle;
- (CGSize)dynamicSizeOfText:(CGSize)maxSize ;
- (void)setBackgroundImageWithURL:(NSURL *)URL forState:(UIControlState) state;

@end
