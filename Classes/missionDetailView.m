//
//  missionDetailView.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/4.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "missionDetailView.h"


@implementation missionDetailView

@synthesize PhotoImageView;
@synthesize titlelabel;
@synthesize subtitlelabel;
@synthesize aboutView;
@synthesize bottomLabel;
@synthesize imageLoader;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
		
		PhotoImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 100, 100)];
		PhotoImageView.backgroundColor=[UIColor lightGrayColor];
		[self addSubview:PhotoImageView];

		titlelabel =[[UILabel alloc] initWithFrame:CGRectMake(120, 10, 190, 20)];
		[self addSubview:titlelabel];
        
        subtitlelabel =[[UILabel alloc] initWithFrame:CGRectMake(120, 30, 190, 20)];
		[self addSubview:subtitlelabel];
        
        aboutView =[[UITextView alloc] initWithFrame:CGRectMake(120, 50, 190, 55)];
		[self addSubview:aboutView];
        
        bottomLabel =[[UILabel alloc] initWithFrame:CGRectMake(120, 105, 190, 20)];
		[self addSubview:bottomLabel];

        imageLoader=[[ACImageLoader alloc] init];
		imageLoader.delegate=self;
		
    }
    return self;
}


- (void)dealloc {
    
    imageLoader.delegate=nil;
    [imageLoader cancelDownload];
    
    [PhotoImageView release];
    [titlelabel release];
    [subtitlelabel release];
    [aboutView release];
    [bottomLabel release];
	[imageLoader release];
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
