//
//  GuluTableViewCell_Image_Oneline.h
//  GULUAPP
//
//  Created by alan on 11/9/21.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluTableViewCell.h"

@interface GuluTableViewCell_Image_Oneline : GuluTableViewCell
{
    UILabel  *label1;
    UIImageView *leftImageview;
    id viewForMore;
    
}

@property (nonatomic,retain)UILabel  *label1;
@property (nonatomic,retain)UIImageView *leftImageview;
@property (nonatomic,retain)id viewForMore;

@end
