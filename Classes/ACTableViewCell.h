//
//  ACTableViewCell.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/8.
//  Copyright 2011 Gulu.com. All rights reserved.
//


#define unseen_cell_color [UIColor colorWithRed:0.75 green:0.722 blue:0.6999 alpha:1.0]
#define normal_cell_color [UIColor colorWithRed:0.851 green:0.804 blue:0.75 alpha:1.0]

#import <UIKit/UIKit.h>
#import "AppSettings.h"
#import "moreView.h"

@interface ACTableViewCell : UITableViewCell {
	IBOutlet UIImageView *bgimg;
	moreView *more;

}

-(void)initCell;
-(void)customizeLabel_title :(UILabel *) label;
-(void)customizeLabel_subtitle :(UILabel *) label;
-(void)showMore;
-(void)hideMore;


@property (nonatomic,retain)moreView *more;

@end
