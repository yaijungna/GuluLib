//
//  MyGuluViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/7.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "MyGuluViewController.h"
#import "ACTableTwoLinesWithImageCell.h"
#import "ACTableThreeImagesCell.h"
#import "SettingsViewController.h"
#import "UIViewControllerAddtion_Connection_General.h"

#import "PostAddNewRestaurantViewController.h"

#import "PostDataModel.h"



@implementation MyGuluViewController

//@synthesize mypost,aroundme,todolist,feed,myfriend;

@synthesize friendRequest;
@synthesize mypostRequest;
@synthesize aroundMeRequest;

-(void)initViewController
{
	NSArray  *array=[NSArray arrayWithObjects:MUGULU_AROUNDME_STRING,MUGULU_FEED_STRING,MUGULU_TODOS_STRING,MUGULU_MYPOST_STRING,MUGULU_FRIENDS_STRING,nil];

	segment=[[ACSegmentController alloc] initWithFrame:CGRectMake(0, 45, 320, 40)];
	[segment initCustomSegment:array 
                   normalimage:[UIImage imageNamed:@"seg05-2.png"] 
                 selectedimage:[UIImage imageNamed:@"seg05-1.png"]
                      textfont:[UIFont fontWithName:FONT_BOLD size:10]];
	[segment setSelectedButtonAtIndex:3];
	segment.delegate=self;
	[self.view addSubview:segment];
	
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeSetting 
                                                                                      middle:ButtonTypeGuluLogo 
                                                                                       right:ButtonTypeImHungry];
	[self.view addSubview:topView];
    
	bottomView=[[[BottomMenuBarView alloc] initWithFrame:CGRectMake(0, 410, 320, 50)] initBottomBarView:ButtonTypeMyGulu
                                                                                                 second:ButtonTypeChat 
                                                                                                  third:ButtonTypePost
                                                                                                  forth:ButtonTypeMissions 
                                                                                                  fifth:ButtonTypeSearch];
	[bottomView setUpMainBtnAction];
    [self.view addSubview:bottomView];
	[bottomView setUpMainBtnSelected:0];
    
    [( (ACButtonWIthBottomTitle *)topView.topLeftButton).btn addTarget:self 
                                                                action:@selector(settingsAction) 
                                                      forControlEvents:UIControlEventTouchUpInside];
    
  //  [ (UIButton *)topView.topRightButton addTarget:self action:@selector(iamhungry) forControlEvents:UIControlEventTouchUpInside];
    
    
    //================
    
/*	
	self.mypost=[[[MyPostTableViewController alloc] init] autorelease];
    mypost.navigationController=self.navigationController;
	[myView addSubview:mypost.view];

	self.aroundme=[[[aroundMeTableViewController alloc] init] autorelease];
    aroundme.navigationController=self.navigationController;
	[myView addSubview:aroundme.view];
	
	self.todolist =[[[ToDoTableViewController alloc] init] autorelease];
	[myView addSubview:todolist.view];
    todolist.navigationController=self.navigationController;

	self.feed= [[[FeedTableViewController alloc] init] autorelease];
    feed.navigationController=self.navigationController;
	[myView addSubview:feed.view];
 */
/*
	self.myfriend =[[[MyFriendTableViewController alloc] init] autorelease];
	myfriend.navigationController=self.navigationController;
	[myView addSubview:myfriend.view];
*/
  
    /*
    if(!appDelegate.userMe.UUID)
    {
        [self getUserUUIDConnection:network];
    }
    else
    {
        appDelegate.hungry=[[[hungryModel alloc] initWithUUID:appDelegate.userMe.UUID] autorelease];
        
        chatModel *chat=[chatModel sharedManager];
        chat.UUID=appDelegate.userMe.UUID;
        [chat connectToChatServer];
        ACLog("Chat object initialized here : %@",chat);
        
        manager=[GuluChatManager sharedManager];
        [manager connectToChatServerWithUUID:appDelegate.userMe.UUID];

        
        
        
    }
    
   // NSLog(@"%@",appDelegate.userMe.UUID);
     ACLog(@"appDelegate.userMe.UUID=%@",appDelegate.userMe.UUID);
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(hungryStatusNotifyAction)
     name: @"hungryStatusNotify"
     object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hungryStatusNotify" object:nil];
    
    
    //=======  test ========
    
    NSArray *arr= [PostDataModel allObjects];
    NSLog(@"%@",arr);
    
 //   PostDataModel *p=[arr objectAtIndex:0];
    
 //   NSLog(@"%@",p.dishDict);
*/
    
    ////=====================
    friendTableView=[[MyPostFriendTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 325) pullToRefresh:YES];
    friendTableView.navigationController=self.navigationController;
	[myView addSubview:friendTableView];
    
    mypostTableView=[[MyGuluMyPostTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 325) pullToRefresh:YES];
    mypostTableView.navigationController=self.navigationController;
	[myView addSubview:mypostTableView];
    
    aroundMeTableView=[[AroundMeTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 325) pullToRefresh:YES];
    aroundMeTableView.navigationController=self.navigationController;
	[myView addSubview:aroundMeTableView];
    
    
    self.friendRequest=[APIManager userFriendsList:self user:appDelegate.GuluUser];
    self.mypostRequest=[APIManager userWallPost:self user:appDelegate.GuluUser];
    self.aroundMeRequest=[APIManager userAroundMe:self user:appDelegate.GuluUser];
    
    [self touchSegmentAtIndex:3];

}

- (void)GuluAPIAccessManagerSuccessed:(GuluHttpRequest*)httpRequest info:(id)info
{
    
    if([info isKindOfClass:[GuluErrorMessageModel class]]){
        [info showMyInfo:YES];
        return;
    }
    
    if(httpRequest == friendRequest)
    {
        friendTableView.tableArray=[[[NSMutableArray alloc] initWithArray:info] autorelease];
        [friendTableView reloadData];
    }
    
    if(httpRequest == mypostRequest)
    {
        mypostTableView.tableArray=[[[NSMutableArray alloc] initWithArray:info] autorelease];
        [mypostTableView reloadData];
    }
    
    if(httpRequest == aroundMeRequest)
    {
        aroundMeTableView.tableArray=[[[NSMutableArray alloc] initWithArray:info] autorelease];
        [aroundMeTableView reloadData];
    }

}

- (void)GuluAPIAccessManagerFailed:(GuluHttpRequest*)httpRequest info:(id)info
{
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
	[self initViewController];
    
 //   crash =[[crashreportModel alloc] initWithViewController:self] ;
   //  [crash handleCrashReport];
    
  /*  crashreport=[[GuluCrashReportModel alloc] initWithViewController:self];
    
    if([crashreport checkIfCrashPreviously])
        [crashreport sendCrashReport];
   */ 
}


- (void)didReceiveMemoryWarning {
  
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
}


- (void)dealloc {
/*	[mypost release];
	[aroundme release];
	[todolist release];
	[feed release];
	[myfriend release];
 */   
	[segment release];
    [topView release];
    [bottomView release];

	
    [super dealloc];
}

#pragma mark -
#pragma mark action Function Methods

-(void)hungryStatusNotifyAction
{
 /*   ACLog(@"hungryStatusNotifyAction");
    
    if(![topView.topRightButton isKindOfClass:[UIButton class]])
        return;

    
    if(appDelegate.hungry.hungryStatus==NO)
    {
       [((UIButton *)topView.topRightButton) setTitle:NSLocalizedString(@"I'm Hungry", @"cancel")  forState:UIControlStateNormal];
    }
    else
    {
       [((UIButton *)topView.topRightButton) setTitle:NSLocalizedString(@"Cancel Hungry", @"cancel")  forState:UIControlStateNormal];
    }
  
  */
    
  //  [manager leaveChatRoom:@"77935223-0ff7-47c8-a796-5736fe900274" participants:@""];
}

- (void)settingsAction 
{

	SettingsViewController *VC=[[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];	
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];
 
 // [self alerttest];
 
 

    
  /*  PostAddNewRestaurantViewController *VC=[[PostAddNewRestaurantViewController alloc] initWithNibName:@"PostAddNewRestaurantViewController" bundle:nil];	
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];
   */
    
    //[manager joinChatRoom:@"77935223-0ff7-47c8-a796-5736fe900274"];
  //  [manager getHungryInfoList];
    
    /*
   newchatVC *VC=[[newchatVC alloc] initWithNibName:@"chatRoomViewController" bundle:nil];	
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];
 */   
}


#pragma mark -
#pragma mark segment Delegate Function Methods

- (void) touchSegmentAtIndex:(NSInteger)segmentIndex
{
    
    friendTableView.hidden=YES;
    mypostTableView.hidden=YES;
    aroundMeTableView.hidden=YES;
    
    if(segmentIndex==0) //aroundme
	{
		aroundMeTableView.hidden=NO;
	}
    else if(segmentIndex==3) //mypost
	{
		mypostTableView.hidden=NO;
	}
	else if(segmentIndex==4) //friend
	{
		 friendTableView.hidden=NO;
	}

/*
	mypost.view.hidden=YES;
	aroundme.view.hidden=YES;
	todolist.view.hidden=YES;
	feed.view.hidden=YES;
	myfriend.view.hidden=YES;
*/	
    /*
	if(segmentIndex==0) //aroundme
	{
		aroundme.view.hidden=NO;
        [manager stopHungry];
	}
	else if(segmentIndex==1) //feed
	{ 
		feed.view.hidden=NO;
        
        [manager amIHungry];
	}
	else if(segmentIndex==2) //todo
	{
		todolist.view.hidden=NO;
        [self.view bringSubviewToFront:todolist.view];
        [manager startHungry];
	}
	else if(segmentIndex==3) //mypost
	{
		
		mypost.view.hidden=NO;
        
    
	}
	else if(segmentIndex==4) //friend
	{
		myfriend.view.hidden=NO;
        [manager joinChatRoom:@"77935223-0ff7-47c8-a796-5736fe900274"];
	}
*/	
}
/*
#pragma mark -

-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		ACLog(@"No Data");
	}
    
    
    if([temp  isKindOfClass:[NSDictionary class]])
    {
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
        {
            //   NSString *errorString =CONNECTION_ERROR_STRING;
            //  [self showErrorAlert:errorString];
            ACLog(@"request error %@",temp);
            
            return;
        }
    }

	
    //	NSLog(@"temp %@",temp);
   // ACLog(@"request ok");
	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"userUUID"])
	{
        if( [temp objectForKey:@"uuid"])
        {
            appDelegate.userMe.UUID=[temp objectForKey:@"uuid"];
            [appDelegate.userMe save];
           
            appDelegate.hungry=[[[hungryModel alloc] initWithUUID:appDelegate.userMe.UUID] autorelease];
            
            chatModel *chat=[chatModel sharedManager];
            chat.UUID=appDelegate.userMe.UUID;
            [chat connectToChatServer];
            ACLog("Chat object initialized here : %@",chat);
        
           // NSLog(@"%@",appDelegate.userMe.UUID);
           // ACLog(@"No Data");
            
            
        }
    }
	
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	
  ACLog(@"request fail");
}

*/

@end


/*
 -(void)save
 {
 
 GULUAPPAppDelegate *appDelegate = (GULUAPPAppDelegate *) [[UIApplication sharedApplication] delegate];
 
 NSManagedObjectContext *context = [appDelegate managedObjectContext];
 NSManagedObject *postInfo = [NSEntityDescription
 insertNewObjectForEntityForName:@"PostEntity" 
 inManagedObjectContext:context];
 
 [postInfo setValue:@"alan test 5" forKey:@"review"];
 
 NSError *error;
 if (![context save:&error]) {
 NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
 }
 
 NSEntityDescription *entity = [NSEntityDescription entityForName:@"PostEntity" inManagedObjectContext:[appDelegate managedObjectContext]];
 
 NSFetchRequest *request = [[NSFetchRequest alloc] init];
 [request setEntity:entity];
 
 NSMutableArray *mutableFetchResults = [[[appDelegate managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
 
 if (!mutableFetchResults) {
 for(id object in mutableFetchResults)
 {
 
 NSLog(@"%@",[object valueForKey:@"review"]);
 //   [[appDelegate managedObjectContext] deleteObject:object];
 
 }
 }
 
 if (![context save:&error]) {
 NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
 }
 
 [mutableFetchResults release];
 [request release];
 
 }
 */

