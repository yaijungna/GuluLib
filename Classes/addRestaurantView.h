//
//  addRestaurantView.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/19.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface addRestaurantView : UIView {
    UIImageView *bgImageView;
    UILabel *nameLabel;
    UILabel *addLabel;
    UITextField *phonetextField;
    UIButton *addBtn;
    
}

@property(nonatomic,retain) UIImageView *bgImageView;
@property(nonatomic,retain) UILabel *nameLabel;
@property(nonatomic,retain) UILabel *addLabel;
@property(nonatomic,retain) UITextField *phonetextField;
@property(nonatomic,retain) UIButton *addBtn;


@end
