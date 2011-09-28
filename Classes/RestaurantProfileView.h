//
//  RestaurantProfileView.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/17.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppStrings_restaurant.h"

@interface RestaurantProfileView : UIView{
	UIImageView *imageView;
	UILabel *titleLabel;
	UILabel *addressLabel;
	UILabel *phoneLabel;
	UILabel *follwersLabel;
	UILabel *reviewsLabel;
	UILabel *follwersNumberLabel;
	UILabel *reviewsNumberLabel;

	UIImageView *guluapproveImageView;
}

@property (nonatomic,assign) UIImageView *imageView;
@property (nonatomic,assign) UILabel *titleLabel;
@property (nonatomic,assign) UILabel *addressLabel;
@property (nonatomic,assign) UILabel *phoneLabel;
@property (nonatomic,assign) UILabel *follwersLabel;
@property (nonatomic,assign) UILabel *reviewsLabel;
@property (nonatomic,assign) UILabel *follwersNumberLabel;
@property (nonatomic,assign) UILabel *reviewsNumberLabel;
@property (nonatomic,assign) UIImageView *guluapproveImageView;
@end
