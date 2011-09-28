//
//  numberAndImageView.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/13.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSettings.h"

@interface numberAndImageView : UIView {
	UILabel *numberLabel;
	UIButton *btn;
}

@property (nonatomic,retain)UILabel *numberLabel;
@property (nonatomic,retain)UIButton *btn;

@end
