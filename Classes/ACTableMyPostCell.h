//
//  ACTableMyPostCell.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/19.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSettings.h"
#import "ACTableViewCell.h"
#import "ACCreateButtonClass.h"
#import "ACButtonWithLeftImage.h"

@interface ACTableMyPostCell : ACTableViewCell {
	IBOutlet ACButtonWithLeftImage *likeBtn;
	IBOutlet ACButtonWithLeftImage *commentBtn;
	IBOutlet UIButton *moreBtn;
	
	IBOutlet UILabel	*labelTitle;
	IBOutlet UILabel	*labelSubtitle;
	
	IBOutlet UITextView	*contentTextView;
	
	IBOutlet UIImageView	*bigPhotoImageView;
	IBOutlet UIImageView	*bestKnownImageView;
}

@property (nonatomic,retain)IBOutlet ACButtonWithLeftImage *likeBtn;
@property (nonatomic,retain)IBOutlet ACButtonWithLeftImage *commentBtn;
@property (nonatomic,retain)IBOutlet UIButton *moreBtn;

@property (nonatomic,retain)IBOutlet UILabel	*labelTitle;
@property (nonatomic,retain)IBOutlet UILabel	*labelSubtitle;

@property (nonatomic,retain)IBOutlet UITextView	*contentTextView;

@property (nonatomic,retain)IBOutlet UIImageView	*bigPhotoImageView;
@property (nonatomic,retain)IBOutlet UIImageView	*bestKnownImageView;


@end
