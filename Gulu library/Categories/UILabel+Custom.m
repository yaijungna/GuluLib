//
//  UILabel+Custom.m
//  GULUAPP
//
//  Created by alan on 11/9/16.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "UILabel+Custom.h"
#import "LibraryConfig.h"

@implementation UILabel(Custom)

-(void)customizeLabelToGuluStyle
{
	self.backgroundColor=[UIColor clearColor];
	self.font=LibraryTextNormalFont;
	self.textColor=LibraryTextColor;
	[self setTextAlignment:UITextAlignmentLeft];
    self.adjustsFontSizeToFitWidth = NO;
}

- (CGSize)dynamicSizeOfText:(CGSize)maxSize 
{
    self.numberOfLines=0;
    self.lineBreakMode=UILineBreakModeWordWrap;
    CGSize size = [self.text sizeWithFont:self.font
                   constrainedToSize:maxSize
                       lineBreakMode:UILineBreakModeWordWrap];
    return size;
}

@end
