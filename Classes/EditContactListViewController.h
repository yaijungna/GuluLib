//
//  EditContactListViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "EditChoseContactListTableViewController.h"

@interface EditContactListViewController : UIViewController {
	
	TopMenuBarView *topView;
	BottomMenuBarView *bottomView;
	
	EditChoseContactListTableViewController *contactList;
	
	IBOutlet UIView *myView;
	
}

@end
