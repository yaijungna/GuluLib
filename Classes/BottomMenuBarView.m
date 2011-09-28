//
//  BottomMenuBarView.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/31.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "BottomMenuBarView.h"
#import "GULUAPPAppDelegate.h"
#import "ACButtonWIthBottomTitle.h"

#import "PostLandingViewController.h"


@implementation BottomMenuBarView

@synthesize bottomBackgroundImageView,bottomButton1,bottomButton2,bottomButton3,bottomButton4,bottomButton5;

- (void)dealloc {
	[bottomBackgroundImageView release];
	[bottomButton1 release];
	[bottomButton2 release];
	[bottomButton3 release];
	[bottomButton4 release];
	[bottomButton5 release];
    [super dealloc];
}

-(id) initBottomBarView:(ButtonType)Type1 
				   second:(ButtonType)Type2
					third:(ButtonType)Type3
					forth:(ButtonType)Type4
					fifth:(ButtonType)Type5
{	
	self.bottomBackgroundImageView=[[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] autorelease];
	bottomBackgroundImageView.image=[UIImage imageNamed:@"bottom-bar.png"];
	[self addSubview:bottomBackgroundImageView];
	
	self.bottomButton1=[ACCreateButtonClass createButton:Type1];
	self.bottomButton2=[ACCreateButtonClass createButton:Type2];
	self.bottomButton3=[ACCreateButtonClass createButton:Type3];
	self.bottomButton4=[ACCreateButtonClass createButton:Type4];
	self.bottomButton5=[ACCreateButtonClass createButton:Type5];
	
	[self addSubview:bottomButton1];
	[self addSubview:bottomButton2];
	[self addSubview:bottomButton3];
	[self addSubview:bottomButton4];
	[self addSubview:bottomButton5];

	
	//=======================================
	
	CGSize Size1=((UIView *)bottomButton1).frame.size;
	CGSize Size2=((UIView *)bottomButton2).frame.size;
	CGSize Size3=((UIView *)bottomButton3).frame.size;
	CGSize Size4=((UIView *)bottomButton4).frame.size;
	CGSize Size5=((UIView *)bottomButton5).frame.size;
	
	[bottomButton1 setFrame:CGRectMake(0	, self.frame.size.height-Size1.height, Size1.width, Size1.height)];
	[bottomButton2 setFrame:CGRectMake(64	, self.frame.size.height-Size2.height, Size2.width, Size2.height)];
	[bottomButton3 setFrame:CGRectMake(128	, self.frame.size.height-Size3.height, Size3.width, Size3.height)];
	[bottomButton4 setFrame:CGRectMake(192	, self.frame.size.height-Size4.height, Size4.width, Size4.height)];
	[bottomButton5 setFrame:CGRectMake(256	, self.frame.size.height-Size5.height, Size5.width, Size5.height)];
	
	return self;
}

-(void) setUpMainBtnAction
{
	[((ACButtonWIthBottomTitle *)bottomButton1).btn addTarget:self action:@selector(firstBtnAction) forControlEvents:UIControlEventTouchUpInside];
	[((ACButtonWIthBottomTitle *)bottomButton2).btn addTarget:self action:@selector(secondBtnAction) forControlEvents:UIControlEventTouchUpInside];
	[((ACButtonWIthBottomTitle *)bottomButton3).btn addTarget:self action:@selector(thirdBtnAction) forControlEvents:UIControlEventTouchUpInside];
	[((ACButtonWIthBottomTitle *)bottomButton4).btn addTarget:self action:@selector(fourthBtnAction) forControlEvents:UIControlEventTouchUpInside];
	[((ACButtonWIthBottomTitle *)bottomButton5).btn addTarget:self action:@selector(fifthBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void) setUpMainBtnAction2
{
	[((ACButtonWIthBottomTitle *)bottomButton1).btn addTarget:self action:@selector(firstBtnAction) forControlEvents:UIControlEventTouchUpInside];
	[((ACButtonWIthBottomTitle *)bottomButton2).btn addTarget:self action:@selector(secondBtnAction) forControlEvents:UIControlEventTouchUpInside];
	[((ACButtonWIthBottomTitle *)bottomButton3).btn addTarget:self action:@selector(thirdBtnAction) forControlEvents:UIControlEventTouchUpInside];
	[((ACButtonWIthBottomTitle *)bottomButton4).btn addTarget:self action:@selector(fifthBtnAction) forControlEvents:UIControlEventTouchUpInside];
//	[((ACButtonWIthBottomTitle *)bottomButton5).btn addTarget:self action:@selector(fifthBtnAction) forControlEvents:UIControlEventTouchUpInside];
}


-(void) setUpMainBtnSelected:(NSInteger)index
{
    
	switch (index) 
	{
		case 0:
			((ACButtonWIthBottomTitle *)bottomButton1).imgView.image=[UIImage imageNamed:@"active-my-gulu-icon-1.png"];
			((ACButtonWIthBottomTitle *)bottomButton1).btn.userInteractionEnabled=NO;
             [((ACButtonWIthBottomTitle *)bottomButton1).btnTitleLabel setTextColor:[UIColor whiteColor]];
			break;
		case 1:
			((ACButtonWIthBottomTitle *)bottomButton2).imgView.image=[UIImage imageNamed:@"active-chat-icon-1.png"]; 
			((ACButtonWIthBottomTitle *)bottomButton2).btn.userInteractionEnabled=NO;
            [((ACButtonWIthBottomTitle *)bottomButton2).btnTitleLabel setTextColor:[UIColor whiteColor]];
			break;
		case 2:
			((ACButtonWIthBottomTitle *)bottomButton3).imgView.image=[UIImage imageNamed:@"active-post-icon-1.png"];
			((ACButtonWIthBottomTitle *)bottomButton3).btn.userInteractionEnabled=NO;
            [((ACButtonWIthBottomTitle *)bottomButton3).btnTitleLabel setTextColor:[UIColor whiteColor]];
			break;
		case 3:
			((ACButtonWIthBottomTitle *)bottomButton4).imgView.image=[UIImage imageNamed:@"active-mission-icon-1.png"];
			((ACButtonWIthBottomTitle *)bottomButton4).btn.userInteractionEnabled=NO;
            [((ACButtonWIthBottomTitle *)bottomButton4).btnTitleLabel setTextColor:[UIColor whiteColor]];
			break;
		case 4:
			((ACButtonWIthBottomTitle *)bottomButton5).imgView.image=[UIImage imageNamed:@"active-search-icon-1.png"];
			((ACButtonWIthBottomTitle *)bottomButton5).btn.userInteractionEnabled=NO;
            [((ACButtonWIthBottomTitle *)bottomButton5).btnTitleLabel setTextColor:[UIColor whiteColor]];
		//	((ACButtonWIthBottomTitle *)bottomButton4).imgView.image=[UIImage imageNamed:@"active-search-icon-1.png"];
		//	((ACButtonWIthBottomTitle *)bottomButton4).btn.userInteractionEnabled=NO;
			break;
		default:
			break;
	}

}

#pragma mark -

-(void) firstBtnAction
{

	GULUAPPAppDelegate *delegate=(GULUAPPAppDelegate *) [[UIApplication sharedApplication] delegate];
	delegate.gotoLastPageFromPost=NO;
	delegate.rootVC.tabVCLastSelected=delegate.rootVC.tabVC.selectedIndex;
	delegate.rootVC.tabVC.selectedViewController=[[(UINavigationController *)delegate.rootVC.tabVC viewControllers] objectAtIndex: 0];

}
-(void) secondBtnAction
{
	GULUAPPAppDelegate *delegate=(GULUAPPAppDelegate *) [[UIApplication sharedApplication] delegate];
	delegate.gotoLastPageFromPost=NO;
	delegate.rootVC.tabVCLastSelected=delegate.rootVC.tabVC.selectedIndex;
	delegate.rootVC.tabVC.selectedViewController=[[(UINavigationController *)delegate.rootVC.tabVC viewControllers] objectAtIndex: 1];
}
-(void) thirdBtnAction
{
	GULUAPPAppDelegate *delegate=(GULUAPPAppDelegate *) [[UIApplication sharedApplication] delegate];
	delegate.gotoLastPageFromPost=NO;
	delegate.rootVC.tabVCLastSelected=delegate.rootVC.tabVC.selectedIndex;
	delegate.rootVC.tabVC.selectedViewController=[[(UINavigationController *)delegate.rootVC.tabVC viewControllers] objectAtIndex: 2];
	
	PostLandingViewController *VC=[[ ((UINavigationController *)delegate.rootVC.tabVC.selectedViewController) viewControllers] objectAtIndex:0];
	[VC gotoCamera];
	
	NSLog(@"%@",VC);
}
-(void) fourthBtnAction
{
	GULUAPPAppDelegate *delegate=(GULUAPPAppDelegate *) [[UIApplication sharedApplication] delegate];
	delegate.gotoLastPageFromPost=NO;
	delegate.rootVC.tabVCLastSelected=delegate.rootVC.tabVC.selectedIndex;
	delegate.rootVC.tabVC.selectedViewController=[[(UINavigationController *)delegate.rootVC.tabVC viewControllers] objectAtIndex: 3];
}
-(void) fifthBtnAction
{
	GULUAPPAppDelegate *delegate=(GULUAPPAppDelegate *) [[UIApplication sharedApplication] delegate];
	delegate.gotoLastPageFromPost=NO;
	delegate.rootVC.tabVCLastSelected=delegate.rootVC.tabVC.selectedIndex;
	delegate.rootVC.tabVC.selectedViewController=[[(UINavigationController *)delegate.rootVC.tabVC viewControllers] objectAtIndex: 4];
}


#pragma mark -

+(void) firstBtnAction
{
	
	GULUAPPAppDelegate *delegate=(GULUAPPAppDelegate *) [[UIApplication sharedApplication] delegate];
	delegate.gotoLastPageFromPost=NO;
	delegate.rootVC.tabVCLastSelected=delegate.rootVC.tabVC.selectedIndex;
	delegate.rootVC.tabVC.selectedViewController=[[(UINavigationController *)delegate.rootVC.tabVC viewControllers] objectAtIndex: 0];
	
}
+(void) secondBtnAction
{
	GULUAPPAppDelegate *delegate=(GULUAPPAppDelegate *) [[UIApplication sharedApplication] delegate];
	delegate.gotoLastPageFromPost=NO;
	delegate.rootVC.tabVCLastSelected=delegate.rootVC.tabVC.selectedIndex;
	delegate.rootVC.tabVC.selectedViewController=[[(UINavigationController *)delegate.rootVC.tabVC viewControllers] objectAtIndex: 1];
}
+(void) thirdBtnAction
{
	GULUAPPAppDelegate *delegate=(GULUAPPAppDelegate *) [[UIApplication sharedApplication] delegate];
	delegate.gotoLastPageFromPost=NO;
	delegate.rootVC.tabVCLastSelected=delegate.rootVC.tabVC.selectedIndex;
	delegate.rootVC.tabVC.selectedViewController=[[(UINavigationController *)delegate.rootVC.tabVC viewControllers] objectAtIndex: 2];
	
	PostLandingViewController *VC=[[ ((UINavigationController *)delegate.rootVC.tabVC.selectedViewController) viewControllers] objectAtIndex:0];
	[VC gotoCamera];
	
	NSLog(@"%@",VC);
	
}
+(void) fourthBtnAction
{
	GULUAPPAppDelegate *delegate=(GULUAPPAppDelegate *) [[UIApplication sharedApplication] delegate];
	delegate.gotoLastPageFromPost=NO;
	delegate.rootVC.tabVCLastSelected=delegate.rootVC.tabVC.selectedIndex;
	delegate.rootVC.tabVC.selectedViewController=[[(UINavigationController *)delegate.rootVC.tabVC viewControllers] objectAtIndex: 3];
}
+(void) fifthBtnAction
{
	GULUAPPAppDelegate *delegate=(GULUAPPAppDelegate *) [[UIApplication sharedApplication] delegate];
	delegate.gotoLastPageFromPost=NO;
	delegate.rootVC.tabVCLastSelected=delegate.rootVC.tabVC.selectedIndex;
	delegate.rootVC.tabVC.selectedViewController=[[(UINavigationController *)delegate.rootVC.tabVC viewControllers] objectAtIndex: 4];
}


#pragma mark -



-(id) initCameraBottomBarView:(ButtonType)Type1 
					   second:(ButtonType)Type2
{
	
	self.bottomBackgroundImageView=[[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] autorelease];
	bottomBackgroundImageView.image=[UIImage imageNamed:@"bottom-bar.png"];
	[self addSubview:bottomBackgroundImageView];
//	[bottomBackgroundImageView release];
	
	self.bottomButton1=[ACCreateButtonClass createButton:Type1];
	self.bottomButton2=[ACCreateButtonClass createButton:Type2];
	
	[self addSubview:bottomButton1];
	[self addSubview:bottomButton2];
	
	//=======================================
	
	CGSize Size1=((UIView *)bottomButton1).frame.size;
	CGSize Size2=((UIView *)bottomButton2).frame.size;
	
	[bottomButton1 setFrame:CGRectMake(10	, self.frame.size.height-Size1.height, Size1.width, Size1.height)];
	[bottomButton2 setFrame:CGRectMake(self.frame.size.width/2-Size2.width/2, self.frame.size.height/2-Size2.height/2, Size2.width, Size2.height)];
	
	return self;
	
}

-(id) initOneBtnsBottomBarView:(ButtonType)Type1
{
	self.bottomBackgroundImageView=[[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] autorelease];
	bottomBackgroundImageView.image=[UIImage imageNamed:@"bottom-bar.png"];
	[self addSubview:bottomBackgroundImageView];
//	[bottomBackgroundImageView release];
	
	self.bottomButton1=[ACCreateButtonClass createButton:Type1];
	[self addSubview:bottomButton1];
	
	//=======================================
	
	CGSize Size1=((UIView *)bottomButton1).frame.size;
	[bottomButton1 setFrame:CGRectMake(self.frame.size.width/2-Size1.width/2, self.frame.size.height/2-Size1.height/2+3, Size1.width, Size1.height)];
	
	return self;
	
}

-(id) initTwoBtnsBottomBarView:(ButtonType)Type1 
						second:(ButtonType)Type2
{
	
	self.bottomBackgroundImageView=[[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] autorelease];
	bottomBackgroundImageView.image=[UIImage imageNamed:@"bottom-bar.png"];
	[self addSubview:bottomBackgroundImageView];
//	[bottomBackgroundImageView release];
	
	self.bottomButton1=[ACCreateButtonClass createButton:Type1];
	self.bottomButton2=[ACCreateButtonClass createButton:Type2];
	
	[self addSubview:bottomButton1];
	[self addSubview:bottomButton2];
	
	//=======================================
	
	CGSize Size1=((UIView *)bottomButton1).frame.size;
	CGSize Size2=((UIView *)bottomButton2).frame.size;
	
	[bottomButton1 setFrame:CGRectMake(20	, self.frame.size.height/2-Size1.height/2, Size1.width, Size1.height)];
	[bottomButton2 setFrame:CGRectMake(self.frame.size.width-20-Size2.width, self.frame.size.height/2-Size2.height/2, Size2.width, Size2.height)];
	
	return self;
}

-(id) initThreeBtnsBottomBarView:(ButtonType)Type1 
						  second:(ButtonType)Type2
						   third:(ButtonType)Type3
{
	
	self.bottomBackgroundImageView=[[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] autorelease];
	bottomBackgroundImageView.image=[UIImage imageNamed:@"bottom-bar.png"];
	[self addSubview:bottomBackgroundImageView];
//	[bottomBackgroundImageView release];
	
	self.bottomButton1=[ACCreateButtonClass createButton:Type1];
	self.bottomButton2=[ACCreateButtonClass createButton:Type2];
	self.bottomButton3=[ACCreateButtonClass createButton:Type3];
	
	[self addSubview:bottomButton1];
	[self addSubview:bottomButton2];
	[self addSubview:bottomButton3];

	
	//=======================================
	
	CGSize Size1=((UIView *)bottomButton1).frame.size;
	CGSize Size2=((UIView *)bottomButton2).frame.size;
	CGSize Size3=((UIView *)bottomButton3).frame.size;
	
	[bottomButton1 setFrame:CGRectMake(20	, self.frame.size.height/2-Size1.height/2, Size1.width, Size1.height)];
	[bottomButton2 setFrame:CGRectMake(self.frame.size.width/2-Size2.width/2, self.frame.size.height/2-Size2.height/2, Size2.width, Size2.height)];
	[bottomButton3 setFrame:CGRectMake(self.frame.size.width-20-Size3.width, self.frame.size.height/2-Size3.height/2, Size3.width, Size3.height)];
	
	return self;
}

-(id) initFourBottomsBarBottomView:(ButtonType)Type1 
							second:(ButtonType)Type2
							 third:(ButtonType)Type3
							 forth:(ButtonType)Type4
{
	self.bottomBackgroundImageView=[[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] autorelease];
	bottomBackgroundImageView.image=[UIImage imageNamed:@"bottom-bar.png"];
	[self addSubview:bottomBackgroundImageView];
//	[bottomBackgroundImageView release];
	
	self.bottomButton1=[ACCreateButtonClass createButton:Type1];
	self.bottomButton2=[ACCreateButtonClass createButton:Type2];
	self.bottomButton3=[ACCreateButtonClass createButton:Type3];
	self.bottomButton4=[ACCreateButtonClass createButton:Type4];
	
	[self addSubview:bottomButton1];
	[self addSubview:bottomButton2];
	[self addSubview:bottomButton3];
	[self addSubview:bottomButton4];
	
	
	//=======================================
	
	CGSize Size1=((UIView *)bottomButton1).frame.size;
	CGSize Size2=((UIView *)bottomButton2).frame.size;
	CGSize Size3=((UIView *)bottomButton3).frame.size;
	CGSize Size4=((UIView *)bottomButton4).frame.size;
	
	[bottomButton1 setFrame:CGRectMake(10	, self.frame.size.height/2-Size1.height/2, Size1.width, Size1.height)];
	[bottomButton2 setFrame:CGRectMake(10+10+70, self.frame.size.height/2-Size2.height/2, Size2.width, Size2.height)];
	[bottomButton3 setFrame:CGRectMake(10+10+10+70+70, self.frame.size.height/2-Size3.height/2, Size3.width, Size3.height)];
	[bottomButton4 setFrame:CGRectMake(10+10+10+10+70+70+70, self.frame.size.height/2-Size4.height/2, Size4.width, Size4.height)];
	
	
	
	
	return self;
}





@end
