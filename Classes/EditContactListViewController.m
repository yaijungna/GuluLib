//
//  EditContactListViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "EditContactListViewController.h"


@implementation EditContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeDone];
	[self.view addSubview:topView];
	[topView release];
	[topView.topLeftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topRightButton addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
	
	contactList = 	[[EditChoseContactListTableViewController  alloc] init];
	[myView addSubview:contactList.view];
}


- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
	
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
}


- (void)dealloc {
	[contactList release];
    [super dealloc];
}


- (void)backAction 
{
	[contactList.network cancelAllRequestsInRequestsQueue];
	[self cancelImageLoaders:contactList.imageLoaderDictionary_post];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)doneAction 
{	
	[contactList.network cancelAllRequestsInRequestsQueue];
	[self cancelImageLoaders:contactList.imageLoaderDictionary_post];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeContactList" object:nil];
	
	[self.navigationController popViewControllerAnimated:YES];
}



@end
