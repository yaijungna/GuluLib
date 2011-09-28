//
//  UITableViewCell+Sliderview.m
//  GULUAPP
//
//  Created by alan on 11/9/6.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "UITableViewCell+Sliderview.h"
#import "ACUtility.h"

@implementation UITableViewCell (SliderSubView)

-(void)add_slideview_on_top:(UIView *)view
{
    CGRect rect=CGRectMake(self.frame.size.width, 0, view.frame.size.width, view.frame.size.height);
    [view setFrame:rect];
    
    [self addSubview:view];
}

-(void)add_slideview_on_medium:(UIView *)view
{
    float cellHeight=self.frame.size.height;
    
    CGRect rect=CGRectMake(self.frame.size.width, cellHeight/2-view.frame.size.height/2, view.frame.size.width, view.frame.size.height);
    [view setFrame:rect];
    
    [self addSubview:view];
}

-(void)add_slideview_on_bottom:(UIView *)view
{
    float cellHeight=self.frame.size.height;
    
    CGRect rect=CGRectMake(self.frame.size.width, cellHeight-view.frame.size.height, view.frame.size.width, view.frame.size.height);
    [view setFrame:rect];
    
    [self addSubview:view];
}

-(void)slide_in:(UIView *)view
{
    [ACUtility moveTheView:view moveToPosition:CGPointMake(0.0, view.frame.origin.y)];
}

-(void)slide_out:(UIView *)view
{
    [ACUtility moveTheView:view moveToPosition:CGPointMake(self.frame.size.width, view.frame.origin.y)];
}

@end
