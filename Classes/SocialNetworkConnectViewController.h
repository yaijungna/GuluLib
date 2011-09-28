//
//  SocialNetworkConnectViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/14.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_Connection_SigninSignUp.h"
#import "facebookConnectionModel.h"
#import "API_URL_USER.h"

@interface SocialNetworkConnectViewController : UIViewController<facebookDelegate,UIWebViewDelegate> {
	IBOutlet UIWebView *webview;
	facebookConnectionModel *fbObject;
	
	ACNetworkManager *network;
	loadingSpinnerAndMessageView *checkingView;	
	TopMenuBarView *topView;
}

@end
