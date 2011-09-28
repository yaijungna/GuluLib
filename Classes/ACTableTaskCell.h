//
//  ACTableTaskCell.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ACTableViewCell.h"
#import "ACCheckBox.h"


@interface ACTableTaskCell : ACTableViewCell {
	IBOutlet UILabel  *label1;
    IBOutlet UILabel  *label2;
	IBOutlet UIImageView *leftImageview;
    IBOutlet UITextView *aboutTextView;
    IBOutlet UIView *bgView;
    ACCheckBox *checkBoxBtn;

}
@property (nonatomic,retain) IBOutlet UILabel  *label1;
@property (nonatomic,retain) IBOutlet UILabel  *label2;
@property (nonatomic,retain) IBOutlet UIImageView *leftImageview;
@property (nonatomic,retain) IBOutlet UITextView *aboutTextView;
@property (nonatomic,retain) IBOutlet UIView *bgView;
@property (nonatomic,retain) ACCheckBox *checkBoxBtn;




@end
