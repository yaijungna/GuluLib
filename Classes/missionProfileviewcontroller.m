//
//  missionProfileviewcontroller.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/4.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "missionProfileviewcontroller.h"

#import "ACTableMissionLandingCell.h"

#import "oneLineTableHeaderView.h"

#import "missionChatViewController.h"

#import "UIImageView+WebCache.h"

@implementation missionProfileviewcontroller

@synthesize tasksArray;
@synthesize missionDict;
@synthesize  fromChat;

@synthesize chatDict;

@synthesize fromMission;



-(void) initViewController
{
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNormal];
	[self.view addSubview:topView];
	[topView release];
	[topView.topLeftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topMiddleButton addTarget:self action:@selector(landingAction) forControlEvents:UIControlEventTouchUpInside];
    
    
  //  bottomView=[[[BottomMenuBarView alloc] initWithFrame:CGRectMake(0, 410, 320, 50)] initTwoBtnsBottomBarView:ButtonTypeAddTodo second:ButtonTypeAddFavorite];
    
     bottomView=[[[BottomMenuBarView alloc] initWithFrame:CGRectMake(0, 410, 320, 50)] initOneBtnsBottomBarView:ButtonTypeAddFavorite];
    
	[self.view addSubview:bottomView];
	[bottomView release];
	[((ACButtonWIthBottomTitle *)bottomView.bottomButton1).btn addTarget:self action:@selector(favoriteAction) forControlEvents:UIControlEventTouchUpInside];
//	[((ACButtonWIthBottomTitle *)bottomView.bottomButton1).btn addTarget:self action:@selector(todoAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    if(fromChat)
    {
        [topView.topRightButton setTitle:NSLocalizedString(@"Chat", @"[mission]take this mission") forState:UIControlStateNormal];
        [topView.topRightButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        bottomView.hidden=YES;
        [table setFrame:CGRectMake(0, 180, 320, 280)];
    }
    else if(fromMission)
    {
        [topView.topRightButton setTitle:NSLocalizedString(@"Chat", @"[mission]take this mission") forState:UIControlStateNormal];
        [topView.topRightButton addTarget:self action:@selector(gotoMissionChat) forControlEvents:UIControlEventTouchUpInside];
        bottomView.hidden=YES;
        [table setFrame:CGRectMake(0, 180, 320, 280)];
    }
    else 
    {
        [topView.topRightButton setTitle:NSLocalizedString(@"Join", @"[mission]take this mission") forState:UIControlStateNormal];
        [topView.topRightButton addTarget:self action:@selector(todoAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	LoadingView.hidden=YES;	
	
    [self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
    
    //=====================================
    
    detailView=[[missionDetailView alloc] initWithFrame:CGRectMake(0, 50, 320, 130)];
	[self.view addSubview:detailView];
	[detailView release];
    
    [self customizeImageView:detailView.PhotoImageView];
    [self customizeLabel_title:detailView.titlelabel];
    [self customizeLabel:detailView.subtitlelabel];
    [self customizeTextView:detailView.aboutView];
    [self customizeLabel:detailView.bottomLabel];
    
    detailView.aboutView.editable=NO;
    detailView.aboutView.layer.borderWidth=0;
    detailView.aboutView.backgroundColor=[UIColor clearColor];
    
    
    //===================================
    
    [self customizeTableView:table];
    
    
    [[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(getTasksList)
	 name: @"refreshMyMissionTasksList"
	 object:nil];
      
}

-(void) showdata
{
    NSString *username=[[missionDict objectForKey:@"created_user"] objectForKey:@"username"];
    
    detailView.titlelabel.text=[missionDict objectForKey:@"title"];
    detailView.subtitlelabel.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"created by", @"who created this mission"),username];
    detailView.aboutView.text=[missionDict objectForKey:@"description"];
    
    

    detailView.imageLoader.URLStr=[[missionDict objectForKey:@"badge_pic"] objectForKey:@"image_medium"];
    [detailView.imageLoader  startDownload];

}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self initViewController];
  //  [self showdata];
    

    //   [self getTasksList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
}


- (void)dealloc {
    [detailView.imageLoader cancelDownload];
    [network cancelAllRequestsInRequestsQueue];
    
    [LoadingView release];
    [network release];
    
    [tasksArray release];
    [missionDict release];
    
    [chatDict release];

    [super dealloc];
}

#pragma mark -
#pragma mark action Function Methods


-(void)backAction
{
    [detailView.imageLoader cancelDownload];
    [network cancelAllRequestsInRequestsQueue];
	[self.navigationController popViewControllerAnimated:YES];    	
}

-(void)landingAction
{
    [network cancelAllRequestsInRequestsQueue];
     [detailView.imageLoader cancelDownload];
    [self.navigationController popToRootViewControllerAnimated:YES];	
}

-(void)gotoMissionChat
{
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }
    
    missionChatViewController *VC=[[missionChatViewController alloc] initWithNibName:@"chatRoomViewController" bundle:nil];	
    VC.chatDictionary=[NSMutableDictionary dictionaryWithDictionary:chatDict];
    VC.chatID=[chatDict objectForKey:@"chat_uuid"];
    VC.fromProfile=YES;
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];
    
}

#pragma mark -
#pragma mark table Function Methods


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	oneLineTableHeaderView *view1 = [[oneLineTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    view1.label1.text=NSLocalizedString(@"Tasks",@"[mission profile]");
	view1.rightBtn.hidden=YES;
	[self customizeLabel:view1.label1];

	return [view1 autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return (5+20+35+5);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   // return [tasksArray count];
      return [tasksArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *cellIdentifier = @"ACTableMissionLandingCell";
    static NSString *nibNamed = @"ACTableMissionLandingCell";
    
    ACTableMissionLandingCell *cell = (ACTableMissionLandingCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell= (ACTableMissionLandingCell*) currentObject;
                [cell initCell];
                [self customizeLabel_title:cell.labelTitle ];
                [self customizeLabel:cell.labelSubTitle ];
                [self customizeImageView_cell:cell.leftImageview];
                cell.labelSubTitle.textColor=[UIColor grayColor];
                cell.labelSubTitle.numberOfLines=2;
                cell.labelSubTitle.font=[UIFont fontWithName:FONT_NORMAL size:12];
            
            }
        }
    }
    NSDictionary *taskdict=[tasksArray objectAtIndex:indexPath.row];
    
    NSString *url_key=[[taskdict  objectForKey:@"main_pic"] objectForKey:@"image_small"];
    [cell.leftImageview setImageWithURL:[NSURL URLWithString:url_key]];

    cell.labelTitle.text=[taskdict objectForKey:@"title"];
    cell.labelSubTitle.text=[taskdict objectForKey:@"description"];    
    return cell;
}


- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self shareGULUAPP];
    
    if([missionDict objectForKey:@"group_id"]==nil || [[missionDict objectForKey:@"group_id"] isEqual:[NSNull null]])
        return;
        
	NSDictionary *dict=[tasksArray objectAtIndex:indexPath.row];
    
    
//    ACLog(@"%@",dict);
    
	
	appDelegate.temp.postObj=[[[postModel alloc] init] autorelease];
    appDelegate.temp.postObj.restaurantDict=[dict objectForKey:@"restaurant"];
    appDelegate.temp.postObj.dishDict=[dict objectForKey:@"dish"];
    appDelegate.temp.postObj.taskid=[dict objectForKey:@"id"];
    appDelegate.temp.postObj.groupid=[missionDict objectForKey:@"group_id"];
    
    if([appDelegate.temp.postObj.dishDict isEqual:[NSNull null]])
    {
        appDelegate.temp.postObj.dishDict=nil;
    }
    if([appDelegate.temp.postObj.restaurantDict isEqual:[NSNull null]])
    {
        appDelegate.temp.postObj.restaurantDict=nil;
    }
    
 //   ACLog(@"%@",appDelegate.temp.postObj.restaurantDict);
 //   ACLog(@"%@",appDelegate.temp.postObj.dishDict);

    
    
		
	[BottomMenuBarView thirdBtnAction];
}


#pragma mark -
#pragma mark request Methods

-(void)getTasksList
{
    
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }
    table.userInteractionEnabled=NO;
    
    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    
    NSString *mid=[missionDict objectForKey:@"id"];
    NSString *gid=[missionDict objectForKey:@"group_id"];
    
    [self tasksMissionConnection:network missionID:mid groupID:gid];
}

- (void)favoriteAction
{
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }

    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    [self favoriteMissionConnection:network mission:[NSMutableDictionary dictionaryWithDictionary:missionDict]];
}

-(void)todoAction
{
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }

    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    [self joinMissionConnection:network missionID:[missionDict objectForKey:@"id"]];
}


-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
   	
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
    table.userInteractionEnabled=YES;
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		NSLog(@"No Data");
	}
	
    NSLog(@"temp %@",temp);
    
    if([temp  isKindOfClass:[NSDictionary class]])
    {
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
        {
         //   NSString *errorString =CONNECTION_ERROR_STRING;
          //  [self showErrorAlert:errorString];
            
            ACLog(@"reqest error : %@",temp);
            return;
        }
    }

    
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"missiontasks"])
	{
		
		self.tasksArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
		
		[table reloadData];
	}
    
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"addFavoriteMission"])
	{
		NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:temp];
		
		if([dict count]==0)
			return;
		
        if([[dict objectForKey:@"errorMessage"] isKindOfClass:[NSNumber class]] )
        {
            if ([[dict objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]] ) {
                [self showOKAlert:[NSString stringWithFormat:@"%@ %@",GLOBAL_ADDTO_FAVORITE_STRING,GLOBAL_OK_STRING]];
            }
        }
	}
    
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"missionjoin"])
	{
		NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:temp];
		
		if([dict count]==0)
			return;
		
        if([[dict objectForKey:@"errorMessage"] isKindOfClass:[NSNumber class]] )
        {
            if ([[dict objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]] ) {
                [self showOKAlert:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Join this Mission", @"mission"),GLOBAL_OK_STRING]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyMission" object:nil];
            }
        }
	}
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	
    [self hideSpinnerView:LoadingView];
    table.userInteractionEnabled=YES;
    
//	NSString *errorString =CONNECTION_ERROR_STRING;
//	[self showErrorAlert:errorString];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	//[super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
	

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{	
	
}



@end
