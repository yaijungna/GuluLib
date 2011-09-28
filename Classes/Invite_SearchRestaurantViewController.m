//
//  Invite_SearchRestaurantViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "Invite_SearchRestaurantViewController.h"


@implementation Invite_SearchRestaurantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
	[self.view addSubview:topView];
	[topView release];
	
	[topView.topLeftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
	UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 55, 300, 20)];
	[self.view addSubview:titleLabel];
	[titleLabel release];
	[self customizeLabel_title:titleLabel];
	titleLabel.text=INVITE_WHERE_EVENT_STRING;
    
    [self customizeTextField:searchTextField];
    
    searchVC=[[SearchRestaurantViewController alloc] initWithNibName:@"SearchRestaurantViewController" bundle:nil];
    searchVC.searchTextField=searchTextField;
    [myView addSubview:searchVC.view];
    searchVC.delegate=self;
    searchVC.navigationController=self.navigationController;
    [searchVC.table setFrame:CGRectMake(0, 0, myView.frame.size.width, myView.frame.size.height)];
    searchVC.allowAddNewPlace=NO;
    
    /*
    searchVC=[[SearchDishViewController alloc] initWithNibName:@"SearchDishViewController" bundle:nil];
    searchVC.searchTextField=searchTextField;
    [myView addSubview:searchVC.view];
    searchVC.delegate=self;
    [searchVC.table setFrame:CGRectMake(0, 0, myView.frame.size.width, myView.frame.size.height)];
     */
}

- (void)dealloc {
    [searchVC release];
    [super dealloc];
}

#pragma mark -
#pragma mark action Function Methods

- (void)backAction 
{
	//[table.network cancelAllRequestsInRequestsQueue];
	//[self cancelImageLoaders:table.imageLoaderDictionary_post ];
    
    self.view.userInteractionEnabled=YES;
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark delegate Methods

- (void) selectedDictionary:(NSMutableDictionary *)dict;
{
    self.view.userInteractionEnabled=NO;
    
    [self shareGULUAPP];
    
    appDelegate.temp.inviteObj.restaurantDict=[[[NSMutableDictionary alloc] initWithDictionary:dict] autorelease];
    
  //  [network cancelAllRequestsInRequestsQueue];
  //  [self cancelImageLoaders:imageLoaderDictionary_post];
    
    
    [self performSelector:@selector(backAction) withObject:nil afterDelay:0.6];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectRestaurant" object:nil];
    
    
}


@end
