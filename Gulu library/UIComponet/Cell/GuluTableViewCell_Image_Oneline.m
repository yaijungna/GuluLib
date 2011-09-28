//
//  GuluTableViewCell_Image_Oneline.m
//  GULUAPP
//
//  Created by alan on 11/9/21.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluTableViewCell_Image_Oneline.h"

@implementation GuluTableViewCell_Image_Oneline

@synthesize label1;
@synthesize leftImageview;
@synthesize viewForMore;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        label1=[[UILabel alloc] init];
        leftImageview=[[UIImageView alloc] init];
        
        [self.contentView addSubview:label1];
        [self.contentView addSubview:leftImageview];
	}
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize labeSize=CGSizeMake(55, 40);
    CGSize imageSize=CGSizeMake(40, 40);
    
//    float interval1=10.0;
    float interval2=5.0;
    
    CGRect contentRect = self.contentView.bounds;
    CGPoint centerPoint = self.contentView.center;
    
    //=======
	
    CGRect imageViewRect = CGRectMake(interval2, centerPoint.y-imageSize.height/2 , imageSize.width, imageSize.height);  
    leftImageview.frame=imageViewRect;
    leftImageview.backgroundColor=[UIColor lightGrayColor];
    
	CGRect frame1 = CGRectMake(interval2+imageSize.width+interval2, 
                               centerPoint.y-labeSize.height/2, 
                               contentRect.size.width -interval2-imageSize.height-interval2 , 
                               labeSize.height);
    
   
	
	label1.frame = frame1;
}

- (void)dealloc {
	[label1 release];
	[leftImageview release];
    [viewForMore release];
	
    [super dealloc];
}




@end
