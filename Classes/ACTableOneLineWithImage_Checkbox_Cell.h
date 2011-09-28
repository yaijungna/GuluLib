//
//  ACTableOneLineWithImage_Checkbox_Cell.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/22.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ACTableViewCell.h"
#import "ACCheckBox.h"

@interface ACTableOneLineWithImage_Checkbox_Cell : ACTableViewCell {

	IBOutlet UILabel  *label1;
	IBOutlet UIImageView *leftImageview;
	
	IBOutlet ACCheckBox *checkBox;
}

@property (nonatomic,retain) UILabel  *label1;
@property (nonatomic,retain) UIImageView *leftImageview;
@property (nonatomic,retain) ACCheckBox *checkBox;


@end
