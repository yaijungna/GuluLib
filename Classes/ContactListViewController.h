//
//  ContactListViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/22.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "choseContactListTableViewController.h"

@interface ContactListViewController : UIViewController {
		
	TopMenuBarView *topView;
	BottomMenuBarView *bottomView;
	
	choseContactListTableViewController *contactList;
	
	IBOutlet UIView *myView;
	
}

@end
