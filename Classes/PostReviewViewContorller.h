//
//  PostReviewViewContorller.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/8.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_Post.h"
#import "UIViewControllerAddtion_Connection_MyGulu.h"

#import "SearchRestaurantViewController.h"
#import "SearchDishViewController.h"
#import "bestKnownForViewController.h"

#import "ACTableOneLineCell.h"
#import "ACCameraViewController.h"

#import "ACSlider.h"
#import "guluApprovedView.h"

@interface PostReviewViewContorller : UIViewController <ACSliderDelegate,ACCameraViewControllerDelegate,TSAlertViewDelegate,UITextFieldDelegate,UITextViewDelegate,SearchDishDelegate,SearchRestaurantDelegate>
{	
	TopMenuBarView *topView;
	BottomMenuBarView *bottomView;
	loadingSpinnerAndMessageView *spinView;
    
    ACCameraViewController *imagePicker;
	
    IBOutlet UIScrollView *ScrollView;
	IBOutlet UIImageView *photoImageView;
	IBOutlet UIButton	 *photobtn;
	IBOutlet UITextField *placeTextField;
	IBOutlet UITextField *dishTextField;
    IBOutlet UITextField *bestknowforTextField;
    
    IBOutlet UIButton	*thumbUpButton;
	IBOutlet UIButton	*thumbDownButton;
    
    IBOutlet UIView *subview;
    
    IBOutlet UIView *reviewInfoview;
	IBOutlet UITextView	 *reviewTextView;
	IBOutlet UIButton	*submitBtn;
    IBOutlet UIButton	*saveBtn;
    
    ACSlider *slider;
    
    SearchRestaurantViewController *placeVC;
    SearchDishViewController *dishVC;
	
	TSAlertView *postWarningAlert;
    TSAlertView *postFinishAlert;
    TSAlertView *postSubmitConfirmAlert;
    
	postModel *post;

}

- (void)textFieldEditingBegin:(UITextField *)field;
- (void)textViewDidBeginEditing:(UITextView *)textView;

@property (nonatomic ,retain) postModel *post;
@property (nonatomic ,retain) TSAlertView *postWarningAlert;
@property (nonatomic ,retain) TSAlertView *postFinishAlert;
@property (nonatomic ,retain) TSAlertView *postSubmitConfirmAlert;

@end
