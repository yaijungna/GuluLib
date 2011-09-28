//
//  addRestaurantAnnotaionView.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/10.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSettings.h"

@interface addRestaurantAnnotaionView : UIView {
	UILabel *nameLabel;
	UITextField *phoneTextField;
}

@property (nonatomic,retain) UILabel *nameLabel;
@property (nonatomic,retain) UITextField *phoneTextField;

@end
