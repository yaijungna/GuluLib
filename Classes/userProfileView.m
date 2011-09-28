//
//  userProfileView.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/20.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "userProfileView.h"


@implementation userProfileView

@synthesize userPhotoImageView;
@synthesize namelabel;
@synthesize fanlabel;
@synthesize missionlabel;
@synthesize Apluslabel;

@synthesize Nfanlabel;
@synthesize Nmissionlabel;
@synthesize NApluslabel;

@synthesize chanegePhotoBtn;

@synthesize imageLoader;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
		//self.backgroundColor=[UIColor blueColor];
		
		userPhotoImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 120, 120)];
		userPhotoImageView.backgroundColor=[UIColor lightGrayColor];
		[self addSubview:userPhotoImageView];

		
		
		namelabel=[[UILabel alloc] initWithFrame:CGRectMake(140, 5, 170, 30)];
		[self addSubview:namelabel];

		
		fanlabel=[[UILabel alloc] initWithFrame:CGRectMake(140, 40, 80, 20)];
		[self addSubview:fanlabel];

		fanlabel.text=PROFILE_USER_FANS_STRING;
		
		Nfanlabel=[[UILabel alloc] initWithFrame:CGRectMake(225, 40, 80, 20)];
		[self addSubview:Nfanlabel];

		
		missionlabel=[[UILabel alloc] initWithFrame:CGRectMake(140, 65, 80, 20)];
		[self addSubview:missionlabel];

		missionlabel.text=PROFILE_USER_MISSIONS_STRING;	
		
		Nmissionlabel=[[UILabel alloc] initWithFrame:CGRectMake(225, 65, 80, 20)];
		[self addSubview:Nmissionlabel];

		
		Apluslabel=[[UILabel alloc] initWithFrame:CGRectMake(140, 90, 80, 20)];
		[self addSubview:Apluslabel];
		Apluslabel.text=PROFILE_USER_A_STRING;
		
		NApluslabel=[[UILabel alloc] initWithFrame:CGRectMake(225, 90, 80, 20)];
		[self addSubview:NApluslabel];

		
		chanegePhotoBtn =[[UIButton alloc] initWithFrame:CGRectMake(140, 115, 100, 35)];
		[chanegePhotoBtn setBackgroundImage:[UIImage imageNamed:@"button-2.png"] forState:UIControlStateNormal];
		[self addSubview:chanegePhotoBtn];

		
		[chanegePhotoBtn setTitle:PROFILE_USER_CHANGEPHOTO_STRING forState:UIControlStateNormal];
		[chanegePhotoBtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
		[chanegePhotoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		//chanegePhotoBtn.hidden=YES;
		
		imageLoader=[[ACImageLoader alloc] init];
		imageLoader.delegate=self;
		
    }
    return self;
}


- (void)dealloc {
    
    imageLoader.delegate=nil;
    [imageLoader cancelDownload];
    
	
	[userPhotoImageView release];
	[namelabel release];
	[fanlabel release];
	[missionlabel release];
	[Apluslabel release];
	
	[Nfanlabel release];
	[Nmissionlabel release];
	[NApluslabel release];
	[chanegePhotoBtn release];
	
	[imageLoader release];
    [super dealloc];
}

#pragma mark ACImageDidLoad Delegate and Function Methods

- (void)ACImageDidLoad:(ACImageLoader *)imageloader
{
	if (imageloader.image != nil)
	{
		userPhotoImageView.image=imageloader.image;
	}	 
}


@end
