//
//  gradeMissionViewContorller.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/7.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "gradeMissionViewContorller.h"

#import "ACTableMissionLandingCell.h"

#import "oneLineTableHeaderView.h"
#import "ACTableTaskCell.h"

@implementation gradeMissionViewContorller

@synthesize groupMissionArray;
@synthesize imageLoaderDictionary;
@synthesize missionDict;
@synthesize indexOfGroupMissionArray;

@synthesize failDict;


-(void) initViewController
{
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
	[self.view addSubview:topView];
	[topView release];
	[topView.topLeftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topMiddleButton addTarget:self action:@selector(landingAction) forControlEvents:UIControlEventTouchUpInside];
    

	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	LoadingView.hidden=YES;	
	
    [self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
    
    //=====================================
    
    detailView=[[gradeDetailView alloc] initWithFrame:CGRectMake(0, 50, 320, 130)];
	[self.view addSubview:detailView];
	[detailView release];
    
    [self customizeImageView:detailView.PhotoImageView];
    [self customizeLabel_title:detailView.titlelabel];
    
    [detailView.passBtn addTarget:self action:@selector(passAction) forControlEvents:UIControlEventTouchUpInside];
    [detailView.AplusBtn addTarget:self action:@selector(aPlusAction) forControlEvents:UIControlEventTouchUpInside];
    [detailView.failBtn addTarget:self action:@selector(failAction) forControlEvents:UIControlEventTouchUpInside];
        
    //===================================
    
    [self customizeTableView:table];
    
     self.failDict =[[[NSMutableDictionary alloc] init] autorelease];
    
}

-(void) showdata
{
    
    detailView.titlelabel.text=[missionDict objectForKey:@"title"];
    
    detailView.imageLoader.URLStr=[[missionDict objectForKey:@"badge_pic"] objectForKey:@"image_medium"];

    [detailView.imageLoader  startDownload];
    
    
    if(groupMissionArray ==nil)
    {
        indexOfGroupMissionArray=0;
        
        if([ACCheckConnection isConnectedToNetwork])
        {
            [self getGradeMission];
        }
        else
        {
            NSString *errorString =CONNECTION_ERROR_STRING;
            [self showErrorAlert:errorString];
        }
    }   
    else
    {
        [table reloadData];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];
    [self showdata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
}


- (void)dealloc {
    [LoadingView release];
    [network release];
    
    [groupMissionArray release];
    [imageLoaderDictionary release];
    [missionDict release];
    
    [failDict release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark action Function Methods

-(void)showPassAlert
{    
    passAlert = [[[TSAlertView alloc] init] autorelease];
	passAlert.title =NSLocalizedString(@"Warning!",@"Warning alert to notify user.");
	passAlert.message = NSLocalizedString(@"Are you sure you want to pass this mission?",@"Warning alert to notify user.");
    passAlert.delegate=self;
    [passAlert addButtonWithTitle: GLOBAL_NO_STRING];
    [passAlert addButtonWithTitle: GLOBAL_YES_STRING];
	[passAlert show];

    
    
}

-(void)showAPlusAlert
{
    
    aplusAlert = [[[TSAlertView alloc] init] autorelease];
	aplusAlert.title =NSLocalizedString(@"Warning!",@"Warning alert to notify user.");
	aplusAlert.message = NSLocalizedString(@"Are you sure you want to A+ this mission?",@"Warning alert to notify user.") ;
    aplusAlert.delegate=self;
    [aplusAlert addButtonWithTitle: GLOBAL_NO_STRING];
    [aplusAlert addButtonWithTitle: GLOBAL_YES_STRING];
	[aplusAlert show];
    
}


-(void)showFailAlert
{
    failAlert = [[[TSAlertView alloc] init] autorelease];
	failAlert.title =NSLocalizedString(@"Warning!",@"Warning alert to notify user.");
	failAlert.message = NSLocalizedString(@"Are you sure you want to fail this mission?",@"Warning alert to notify user.") ;
    failAlert.delegate=self;
    [failAlert addButtonWithTitle: GLOBAL_NO_STRING];
    [failAlert addButtonWithTitle: GLOBAL_YES_STRING];
	[failAlert show];
    
}

 
-(void)backAction
{
    [self cancelImageLoaders:imageLoaderDictionary];
    [detailView.imageLoader cancelDownload];
    [network cancelAllRequestsInRequestsQueue];
	[self.navigationController popToRootViewControllerAnimated:YES];    	
}

-(void)landingAction
{
    [self cancelImageLoaders:imageLoaderDictionary];
    [network cancelAllRequestsInRequestsQueue];
    [detailView.imageLoader cancelDownload];
    [self.navigationController popToRootViewControllerAnimated:YES];	
}
-(void)gotoNextAction
{
    
    if( [groupMissionArray count] >indexOfGroupMissionArray+1 )
    {
        gradeMissionViewContorller *VC=[[gradeMissionViewContorller alloc] initWithNibName:@"gradeMissionViewContorller" bundle:nil];
        VC.missionDict=self.missionDict;
        VC.groupMissionArray=self.groupMissionArray;
        VC.indexOfGroupMissionArray=self.indexOfGroupMissionArray+1;
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
    }
   	
}


-(void)passAction
{
    
    if([[[groupMissionArray objectAtIndex:indexOfGroupMissionArray] objectForKey:@"task_reviews"] count]==0)
    {
        return;
    }

    
    [self showPassAlert];	
}

-(void)aPlusAction
{
    if([[[groupMissionArray objectAtIndex:indexOfGroupMissionArray] objectForKey:@"task_reviews"] count]==0)
    {
        return;
    }
    
    [self showAPlusAlert];	
}

-(void)failAction
{
    isFailMode=YES;
    [table reloadData];
    
    detailView.passBtn.enabled=NO;
    detailView.AplusBtn.enabled=NO;
    
    [topView initTopBarView:ButtonTypeCancel middle:ButtonTypeGuluLogo right:ButtonTypeDone];
    [topView.topLeftButton addTarget:self action:@selector(failCancelAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topRightButton addTarget:self action:@selector(failDoneAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)failDoneAction
{
    
    if([failDict count]==0)
    {
        return;
    }

    [self showFailAlert];
}

-(void)failCancelAction
{
    isFailMode=NO;
    [table reloadData];
    
    detailView.passBtn.enabled=YES;
    detailView.AplusBtn.enabled=YES;
    
    [topView initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
    [topView.topLeftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topMiddleButton addTarget:self action:@selector(landingAction) forControlEvents:UIControlEventTouchUpInside];
}




#pragma mark -
#pragma mark table Function Methods


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 26;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	oneLineTableHeaderView *view1 = [[oneLineTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    view1.label1.text=NSLocalizedString(@"Tasks Review",@"[mission profile]");
	view1.rightBtn.hidden=YES;
	[self customizeLabel:view1.label1];
    
	return [view1 autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 130;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if([groupMissionArray count]==0)
        return 0;
    
    return [[[groupMissionArray objectAtIndex:indexOfGroupMissionArray] objectForKey:@"task_reviews"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *cellIdentifier = @"ACTableTaskCell";
    static NSString *nibNamed = @"ACTableTaskCell";
    
    ACTableTaskCell *cell = (ACTableTaskCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell= (ACTableTaskCell*) currentObject;
                [cell initCell];
                [self customizeLabel_title:cell.label1 ];
                [self customizeLabel:cell.label2 ];
                [self customizeTextView:cell.aboutTextView];
                [self customizeImageView_cell:cell.leftImageview];
                cell.label2.textColor=[UIColor grayColor];
                cell.checkBoxBtn.userInteractionEnabled=NO;
            }
        }
    }
    
    NSDictionary *taskdict=[[[groupMissionArray objectAtIndex:indexOfGroupMissionArray] objectForKey:@"task_reviews"] objectAtIndex:indexPath.row];
    
    NSString *username=[[taskdict objectForKey:@"review_creator"] objectForKey:@"username"];
    
    cell.label1.text=[taskdict objectForKey:@"task_title"];
    cell.label2.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"This review is completed by", @"[grade mission]"),username];
    cell.aboutTextView.text=[taskdict objectForKey:@"review_content"];   
    
    
    ACImageLoader *iconDownloader=[imageLoaderDictionary objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
	if (!iconDownloader.image)
	{
		if (tableView.dragging == NO && tableView.decelerating == NO)
		{
			iconDownloader.delegate=self;
			iconDownloader.indexPath=indexPath;
			[iconDownloader startDownload];
		}
		
		cell.leftImageview.image=nil;               
	}
	else
	{
		cell.leftImageview.image=iconDownloader.image;
	}
    
    if(isFailMode)
        cell.checkBoxBtn.hidden=NO;
    else
        cell.checkBoxBtn.hidden=YES;
    
    return cell;
}


- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(isFailMode==YES)
    {
        UITableViewCell *cell = [table cellForRowAtIndexPath:indexPath];
        
        NSDictionary *taskdict=[[[groupMissionArray objectAtIndex:indexOfGroupMissionArray] objectForKey:@"task_reviews"] objectAtIndex:indexPath.row];
        
        if(((ACTableTaskCell *)cell).checkBoxBtn.selected==YES)
        {
            ((ACTableTaskCell *)cell).checkBoxBtn.selected=NO;
            [self shareGULUAPP];
            [failDict removeObjectForKey:[taskdict objectForKey:@"group_task_id"]];
        }
        else
        {
           ((ACTableTaskCell *)cell).checkBoxBtn.selected=YES;
            [failDict setObject:taskdict forKey:[taskdict objectForKey:@"group_task_id"]];
        }
    }
}


#pragma mark -
#pragma mark request Methods

-(void)getGradeMission
{
    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    
    NSString *mid=[missionDict objectForKey:@"id"];
    
    NSLog(@"%@",mid);
    
    if(![ACCheckConnection isConnectedToNetwork])
    {
        
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        
        return;
    }

    
    [self GradeMissionConnection:network missionID:mid];
}

-(void)passMission:(NSString *)grade
{
    
    if([groupMissionArray count]==0)
    {
        return;
    }
    
    
    if(![ACCheckConnection isConnectedToNetwork])
    {
        
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        
        return;
    }

    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];

    NSString *gid=[[groupMissionArray objectAtIndex:indexOfGroupMissionArray] objectForKey:@"id"];
    
    NSLog(@"%@",gid);
    
    [self passMissionConnection:network groupID:gid grade:grade];
}

-(void)failMission:(NSString *)message
{
    if([groupMissionArray count]==0)
    {
        return;
    }
    
    if(![ACCheckConnection isConnectedToNetwork])
    {
        
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        
        return;
    }

    
    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    
    NSString *gid=[[groupMissionArray objectAtIndex:indexOfGroupMissionArray] objectForKey:@"id"];

    NSMutableArray *failArray=[NSMutableArray arrayWithArray:[failDict allValues]];
    
    [self failMissionConnection:network groupID:gid tasks:failArray failmessage:message];
    
}


-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
   	
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		NSLog(@"No Data");
	}
    
    NSLog(@"temp %@",temp);
    
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"grademission"])
	{
        if([temp count]==0)
        {
            return;
        }
		
		self.groupMissionArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
		
		self.imageLoaderDictionary=[[[NSMutableDictionary alloc] init] autorelease];
		int i=0;
		for(NSDictionary *dict in [[groupMissionArray objectAtIndex:indexOfGroupMissionArray] objectForKey:@"task_reviews"] )
		{
			NSString *url_key=[[dict  objectForKey:@"review_photo"] objectForKey:@"image_medium"];
			ACImageLoader *iconDownloader= [[ACImageLoader alloc] init];
			iconDownloader.URLStr=url_key;
			[imageLoaderDictionary setObject:iconDownloader forKey:[NSString stringWithFormat:@"%d",i]];	
			[iconDownloader release]; 
			i++;
		}
		
		[table reloadData];
	}
    
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"passmission"])
	{
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSNumber class]])
        {
            if([[temp objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]])
            {
                [self showOKAlert:GLOBAL_OK_STRING];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTheMissionICreated" object:nil];
                
                if( [groupMissionArray count] >indexOfGroupMissionArray+1 )
                {
                    [self gotoNextAction];
                }
                else
                {
                    [self backAction];
                }
            }
        }
        
    }
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"failmission"])
	{
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSNumber class]])
        {
            if([[temp objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]])
            {
                [self showOKAlert:GLOBAL_OK_STRING];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTheMissionICreated" object:nil];
                
                if( [groupMissionArray count] >indexOfGroupMissionArray+1 )
                {
                    [self gotoNextAction];
                }
                else
                {
                    [self backAction];
                }

            }
        }
    }
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	
    [self hideSpinnerView:LoadingView];
    
	NSString *errorString =CONNECTION_ERROR_STRING;
	[self showErrorAlert:errorString];
}


#pragma mark -
#pragma mark ACImageDidLoad Delegate and Function Methods

- (void)ACImageDidLoad:(ACImageLoader *)imageloader
{
	if (imageloader.image != nil)
	{
		UITableViewCell *cell = [table cellForRowAtIndexPath:imageloader.indexPath];
		((ACTableTaskCell *)cell).leftImageview.image=imageloader.image;
	}	 
}

- (void)loadImagesForOnscreenRows :(UITableView*)tableview  imageLoadersDict:(NSMutableDictionary *)dict
{
	NSArray *visiblePaths = [tableview indexPathsForVisibleRows];
	for (NSIndexPath *indexPath in visiblePaths)
	{
		ACImageLoader *iconDownloader=[dict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
		
		if(iconDownloader.image==nil)
		{
			iconDownloader.indexPath=indexPath;
			iconDownloader.delegate=self;
			[iconDownloader startDownload];
		}
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	//[super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
	
    if (!decelerate)
	{
		[self loadImagesForOnscreenRows:table imageLoadersDict:imageLoaderDictionary];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{	
	[self loadImagesForOnscreenRows:table imageLoadersDict:imageLoaderDictionary];
}


#pragma mark -
#pragma mark TSAlert Delegate Function Methods


- (void)alertView:(TSAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alert==passAlert && buttonIndex==1)
	{
		[self passMission:@"pass"];
	}
    if(alert==aplusAlert  && buttonIndex==1)
	{
		[self passMission:@"a"];
	}
    if(alert==failAlert && buttonIndex==1 )
	{
        detailView.passBtn.enabled=YES;
        detailView.AplusBtn.enabled=YES;
        
        
        isFailMode=NO;
        [table reloadData];
        
        [topView initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
        [topView.topLeftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [topView.topMiddleButton addTarget:self action:@selector(landingAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self failMission:@"fail"];
	}



}

@end