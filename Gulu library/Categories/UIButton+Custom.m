//
//  UIButton+Custom.m
//  GULUAPP
//
//  Created by alan on 11/9/21.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "UIButton+Custom.h"
#import "UIImageView+WebCache.h"

@implementation UIButton (Custom)

- (CGSize)dynamicSizeOfText:(CGSize)maxSize  {
    
    CGSize stringSize = [self.titleLabel.text
                         sizeWithFont:self.titleLabel.font
                         constrainedToSize:maxSize
                         lineBreakMode:self.titleLabel.lineBreakMode];
    return stringSize;
}

-(void)customizeLabelToGuluStyle
{
	self.backgroundColor=[UIColor clearColor];
	self.titleLabel.font=LibraryTextNormalFont;
    [self setTitleColor:LibraryTextColor forState:UIControlStateNormal];
    self.titleLabel.numberOfLines=1;
	[self.titleLabel setTextAlignment:UITextAlignmentLeft];
    self.titleLabel.adjustsFontSizeToFitWidth = NO;
    self.titleLabel.lineBreakMode=UILineBreakModeTailTruncation;
}

-(void)setBackgroundImageWithURL:(NSURL *)URL forState:(UIControlState) state
{
    UIImageView *imageView=[[UIImageView alloc] init];
    [imageView setImageWithURL:URL];
    [self setBackgroundImage:imageView.image forState:state];
    [imageView release];
}

@end
