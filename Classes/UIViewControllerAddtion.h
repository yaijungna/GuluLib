//
//  UIViewControllerAddtion.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "TopMenuBarView.h"
#import "BottomMenuBarView.h"
#import "AppSettings.h"
#import "ACNetworkManager.h"

#import "loadingSpinnerAndMessageView.h"
#import "ACUtility.h"
#import "ACImageLoader.h"
#import "ACCheckConnection.h"
#import "TSAlertView.h"


#import "settingsModel.h"
#import "userMeModel.h"
#import "TempModel.h"
#import "ASIFormDataRequest.h"
#import "ACNetworkManager.h"
#import "API_URL_USER.h"

#import "GULUAPPAppDelegate.h"


GULUAPPAppDelegate *appDelegate;

@interface UIViewController(MyAdditions)


-(void)shareGULUAPP;

-(void)showDebugErrorString :(NSData *) data;

-(void)showSpinnerView :(loadingSpinnerAndMessageView *) spinview mesage:(NSString *)str;
-(void)hideSpinnerView :(loadingSpinnerAndMessageView *) spinview;

-(void)showErrorAlert:(NSString *)errorString;
-(void)showOKAlert:(NSString *)errorString;
-(void)showWarningAlert:(NSString *)errorString;

- (void)iamhungry ;

-(UILabel	  *)customizeLabel		:(UILabel	  *) textlabel;
-(UILabel	  *)customizeLabel_title:(UILabel	  *) textlabel;
-(UITextField *)customizeTextField	:(UITextField *) textfield;
-(UITextView  *)customizeTextView	:(UITextView  *) textview;
-(UITableView *)customizeTableView	:(UITableView *) tableview;
-(UIImageView *)customizeImageView	:(UIImageView *) imageView;
-(UIImageView *)customizeImageView_cell	:(UIImageView *) imageView;

-(void)moveTheView:(id) view movwToPosition :(CGPoint)position;

-(float)calculateDistanceFromUserToPlace :(CLLocation*)to;

- (void)cancelImageLoaders:(NSMutableDictionary *)dict;



@end


//================================================




