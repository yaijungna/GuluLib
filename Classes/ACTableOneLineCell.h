//
//  ACTableOneLineCell.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/8.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACTableViewCell.h"

@interface ACTableOneLineCell : ACTableViewCell {
	IBOutlet UIButton *rightBtn;
	IBOutlet UILabel  *label1;
    IBOutlet UILabel  *label2;

}

@property (nonatomic,retain)UIButton *rightBtn;
@property (nonatomic,retain)UILabel  *label1;
@property (nonatomic,retain)UILabel  *label2;

@end
