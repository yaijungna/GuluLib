//
//  RootViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "RootViewController.h"
#import "UIViewControllerAddtion.h"


#import "signInsignUpLandingPageViewController.h"


#import "landingPageViewController.h"  //test 

#import "MyGuluViewController.h"
#import "ChatLandingViewController.h"
#import "PostLandingViewController.h"
#import "MissionLandingViewController.h"
#import "SearchLandingViewContorller.h"



@implementation RootViewController

@synthesize tabVC,tabVCLastSelected;
@synthesize userMe;


- (void)LoadSignInLandingPage
{
	signInsignUpLandingPageViewController *VC=[ [signInsignUpLandingPageViewController alloc] initWithNibName:@"signInsignUpLandingPageViewController" bundle:nil];
	
	UINavigationController *signinNavigationController = [[UINavigationController alloc] initWithRootViewController:VC];
	signinNavigationController.delegate=self;
	VC.navigationController.navigationBar.hidden=YES;
	VC.hidesBottomBarWhenPushed=YES;
	[self presentModalViewController:signinNavigationController animated:NO];
	[signinNavigationController release];
	[VC release];
}

#pragma mark -

- (void)navigationController:(UINavigationController *)navigationController 
	   didShowViewController:(UIViewController *)viewController 
					animated:(BOOL)animated 
{
	//[viewController viewDidAppear:animated];
}

-(void) initTabBarController
{
	tabVC=[[ACTabBarController alloc] init];
	[tabVC.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];

	NSMutableArray *localControllersArray = [[NSMutableArray alloc] initWithCapacity:5];
	UINavigationController *localNavigationController;
	
	//set-up the First View Controller
	
	firstView=[ [MyGuluViewController alloc] initWithNibName:@"MyGuluViewController" bundle:nil];
	localNavigationController = [[UINavigationController alloc] initWithRootViewController:firstView];
	localNavigationController.delegate=self;
	firstView.navigationController.navigationBar.hidden=YES;
	firstView.hidesBottomBarWhenPushed=YES;
	[localControllersArray addObject:localNavigationController];
	[localNavigationController release];

 
	
	//set-up the First View Controller
/*	landingPageViewController *firstView=[ [landingPageViewController alloc] initWithNibName:@"landingPageViewController" bundle:nil];
	localNavigationController = [[UINavigationController alloc] initWithRootViewController:firstView];
	localNavigationController.delegate=self;
	firstView.navigationController.navigationBar.hidden=YES;
	firstView.hidesBottomBarWhenPushed=YES;
	[localControllersArray addObject:localNavigationController];
	[localNavigationController release];
	[firstView release];
*/	
	
	//set-up the Second View Controller
	secondView=[ [ChatLandingViewController alloc] initWithNibName:@"ChatLandingViewController" bundle:nil];
	localNavigationController = [[UINavigationController alloc] initWithRootViewController:secondView];
	localNavigationController.delegate=self;
	secondView.navigationController.navigationBar.hidden=YES;
	secondView.hidesBottomBarWhenPushed=YES;
	[localControllersArray addObject:localNavigationController];
	[localNavigationController release];

	
	//set-up the Third View Controller
	thirdView=[ [PostLandingViewController alloc] initWithNibName:@"PostLandingViewController" bundle:nil];
	localNavigationController = [[UINavigationController alloc] initWithRootViewController:thirdView];
	localNavigationController.delegate=self;
	thirdView.navigationController.navigationBar.hidden=YES;
	thirdView.hidesBottomBarWhenPushed=YES;
	[localControllersArray addObject:localNavigationController];
	[localNavigationController release];

	
	//set-up the Fourth View Controller
	fourthView=[ [MissionLandingViewController alloc] initWithNibName:@"MissionLandingViewController" bundle:nil];
	localNavigationController = [[UINavigationController alloc] initWithRootViewController:fourthView];
	localNavigationController.delegate=self;
	fourthView.navigationController.navigationBar.hidden=YES;
	fourthView.hidesBottomBarWhenPushed=YES;
	[localControllersArray addObject:localNavigationController];
	[localNavigationController release];

	
	//set-up the Fifth View Controller
	fifthView=[ [SearchLandingViewContorller alloc] initWithNibName:@"SearchLandingViewContorller" bundle:nil];
	localNavigationController = [[UINavigationController alloc] initWithRootViewController:fifthView];
	localNavigationController.delegate=self;
	fifthView.navigationController.navigationBar.hidden=YES;
	fifthView.hidesBottomBarWhenPushed=YES;
	[localControllersArray addObject:localNavigationController];
	[localNavigationController release];
	
	// load up our tab bar controller with the view controllers
	tabVC.viewControllers = localControllersArray;
	[localControllersArray release];
	[self.view addSubview:tabVC.view];   
	
	tabVC.selectedViewController=[[tabVC viewControllers] objectAtIndex: 0];
	tabVCLastSelected=0;

}

- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{	
    
   [self checkuserlogin];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
	[tabVC release];
	[userMe release];
    
    [firstView release];
    [secondView release];
    [thirdView release ];
    [fourthView release];
    [fifthView release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark Called to handle a user login

- (void)checkuserlogin
{
    userMe = [userMeModel sharedManager] ;
    [self shareGULUAPP];
    
    appDelegate.myLoaction=[[[CLLocation alloc] initWithLatitude: 25.02187858
                                                       longitude:121.54773698] autorelease];
    
    if( userMe.uid != nil )
    {
        
        
        
        appDelegate.userMe=userMe;
        appDelegate.GuluUser=[[[GuluUserModel alloc] init] autorelease];
        appDelegate.GuluUser.ID=appDelegate.userMe.uid;
        appDelegate.GuluUser.username=@"alanchen";
        
        GuluAPIAccessManager *APIManager=[GuluAPIAccessManager sharedManager];
        [APIManager initUserIDandSeesionKey:appDelegate.GuluUser.ID
                                 sessionKey:userMe.sessionKey 
                                        lat:25.02187858 
                                        lng:121.54773698];
        
        
        [self initTabBarController];
        [appDelegate sendDeviceToken];
    }
    else
    {		
        [self LoadSignInLandingPage];
    }
}



@end
