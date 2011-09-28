//
//  gradeDetailView.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/7.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "gradeDetailView.h"


@implementation gradeDetailView

@synthesize PhotoImageView;
@synthesize titlelabel;
@synthesize imageLoader;
@synthesize  passBtn,failBtn,AplusBtn;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
		
		PhotoImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 100, 100)];
		PhotoImageView.backgroundColor=[UIColor lightGrayColor];
		[self addSubview:PhotoImageView];
        
		titlelabel =[[UILabel alloc] initWithFrame:CGRectMake(120, 10, 190, 20)];
		[self addSubview:titlelabel];
        
        imageLoader=[[ACImageLoader alloc] init];
		imageLoader.delegate=self;
        
        self.passBtn=[ACCreateButtonClass createButton:ButtonTypeNormal];
        self.AplusBtn=[ACCreateButtonClass createButton:ButtonTypeNormal];
        self.failBtn=[ACCreateButtonClass createButton:ButtonTypeNormal];
        
        self.AplusBtn.frame= CGRectMake(120, 80, 63, 35);
        self.passBtn.frame=CGRectMake(187, 80, 63, 35);
        self.failBtn.frame= CGRectMake(254, 80, 63, 35);
    
        [self addSubview:passBtn];
        [self addSubview:AplusBtn];
        [self addSubview:failBtn];
        
        [passBtn setTitle:NSLocalizedString(@"Pass", @"[mission] varify") forState:UIControlStateNormal];
        [AplusBtn setTitle:NSLocalizedString(@"A+", @"[mission] varify") forState:UIControlStateNormal];
        [failBtn setTitle:NSLocalizedString(@"Fail", @"[mission] varify") forState:UIControlStateNormal];
        
        [passBtn setBackgroundImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateNormal];
        [AplusBtn setBackgroundImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
        [failBtn setBackgroundImage:[UIImage imageNamed:@"red.png"] forState:UIControlStateNormal];

		
    }
    return self;
}


- (void)dealloc {
    
    [PhotoImageView release];
    [titlelabel release];
	[imageLoader release];
    [AplusBtn release];
    [failBtn release];
    [passBtn release];
    [super dealloc];
}

#pragma mark ACImageDidLoad Delegate and Function Methods

- (void)ACImageDidLoad:(ACImageLoader *)imageloader
{
	if (imageloader.image != nil)
	{
		PhotoImageView.image=imageloader.image;
	}	 
}


@end
