//
//  PostLandingViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/7.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "PostLandingViewController.h"


#import "PostReviewViewContorller.h"
#import "TempModel.h"
#import "postModel.h"


#import "ACCheckBox.h"


@implementation PostLandingViewController

- (IBAction)gotoCamera
{
	imagePicker =[ACCameraViewController sharedManager];
	imagePicker.ACDelegate=self;
	[self presentModalViewController:imagePicker animated:NO];
}

- (IBAction)gotoPostWithoutCamera
{
	[self shareGULUAPP];
	
	if(appDelegate.temp.postObj ==nil )
	{
		postModel *post=[[[postModel alloc] init] autorelease];	
		appDelegate.temp.postObj=post;
	}

	appDelegate.gotoLastPageFromPost=YES;
	
	PostReviewViewContorller *VC=[[PostReviewViewContorller alloc] initWithNibName:@"PostReviewViewContorller" bundle:nil];	
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];

}


- (void)viewDidLoad {
	[super viewDidLoad];
	[self shareGULUAPP];
	
	/*
	bottomView=[[[BottomMenuBarView alloc] initWithFrame:CGRectMake(0, 410, 320, 50)] initBottomBarView:ButtonTypeMyGulu second:ButtonTypeChat third:ButtonTypePost forth:ButtonTypeMissions fifth:ButtonTypeSearch];
	[bottomView setUpMainBtnAction];
	[self.view addSubview:bottomView];
	[bottomView release];
	 */
	
	bottomView=[[[BottomMenuBarView alloc] initWithFrame:CGRectMake(0, 410, 320, 50)] initFourBottomsBarBottomView:ButtonTypeMyGulu second:ButtonTypeChat third:ButtonTypePost  forth:ButtonTypeSearch];
	[bottomView setUpMainBtnAction2];
	[self.view addSubview:bottomView];
	[bottomView release];
	
//	[self gotoCamera];
	
} 

-(void)viewDidAppear:(BOOL)animated
{	
	
	NSLog(@"%d",appDelegate.rootVC.tabVCLastSelected);
	
	if(appDelegate.gotoLastPageFromPost==YES)
	{
		appDelegate.gotoLastPageFromPost=NO;
		
		if(appDelegate.rootVC.tabVCLastSelected == 0 )
		{
			[bottomView firstBtnAction];
		}
		else if(appDelegate.rootVC.tabVCLastSelected == 1 )
		{
			[bottomView secondBtnAction];
		}
		else if(appDelegate.rootVC.tabVCLastSelected == 2 )
		{
			[bottomView thirdBtnAction];
		}
		else if(appDelegate.rootVC.tabVCLastSelected == 3 )
		{
			[bottomView fourthBtnAction];
		}
		else if(appDelegate.rootVC.tabVCLastSelected == 4 )
		{
			[bottomView fifthBtnAction];
		}
		
	}

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
		
}

- (void)dealloc {
	
    [super dealloc];
}


- (void)ACCameraViewControllerDelegateDidFinishPickingImage:(UIImage *)image
{
	[self dismissModalViewControllerAnimated:NO];
	
	[self shareGULUAPP];
	
	if(appDelegate.temp.postObj ==nil )
	{
		postModel *post=[[[postModel alloc] init] autorelease];	
		appDelegate.temp.postObj=post;
	}
	
	appDelegate.temp.postObj.photo=image;

	appDelegate.gotoLastPageFromPost=YES;
	
	PostReviewViewContorller *VC=[[PostReviewViewContorller alloc] initWithNibName:@"PostReviewViewContorller" bundle:nil];	
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];
	
}

- (void)ACCameraViewControllerDelegateCancelImagePicker
{
	appDelegate.gotoLastPageFromPost=YES;
	[self dismissModalViewControllerAnimated:NO];
	NSLog(@"%d",appDelegate.rootVC.tabVCLastSelected);
}





@end
