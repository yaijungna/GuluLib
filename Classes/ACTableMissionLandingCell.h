//
//  ACTableMissionLandingCell.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/29.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ACTableViewCell.h"
#import "ACCheckBox.h"


@interface ACTableMissionLandingCell : ACTableViewCell {
    
    IBOutlet UILabel  *labelTitle;
    IBOutlet UILabel  *labelSubTitle;
	IBOutlet UIImageView *leftImageview;
    IBOutlet UIImageView *rightImageview;
	
}

@property (nonatomic,retain) UILabel  *labelTitle;
@property (nonatomic,retain) UILabel  *labelSubTitle;
@property (nonatomic,retain) UIImageView *leftImageview;
@property (nonatomic,retain) UIImageView *rightImageview;




@end
