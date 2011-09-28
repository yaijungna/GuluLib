//
//  GuluTableViewCell_3Images.m
//  GULUAPP
//
//  Created by alan on 11/9/20.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluTableViewCell_3Images.h"

@implementation GuluTableViewCell_3Images

@synthesize btn1;
@synthesize btn2;
@synthesize btn3;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        btn1=[[UIButton alloc] init];
        btn2=[[UIButton alloc] init];
        btn3=[[UIButton alloc] init];
    
        [self.contentView addSubview:btn1];
        [self.contentView addSubview:btn2];
        [self.contentView addSubview:btn3];
	}
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize imageSize=CGSizeMake(96, 96);
    
    float interval=8.0;
    
//    CGRect contentRect = self.contentView.bounds;
    CGPoint centerPoint = self.contentView.center;
    
    //===
    
    CGRect Rect1 = CGRectMake(interval, centerPoint.y-imageSize.height/2 , imageSize.width, imageSize.height); 
    CGRect Rect2 = CGRectMake(interval*2+imageSize.width, centerPoint.y-imageSize.height/2 , imageSize.width, imageSize.height);
    CGRect Rect3 = CGRectMake(interval*3+imageSize.width*2, centerPoint.y-imageSize.height/2 , imageSize.width, imageSize.height);

    btn1.frame=Rect1;
    btn2.frame=Rect2;
    btn3.frame=Rect3;
}

- (void)dealloc {
    
    [btn1 release];
    [btn2 release];
    [btn3 release];
	
    [super dealloc];
}




@end
