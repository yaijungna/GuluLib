//
//  ACActionSheetView.m
//  GULUAPP
//
//  Created by alan on 11/8/17.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "ACActionSheetView.h"

static CGFloat rowHeight=10.0;

@implementation ACActionSheetView

@synthesize backGroundImageView;
@synthesize sheetView;
@synthesize buttonsArray;
@synthesize deleagte;
@synthesize aboveView;

- (id)initWithAboveSheet:(UIView *)aboveview
{
    self = [super initWithFrame:CGRectMake(0, aboveview.frame.size.height, aboveview.frame.size.width, aboveview.frame.size.height)];
    
    if (self) {
        
        self.sheetView=[[[UIView alloc] init] autorelease];
        self.backGroundImageView=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]] autorelease];
        self.buttonsArray=[[[NSMutableArray alloc] init] autorelease];
        self.aboveView=aboveview;
        
        [self.backGroundImageView setBackgroundColor:[UIColor blackColor]];
        self.backGroundImageView.alpha=0.6;
        
        [sheetView addSubview:backGroundImageView];
        [self addSubview: sheetView];
        [aboveView addSubview:self];
    }
    return self;
}



- (void)dealloc {
    [sheetView release];
    [backGroundImageView release];
    [buttonsArray release];
    [aboveView release];
    [super dealloc];
}

-(void) tapAction:(UIButton *)btn
{
    [deleagte ACActionSheetViewTapAtIndexButton:self index:btn.tag];
}

- (NSInteger)addButton:(UIButton *)btn
{    
    btn.tag=[buttonsArray count];
    [buttonsArray addObject:btn];
    [sheetView addSubview:btn];
    
    [btn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if([buttonsArray count]==0)
        return 0;
    
    return  [buttonsArray count]-1;
}


- (void)dismissSheet
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	CGRect Frame=CGRectMake(0, aboveView.frame.size.height, self.frame.size.width ,self.frame.size.height );
    self.frame=Frame;
	[self layoutSubviews];
	[UIView commitAnimations];
    
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];  //autorelease
}

- (void)showFromBottom
{
    
    if([buttonsArray count]==0)
    {
        return;
    }
    
    for(int i=0; i<[buttonsArray count];i++)
    {
        UIButton *btn=[buttonsArray objectAtIndex:i];
        [btn setFrame:CGRectMake(self.center.x-btn.frame.size.width/2,rowHeight+(btn.frame.size.height+rowHeight)*i , btn.frame.size.width, btn.frame.size.height)];
    }
    
    UIButton *btn=[buttonsArray objectAtIndex:0];
    
    CGFloat width   =self.frame.size.width;
    CGFloat height  =rowHeight+[buttonsArray count]*(btn.frame.size.height+rowHeight);
    
    CGRect sheetframe=CGRectMake(0,self.frame.size.height-height ,width , height);
    sheetView.frame=sheetframe;
    self.backGroundImageView.frame=CGRectMake(0, 0, sheetframe.size.width, sheetframe.size.height);

    //========================
    
    
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	CGRect Frame=CGRectMake(0, 0, self.frame.size.width ,self.frame.size.height );
    self.frame=Frame;
	[self layoutSubviews];
	[UIView commitAnimations];
 
}




@end
