//
//  GuluTableViewCell_Comment.m
//  GULUAPP
//
//  Created by alan on 11/9/20.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluTableViewCell_Comment.h"

@implementation GuluTableViewCell_Comment

@synthesize contentLabel;
@synthesize timeLabel;
@synthesize userNameBtn;
@synthesize backGroundImageview;
@synthesize userImageview;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        backGroundImageview=[[UIImageView alloc] init];
        userImageview=[[UIImageView alloc] init];
        userNameBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        contentLabel=[[UILabel alloc] init];
        timeLabel=[[UILabel alloc] init];
        
        backGroundImageview.backgroundColor=LibraryColorLightBrown;
        backGroundImageview.layer.cornerRadius=5.0;
        backGroundImageview.alpha=0.8;

        userImageview.backgroundColor=[UIColor clearColor];
        
        [userNameBtn customizeLabelToGuluStyle];
        [userNameBtn.titleLabel setFont:LibraryTextTitleFont];
        
        [contentLabel customizeLabelToGuluStyle];
        
        [timeLabel customizeLabelToGuluStyle];
        timeLabel.backgroundColor=[UIColor clearColor];
        timeLabel.textColor=[UIColor lightGrayColor];
        [timeLabel setTextAlignment:UITextAlignmentRight];
        
        [self.contentView addSubview:backGroundImageview];
        [self.contentView addSubview:userImageview];
        [self.contentView addSubview:userNameBtn];
        [self.contentView addSubview:contentLabel];
        [self.contentView addSubview:timeLabel];
	}
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
  //  CGRect contentRect = self.contentView.bounds;
 //   CGPoint centerPoint = self.contentView.center;
        
    float interval1=10.0;
    float interval2=5.0;
    
    CGSize userImageSize=CGSizeMake(50, 50);
    CGSize userLabelSize=CGSizeMake(235, 25);
    CGSize constrainSize=CGSizeMake(235, 10000);
    
    //=======
	
    CGRect imageViewRect = CGRectMake(interval1, interval2 , userImageSize.width, userImageSize.height);  
    userImageview.frame=imageViewRect;
	

    CGSize userNameBtnSize=[userNameBtn dynamicSizeOfText:constrainSize];
    CGRect userNameRect=CGRectMake(interval1+imageViewRect.size.width+interval2, 
                                 interval2 , 
                                 userNameBtnSize.width , 
                                 userNameBtnSize.height);
    userNameBtn.frame=userNameRect;
    
    
    CGSize contentSize=[contentLabel dynamicSizeOfText:constrainSize];
    CGRect contentFrame = CGRectMake(userNameRect.origin.x, 
                                     userNameRect.origin.y+userNameRect.size.height , 
                                     contentSize.width , 
                                     contentSize.height);
    contentLabel.frame=contentFrame;
    
    CGRect timeFrame = CGRectMake(   userNameRect.origin.x, 
                                     contentFrame.origin.y+contentFrame.size.height , 
                                     userLabelSize.width , 
                                     userLabelSize.height);
    
    timeLabel.frame=timeFrame;
    backGroundImageview.frame=CGRectMake(interval2,
                                         0,
                                         interval1+userImageSize.width+interval2+userLabelSize.width+interval2,
                                         timeLabel.frame.origin.y+timeLabel.frame.size.height);
    
}

- (void)dealloc {
	[contentLabel release];
    [timeLabel release];
    [userImageview release];
    [backGroundImageview release];
    
    [super dealloc];
}

- (void)setHighlighted: (BOOL)highlighted animated: (BOOL)animated
{
	
}

- (void)setSelected: (BOOL)selected animated: (BOOL)animated 
{
	
}



@end

