//
//  ChatLandingViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/7.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ChatLandingViewController.h"
#import "EventViewController.h"


@implementation ChatLandingViewController


-(void) initViewController
{
	NSArray  *array=[NSArray arrayWithObjects:CHAT_ALL_STRING,CHAT_HUNGRY_STRING,CHAT_MISSIONS_STRING,CHAT_EVENTS_STRING,nil];
	//NSArray  *array=[NSArray arrayWithObjects:CHAT_ALL_STRING,CHAT_EVENTS_STRING,nil];
	
	segment=[[ACSegmentController alloc] initWithFrame:CGRectMake(0, 40, 320, 40)];
	//segment=[[ACSegmentController alloc] initWithFrame:CGRectMake(40, 40, 240, 40)];
	[segment initCustomSegment:array normalimage:[UIImage imageNamed:@"seg04-2.png"] selectedimage:[UIImage imageNamed:@"seg04-1.png"]  textfont:[UIFont fontWithName:FONT_BOLD size:10]];
	[segment setSelectedButtonAtIndex:0];
	
	[self.view addSubview:segment];
	[segment release];
	
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeCreateEvent middle:ButtonTypeGuluLogo right:ButtonTypeImHungry];
	[self.view addSubview:topView];
	[topView.topLeftButton addTarget:self action:@selector(createEventAction) forControlEvents:UIControlEventTouchUpInside];	
    [topView.topRightButton addTarget:self action:@selector(iamhungry) forControlEvents:UIControlEventTouchUpInside];
    

    
	bottomView=[[[BottomMenuBarView alloc] initWithFrame:CGRectMake(0, 410, 320, 50)] initBottomBarView:ButtonTypeMyGulu second:ButtonTypeChat third:ButtonTypePost forth:ButtonTypeMissions fifth:ButtonTypeSearch];
	[bottomView setUpMainBtnAction];
	//bottomView=[[[BottomMenuBarView alloc] initWithFrame:CGRectMake(0, 410, 320, 50)] initFourBottomsBarBottomView:ButtonTypeMyGulu second:ButtonTypeChat third:ButtonTypePost  forth:ButtonTypeSearch];
	//[bottomView setUpMainBtnAction2];
	[self.view addSubview:bottomView];
	
	[bottomView setUpMainBtnSelected:1];
	
	chat=[[chatLandingTableViewController alloc] init];
	chat.navigationController=self.navigationController;
	[myView addSubview:chat.view];
    
    segment.delegate=chat;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(hungryStatusNotifyAction)
     name: @"hungryStatusNotify"
     object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hungryStatusNotify" object:nil];
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
	[topView release];topView=nil;
    [bottomView release];bottomView=nil;
    [chat release];
    [super dealloc];
}

#pragma mark -
#pragma mark action Function Methods


- (void)createEventAction{
	
	EventViewController *VC=[[EventViewController alloc] initWithNibName:@"EventViewController" bundle:nil];	
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];
	
}

-(void)hungryStatusNotifyAction
{
    
    if(![topView.topRightButton isKindOfClass:[UIButton class]])
        return;
    
    if(appDelegate.hungry.hungryStatus==NO)
    {
        [((UIButton *)topView.topRightButton) setTitle:NSLocalizedString(@"I'm Hungry", @"cancel") forState:UIControlStateNormal];
    }
    else
    {
        [((UIButton *)topView.topRightButton) setTitle:NSLocalizedString(@"Cancel Hungry", @"cancel") forState:UIControlStateNormal];
    }
}



@end
