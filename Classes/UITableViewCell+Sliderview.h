//
//  UITableViewCell+Sliderview.h
//  GULUAPP
//
//  Created by alan on 11/9/6.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  UITableViewCell (SliderSubView)


-(void)add_slideview_on_top:(UIView *)view;
-(void)add_slideview_on_medium:(UIView *)view;
-(void)add_slideview_on_bottom:(UIView *)view;

-(void)slide_in:(UIView *)view;
-(void)slide_out:(UIView *)view;

@end
