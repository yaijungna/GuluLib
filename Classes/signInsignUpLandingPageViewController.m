//
//  signInsignUpLandingPageViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/13.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "signInsignUpLandingPageViewController.h"
#import "signInViewController.h"
#import "signUpViewController.h"


@implementation signInsignUpLandingPageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.autoresizesSubviews=NO;
	pageViewController.ACDelegate=self;
	[pageViewController initScrollView];
	
	bottomView=[[[BottomMenuBarView alloc] initWithFrame:CGRectMake(0, 410, 320, 50)] initBottomBarView:ButtonTypeMyGulu second:ButtonTypeChat third:ButtonTypePost forth:ButtonTypeMissions fifth:ButtonTypeSearch];
	[self.view addSubview:bottomView];
	[bottomView release];
	
	[((ACButtonWIthBottomTitle *) bottomView.bottomButton1).btn addTarget:self action:@selector(bottomIconToSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
	[((ACButtonWIthBottomTitle *) bottomView.bottomButton2).btn addTarget:self action:@selector(bottomIconToSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
	[((ACButtonWIthBottomTitle *) bottomView.bottomButton3).btn addTarget:self action:@selector(bottomIconToSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
	[((ACButtonWIthBottomTitle *) bottomView.bottomButton4).btn addTarget:self action:@selector(bottomIconToSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
	[((ACButtonWIthBottomTitle *) bottomView.bottomButton5).btn addTarget:self action:@selector(bottomIconToSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
	
	bottomView.userInteractionEnabled=NO;
	
	[btnSignUp setTitle:SIGN_UP_STRING forState:UIControlStateNormal ];
	[btnSignIn setTitle:SIGN_IN_STRING forState:UIControlStateNormal ];
	
	[btnSignUp.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:18]];
	[btnSignIn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:18]];
	
	[btnSignUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[btnSignIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	
	[btnSignUp addTarget:self action:@selector(signUpAction) forControlEvents:UIControlEventTouchUpInside];
	[btnSignIn addTarget:self action:@selector(signInAction) forControlEvents:UIControlEventTouchUpInside];

	pageController.numberOfPages=5;	
	pageController.currentPage=0;
	[pageController updateDots];
	
	[self setBottomIconToSelected:0];
    
    crash =[[crashreportModel alloc] initWithViewController:self] ;
}

-(void)viewDidAppear:(BOOL)animated
{	
    [crash handleCrashReport];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
  
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [crash release];
    [super dealloc];
}

- (void)bottomIconToSelectedAction :(UIButton *)btn
{
/*	if(btn==((ACButtonWIthBottomTitle *) bottomView.bottomButton1).btn)
	{
		[pageViewController gotoCurrentPage:0];
	}
	else if(btn==((ACButtonWIthBottomTitle *) bottomView.bottomButton2).btn)
	{
		[pageViewController gotoCurrentPage:1];
	}
	else if(btn==((ACButtonWIthBottomTitle *) bottomView.bottomButton3).btn)
	{
		[pageViewController gotoCurrentPage:2];
	}
	else if(btn==((ACButtonWIthBottomTitle *) bottomView.bottomButton4).btn)
	{
		[pageViewController gotoCurrentPage:3];
	}
	else if(btn==((ACButtonWIthBottomTitle *) bottomView.bottomButton5).btn)
	{
		[pageViewController gotoCurrentPage:4];
	}
*/	
	

}

- (void)setBottomIconToSelected :(NSInteger)index
{
	ACButtonWIthBottomTitle *btn=(ACButtonWIthBottomTitle *) bottomView.bottomButton1;
	
    switch (index) {
		case 0:
			btn=(ACButtonWIthBottomTitle *) bottomView.bottomButton1 ;
			break;
			
		case 1:
			btn=(ACButtonWIthBottomTitle *) bottomView.bottomButton2 ;
			break;

		case 2:
			btn=(ACButtonWIthBottomTitle *) bottomView.bottomButton3 ;
			break;

		case 3:
			btn=(ACButtonWIthBottomTitle *) bottomView.bottomButton4 ;
			break;

		case 4:
			btn=(ACButtonWIthBottomTitle *) bottomView.bottomButton5 ;
			break;
			
		default:
			break;
	}
	
	((ACButtonWIthBottomTitle *) bottomView.bottomButton1 ).imgView.image=((ACButtonWIthBottomTitle *) bottomView.bottomButton1 ).normalImage;
	((ACButtonWIthBottomTitle *) bottomView.bottomButton2 ).imgView.image=((ACButtonWIthBottomTitle *) bottomView.bottomButton2 ).normalImage;
	((ACButtonWIthBottomTitle *) bottomView.bottomButton3 ).imgView.image=((ACButtonWIthBottomTitle *) bottomView.bottomButton3 ).normalImage;
	((ACButtonWIthBottomTitle *) bottomView.bottomButton4 ).imgView.image=((ACButtonWIthBottomTitle *) bottomView.bottomButton4 ).normalImage;
	((ACButtonWIthBottomTitle *) bottomView.bottomButton5 ).imgView.image=((ACButtonWIthBottomTitle *) bottomView.bottomButton5 ).normalImage;
	
	btn.imgView.image=btn.hightlightImage;
	
	
}


- (void)signInAction {
	
    
	signInViewController *VC=[[signInViewController alloc] initWithNibName:@"signInViewController" bundle:nil];	
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];
    
    /*
    NSArray *arr=[[NSArray alloc] init];
    [arr objectAtIndex:0];
    */
}

- (void)signUpAction {
	
	signUpViewController *VC=[[signUpViewController alloc] initWithNibName:@"signUpViewController" bundle:nil];	
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];
 
}

#pragma mark -
#pragma mark page delegate Methods

-(NSInteger ) ACPagableScrollViewNumberOfPage{return 5;}

-(NSInteger ) ACPagableScrollViewStartAtIndex{return 0;}

-(void) ACPagableScrollViewAtIndexOfScrollView : (id)viewAtIndex currentIndex:(NSInteger)index;
{
	
	NSArray *temparray=[viewAtIndex subviews];
	for(id tempObj in temparray)
	{
	//	NSLog(@"%@",tempObj);
		[tempObj removeFromSuperview];
	}
	
	if(index==0)
	{
		myguluView *View=[[[myguluView alloc] initWithFrame:CGRectMake(10, 0, 300, 300)] autorelease];
		[viewAtIndex addSubview:View];
	}
	else if(index==1)
	{
		chatView *View=[[[chatView alloc] initWithFrame:CGRectMake(10, 0, 300, 300)] autorelease];
		[viewAtIndex addSubview:View];
	}
	else if(index==2)
	{
		postView *View=[[[postView alloc] initWithFrame:CGRectMake(10, 0, 300, 300)] autorelease];
		[viewAtIndex addSubview:View];
	}
	else if(index==3)
	{
		missionView *View=[[[missionView alloc] initWithFrame:CGRectMake(10, 0, 300, 300)] autorelease];
		[viewAtIndex addSubview:View];
	}
	else if(index==4)
	{
		searchView *View=[[[searchView alloc] initWithFrame:CGRectMake(10, 0, 300, 300)] autorelease];
		[viewAtIndex addSubview:View];
	}
	
	pageController.currentPage=index;
	[self setBottomIconToSelected:index];
	
}

-(NSString *) ACPagableScrollViewClassOfView
{
	return @"UIView";
}





@end
