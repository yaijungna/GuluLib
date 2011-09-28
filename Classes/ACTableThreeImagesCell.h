//
//  ACTableThreeImagesCell.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/16.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACTableViewCell.h"

@interface ACTableThreeImagesCell : ACTableViewCell {
	
	IBOutlet UIButton *leftBtn;
	IBOutlet UIButton *middleBtn;
	IBOutlet UIButton *rightBtn;
	
	IBOutlet UILabel	*label1;
	IBOutlet UILabel	*label2;
	IBOutlet UILabel	*label3;
	
	IBOutlet UIImageView	*imageView1;
	IBOutlet UIImageView	*imageView2;
	IBOutlet UIImageView	*imageView3;
}

@property (nonatomic,retain)UIButton *leftBtn;
@property (nonatomic,retain)UIButton *middleBtn;
@property (nonatomic,retain)UIButton *rightBtn;
@property (nonatomic,retain)UILabel  *label1;
@property (nonatomic,retain)UILabel  *label2;
@property (nonatomic,retain)UILabel  *label3;

-(void)showIndexOfBtn :(NSInteger)index;
-(void)hideIndexOfBtn :(NSInteger)index;

@end
