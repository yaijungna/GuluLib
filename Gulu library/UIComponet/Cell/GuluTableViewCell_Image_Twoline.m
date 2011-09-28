//
//  GuluTableViewCell_Image_Twoline.m
//  GULUAPP
//
//  Created by alan on 11/9/16.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluTableViewCell_Image_Twoline.h"

@implementation GuluTableViewCell_Image_Twoline

@synthesize label1;
@synthesize label2;
@synthesize leftImageview;
@synthesize viewForMore;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        label1=[[UILabel alloc] init];
        label2=[[UILabel alloc] init];
        leftImageview=[[UIImageView alloc] init];
        
        [label1 customizeLabelToGuluStyle];
        [label2 customizeLabelToGuluStyle];
    
        [self.contentView addSubview:label1];
        [self.contentView addSubview:label2];
        [self.contentView addSubview:leftImageview];
	}
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize labeSize=CGSizeMake(55, 25);
    CGSize imageSize=CGSizeMake(50, 50);

    float interval1=10.0;
    float interval2=5.0;
    
    CGRect contentRect = self.contentView.bounds;
    CGPoint centerPoint = self.contentView.center;
    
    //=======
	
    CGRect imageViewRect = CGRectMake(interval1, centerPoint.y-imageSize.height/2 , imageSize.width, imageSize.height);  
    leftImageview.frame=imageViewRect;
    leftImageview.backgroundColor=[UIColor lightGrayColor];

	CGRect frame1 = CGRectMake(interval1+imageSize.width+interval2, 
                               centerPoint.y-labeSize.height, 
                               contentRect.size.width -interval1-imageSize.height-interval2 , 
                               labeSize.height);
    
    CGRect frame2 = CGRectMake(interval1+imageSize.width+interval2, 
                               centerPoint.y, 
                               contentRect.size.width -interval1-imageSize.height-interval2 , 
                               labeSize.height);
	
	label1.frame = frame1;
    label2.frame = frame2;
}

- (void)dealloc {
	[label1 release];
	[label2 release];
	[leftImageview release];
    [viewForMore release];
	
    [super dealloc];
}




@end
