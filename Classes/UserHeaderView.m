//
//  UserHeaderView.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/17.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "UserHeaderView.h"


@implementation UserHeaderView

@synthesize imageView,nameBtn,indexPath,rightLabel;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		UIImageView *bgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width ,frame.size.height)];
		[self addSubview:bgView];
		[bgView release];
		
        bgView.image=[UIImage imageNamed:@"table_user_name_bar.png"];
		
		imageView=[[[UIImageView alloc] initWithFrame:CGRectMake(10,5,30 ,30)] autorelease];
		[self addSubview:imageView];
		[imageView setBackgroundColor:[UIColor lightGrayColor]];
        
        rightLabel=[[[UILabel alloc] initWithFrame:CGRectMake(250, 0 ,65, 40)] autorelease];
		[self addSubview:rightLabel];
        rightLabel.numberOfLines=2;
        rightLabel.textAlignment=UITextAlignmentLeft;
        rightLabel.backgroundColor=[UIColor clearColor];
        rightLabel.textColor=[UIColor grayColor];
        rightLabel.font=[UIFont fontWithName:FONT_NORMAL size:10];
        
        
        self.nameBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        nameBtn.frame=CGRectMake(50, 0 ,200, 40);
        [nameBtn setTitleColor:BLUE_TEXT_COLOR forState:UIControlStateNormal];
        [nameBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [nameBtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:16]];
		[self addSubview:nameBtn];

		self.backgroundColor=[UIColor clearColor];
        
    }
    return self;
}



- (void)dealloc {
    [nameBtn release];
    [indexPath release];
    [super dealloc];
}


@end
