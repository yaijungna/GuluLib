//
//  reviewDetailCell.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/5.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ACTableViewCell.h"


@interface reviewDetailCell : ACTableViewCell {
    IBOutlet UILabel  *label1;
	IBOutlet UILabel  *label2;
    IBOutlet UILabel  *label3;
    IBOutlet UILabel  *label4;
    IBOutlet UILabel  *aboutlabel;
    IBOutlet UITextView *aboutTextView;
	IBOutlet UIImageView *Imageview;
	
}

@property (nonatomic,retain)   IBOutlet UILabel  *label1;
@property (nonatomic,retain)   IBOutlet UILabel  *label2;
@property (nonatomic,retain)   IBOutlet UILabel  *label3;
@property (nonatomic,retain)   IBOutlet UILabel  *label4;
@property (nonatomic,retain)   IBOutlet UILabel  *aboutlabel;
@property (nonatomic,retain)   IBOutlet UITextView *aboutTextView;
@property (nonatomic,retain)   IBOutlet UIImageView *Imageview;

- (void)sizeToFitCell :(NSString *)text;

@end
