//
//  ACCommentCell.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/4.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ACTableViewCell.h"

@interface ACCommentCell : ACTableViewCell {
    IBOutlet UILabel  *labelContent;
	IBOutlet UILabel  *labelTitle;
    IBOutlet UILabel  *timelabel;
	IBOutlet UIImageView *leftImageview;
    IBOutlet UIImageView *bgImgView;
	
}

@property (nonatomic,retain) IBOutlet UILabel  *labelContent;
@property (nonatomic,retain) IBOutlet UILabel  *labelTitle;
@property (nonatomic,retain) IBOutlet UILabel  *timelabel;
@property (nonatomic,retain) IBOutlet UIImageView *leftImageview;
@property (nonatomic,retain) IBOutlet UIImageView *bgImgView;

- (void)sizeToFitCell;

@end
