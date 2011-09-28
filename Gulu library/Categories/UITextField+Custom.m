//
//  UITextField+Custom.m
//  GULUAPP
//
//  Created by alan on 11/9/16.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "UITextField+Custom.h"


@implementation UITextField(Custom)

- (void)customizeTextFieldToGuluStyle
{
    
	self.borderStyle= UITextBorderStyleBezel;
	self.font=LibraryTextNormalFont;
	self.textColor=LibraryTextColor;
	self.layer.borderWidth = 1.0f;
	self.layer.borderColor=[[UIColor lightGrayColor] CGColor];
	[self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter]	;
	
	self.autocapitalizationType= UITextAutocapitalizationTypeNone;
	self.autocorrectionType=UITextAutocorrectionTypeDefault;
	
}


@end
