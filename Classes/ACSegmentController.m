//
//  ACSegmentController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/1.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACSegmentController.h"
#import "AppSettings.h"


@implementation ACSegmentController

@synthesize delegate;
@synthesize normalImage;
@synthesize selectedImage;

- (void)dealloc {
	[btnArray release];
	[selectedImage release];
	[normalImage release];
    [super dealloc];
}


- (id)initWithFrame:(CGRect)Frame
{
	if(self=[super initWithFrame:Frame])
	{

	}
	
	return self;
}

-(void) initCustomSegment:(NSArray *)titleArray
					normalimage:(UIImage *)normalImg
					selectedimage:(UIImage *)selectedImg
						textfont:(UIFont *)font
{
	NSInteger number =[titleArray count];
	btnArray=[[NSMutableArray alloc] init];
	
	self.normalImage=normalImg;
	self.selectedImage=selectedImg;
	
    float gap=2;

	NSInteger width=self.frame.size.width/number - gap;
	NSInteger height=self.frame.size.height;
	
	for(int i =0;i<number;i++)
	{
		UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(1+width*i + gap*i, 0, width,height)];
		[btn setBackgroundImage:normalImage forState:UIControlStateNormal];
		[btn setBackgroundImage:normalImage forState:UIControlStateHighlighted];
		[btn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
		btn.titleLabel.font=font;
        [btn.titleLabel setLineBreakMode:UILineBreakModeWordWrap];
        btn.titleLabel.textAlignment=UITextAlignmentCenter ;
        btn.tag=i;
		[btn addTarget:self action:@selector(toggleAction:) forControlEvents:UIControlEventTouchUpInside];
		[btnArray addObject:btn];
		[self addSubview:btn];
		[btn release];
	}
	
	selectIndex=0;
	
	[self setSelectedButtonAtIndex:selectIndex];
}

-(void) setSelectedButtonAtIndex:(NSInteger)index
{
	
	for(UIButton *btn in btnArray)
	{
		if(btn.tag==index)
		{
			[btn setBackgroundImage:selectedImage forState:UIControlStateNormal];
			[btn setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
			//[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:lightBrownColor forState:UIControlStateNormal];
		}
		else
		{
			[btn setBackgroundImage:normalImage forState:UIControlStateNormal];
			[btn setBackgroundImage:normalImage forState:UIControlStateHighlighted];
			[btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
           // [btn setTitleColor:darkBrownColor forState:UIControlStateNormal];
		}
	}
	
	[delegate touchSegmentAtIndex:index];	

}

-(void) toggleAction:(UIButton*) btn
{
	NSInteger current=btn.tag;
	[self setSelectedButtonAtIndex:current];
}



@end
