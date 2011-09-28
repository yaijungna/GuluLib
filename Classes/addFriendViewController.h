//
//  addFriendViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "ACCameraViewController.h"


#import "UIViewControllerAddtion_Connection_Friend.h"
#import "UIViewControllerAddtion_Connection_Post.h"

@interface addFriendViewController : UIViewController<UITextFieldDelegate,ACCameraViewControllerDelegate> {
	
	ACNetworkManager *network;
	TopMenuBarView *topView;
	loadingSpinnerAndMessageView *LoadingView;

	IBOutlet UILabel     *titlelabel;
	IBOutlet UIImageView *bgView;
	IBOutlet UIImageView *photoImageView;
	IBOutlet UITextField *nameTextField;
	IBOutlet UITextField *emailTextField;
	IBOutlet UITextField *phoneTextField;
	IBOutlet UIButton	 *startButton;
	IBOutlet UILabel	 *favoriteLabel;
	IBOutlet UIButton	 *addButton;
	
	IBOutlet UIButton	 *photoButton;
	
	ACCameraViewController *imagePicker;
	
	NSDictionary *photoDict;
	BOOL isUplaodingphoto;

}

@property (nonatomic,retain)NSDictionary *photoDict;

@end
