//
//  ACTableAroundMeCell.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/19.
//  Copyright 2011 Gulu.com. All rights reserved.
//


#define AROUNDME_TEXT_FONT          [UIFont fontWithName:FONT_BOLD size:14]
#define AROUNDME_BTN_MAX_SIZE       CGSizeMake(140, 20)
#define AROUNDME_REVIEW_FONT        [UIFont fontWithName:FONT_NORMAL size:12]
#define AROUNDME_REVIEW_MAX_SIZE    CGSizeMake(300, 1000)


#import <UIKit/UIKit.h>
#import "AppSettings.h"
#import "ACTableViewCell.h"
#import "ACCreateButtonClass.h"
#import "ACButtonWithLeftImage.h"

#import "GuluUtility.h"

@interface ACTableAroundMeCell : ACTableViewCell {
	IBOutlet ACButtonWithLeftImage *likeBtn;
	IBOutlet ACButtonWithLeftImage *commentBtn;
	IBOutlet UIButton *moreBtn;
	
    IBOutlet UIButton   *firstBtn;
	IBOutlet UILabel    *atlabel;
    IBOutlet UIButton   *secondBtn;
    
    IBOutlet UILabel    *reviewlabel;
	
	IBOutlet UIImageView	*bigPhotoImageView;
    UIImageView  *rightViewImage;
    
    NSString *dishName;
    NSString *placeName;
    NSString *review;
    
}

@property (nonatomic,retain)IBOutlet ACButtonWithLeftImage *likeBtn;
@property (nonatomic,retain)IBOutlet ACButtonWithLeftImage *commentBtn;
@property (nonatomic,retain)IBOutlet UIButton *moreBtn;

@property (nonatomic,retain)IBOutlet UIButton *firstBtn;
@property (nonatomic,retain)IBOutlet UIButton *secondBtn;
@property (nonatomic,retain)IBOutlet UILabel  *atlabel;

@property (nonatomic,retain)IBOutlet UILabel  *reviewlabel;

@property (nonatomic,retain)IBOutlet UIImageView	*bigPhotoImageView;
@property (nonatomic,retain)IBOutlet UIImageView  *rightViewImage;

@property (nonatomic,retain) NSString *dishName;
@property (nonatomic,retain) NSString *placeName;
@property (nonatomic,retain) NSString *review;


-(NSInteger)sizeToFitTitle;

@end
