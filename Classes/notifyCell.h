//
//  notifyCell.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//


#define notify_text_font			[UIFont fontWithName:FONT_NORMAL size:12]
#define notify_text_font_bold		[UIFont fontWithName:FONT_BOLD size:12]


#import <UIKit/UIKit.h>
#import "ACTableViewCell.h"
#import "ACCreateButtonClass.h"
#import "AppStrings.h"

@interface notifyCell : ACTableViewCell {
	IBOutlet UILabel  *label1;
	IBOutlet UILabel  *label2;
	IBOutlet UIImageView *leftImageview;

    IBOutlet UIButton *yesBtn;
    IBOutlet UIButton *noBtn;
}

-(void)sizeToFitTitle;

-(void)showYesNoBtn;
-(void)hideYesNoBtn;

@property (nonatomic,retain)UILabel  *label1;
@property (nonatomic,retain)UILabel  *label2;
@property (nonatomic,retain)UIImageView *leftImageview;

@property (nonatomic,retain)UIButton *yesBtn;
@property (nonatomic,retain)UIButton *noBtn;

@end
