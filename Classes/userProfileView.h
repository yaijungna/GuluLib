//
//  userProfileView.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/20.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSettings.h"
#import "AppStrings_profile.h"
#import "ACImageLoader.h"

@interface userProfileView : UIView <ACImageDownloaderDelegate> {
	UIImageView *userPhotoImageView;
	UILabel *namelabel;
	
	UILabel *fanlabel;
	UILabel *Nfanlabel;
	UILabel *missionlabel;
	UILabel *Nmissionlabel;
	UILabel *Apluslabel;
	UILabel *NApluslabel;
	UIButton *chanegePhotoBtn;
	
	ACImageLoader *imageLoader;
}

@property (nonatomic,retain)UIImageView *userPhotoImageView;
@property (nonatomic,retain)UILabel *namelabel;
@property (nonatomic,retain)UILabel *fanlabel;
@property (nonatomic,retain)UILabel *missionlabel;
@property (nonatomic,retain)UILabel *Apluslabel;
@property (nonatomic,retain)UILabel *Nfanlabel;
@property (nonatomic,retain)UILabel *Nmissionlabel;
@property (nonatomic,retain)UILabel *NApluslabel;
@property (nonatomic,retain)UIButton *chanegePhotoBtn;

@property (nonatomic,retain)ACImageLoader *imageLoader;


@end
