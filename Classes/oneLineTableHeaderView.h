//
//  oneLineTableHeaderView.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/21.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACCreateButtonClass.h"

@interface oneLineTableHeaderView : UIView {
	
	UIImageView *bg;
	UILabel *label1;
	UIButton *rightBtn;

}

@property (nonatomic,retain)UIImageView *bg;
@property (nonatomic,retain)UILabel *label1;
@property (nonatomic,retain)UIButton *rightBtn;

@end
