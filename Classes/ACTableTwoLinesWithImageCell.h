//
//  ACTableTwoLinesWithImageCell.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/15.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACTableViewCell.h"


@interface ACTableTwoLinesWithImageCell : ACTableViewCell {
	IBOutlet UIButton *rightBtn;
	IBOutlet UILabel  *label1;
	IBOutlet UILabel  *label2;
	IBOutlet UIImageView *leftImageview;
	UIImageView *rightViewImage;
}

@property (nonatomic,retain)UIButton *rightBtn;
@property (nonatomic,retain)UILabel  *label1;
@property (nonatomic,retain)UILabel  *label2;
@property (nonatomic,retain)UIImageView *leftImageview;
@property (nonatomic,retain)UIImageView *rightViewImage;

-(void)setRightBtnToMoretype;
-(void)setRightBtnToNormaltype;

@end
