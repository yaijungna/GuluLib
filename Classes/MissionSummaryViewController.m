//
//  MissionSummaryViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/30.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "MissionSummaryViewController.h"


#import "ACTableMissionLandingCell.h"

#import "oneLineTableHeaderView.h"

#import "pickPlaceDishViewController.h"
#import "pickChallengersViewController.h"
#import "pickSpectatorViewController.h"

@implementation MissionSummaryViewController
@synthesize WarningAlert;
@synthesize missionObj;

static int countDown=0;

- (void)showData
{
    [self shareGULUAPP];
    
    self.missionObj=appDelegate.temp.missionObj;
    
    
    if(missionObj.missionType == TreasureHuntMissionType )
    {
        missionTitleLabel.text=missionObj.missionTitle;
        aboutTextView.text=missionObj.missionAbout;
        
        photo.image=missionObj.missionPhoto;        
    }
    else  if(missionObj.missionType == DareMissiontype  || missionObj.missionType == FoodGuideMissionType)
    {
        buttomLabel.hidden=YES;
        switcher.hidden=YES;
        missionTitleLabel.text=missionObj.missionTitle;
        aboutTextView.text=missionObj.missionAbout;

        
        [aboutTextView setFrame:CGRectMake(aboutTextView.frame.origin.x
                                           , aboutTextView.frame.origin.y, 
                                           aboutTextView.frame.size.width, 
                                           aboutTextView.frame.size.height*5/3)];
        
        photo.image=missionObj.missionPhoto;        
        
    }
    else  if(missionObj.missionType == PrivateGroupMissionType  || missionObj.missionType == TimeCriticalMissionType )
    {
        switcher.hidden=YES;
        missionTitleLabel.text=missionObj.missionTitle;
        aboutTextView.text=missionObj.missionAbout;
        
        photo.image=missionObj.missionPhoto;     
        
        buttomLabel.frame=CGRectMake(97, 123, 218, 39);
        buttomLabel.text=[NSString stringWithFormat:@"%@\n%@",
                          NSLocalizedString(@"This mission must be completed by:", @"[mission]"),
                         [ACUtility dateStringToDateFormatString:missionObj.deadLine]];
        buttomLabel.font=[UIFont fontWithName:FONT_NORMAL size:10];

        
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeCancel
                                                                                      middle:ButtonTypeGuluLogo 
                                                                                       right:ButtonTypeNormal];
	[self.view addSubview:topView];
	[topView release];
    
    UIButton *rightbtn=topView.topRightButton;
    
    [rightbtn setFrame:CGRectMake(rightbtn.frame.origin.x-35, 
                                  rightbtn.frame.origin.y, 
                                  rightbtn.frame.size.width+35,
                                  rightbtn.frame.size.height)];
    
    [rightbtn setTitle:NSLocalizedString(@"create Mission", @"[button]") forState:UIControlStateNormal];
    
    [topView.topLeftButton	addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topMiddleButton addTarget:self action:@selector(landingAction) forControlEvents:UIControlEventTouchUpInside];    
    [topView.topRightButton addTarget:self action:@selector(createAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
    network.requestsQueue.delegate=self;
//    [network.requestsQueue setQueueDidFinishSelector:@selector(AllRequestFinish)];
    
    LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	LoadingView.hidden=YES;
    
    //================================================
    
    [self customizeTableView:table];
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone]; 
    
    
    [self customizeLabel_title:missionTitleLabel];
    missionTitleLabel.text=@"Treasure Hunt";
    
    [self customizeTextView:aboutTextView];
    [aboutTextView setBackgroundColor:[UIColor clearColor]];
    aboutTextView.layer.borderWidth = 0.0f;
    
    [self customizeImageView_cell:photo];
    
    [self customizeLabel:buttomLabel];
    
    
    photoBtn=[ACCreateButtonClass createButton:ButtonTypeNormal];
    [self.view addSubview:photoBtn];
    [photoBtn setFrame:CGRectMake(12, 135, photoBtn.frame.size.width, photoBtn.frame.size.height)];
    [photoBtn setTitle:NSLocalizedString(@"Edit", @"[button]") forState:UIControlStateNormal];
    photoBtn.hidden=YES;
    
    buttomLabel.text=NSLocalizedString(@"Show next task only when current one is done.", @"treasure hunt");
    
    
    [[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(addTaskCallBackFunction:)
	 name: @"addTaskNotification"
	 object:nil];
    
    [[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(editMissionCallBackFunction)
	 name: @"editMissionNotification"
	 object:nil];
    
    [[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(addChallengersCallBackFunction)
	 name: @"addChallengersNotification"
	 object:nil];
    
    [[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(addSpectatorsCallBackFunction)
	 name: @"addSpectatorsNotification"
	 object:nil];

    [self showData];
    
    
    
    if([ACCheckConnection isConnectedToNetwork])
    {
        if([missionObj.photoDict count]==0)
            [self uploadMissionPhoto];
        
    }
    else
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
    
    }
    
    if(((taskModel *)[missionObj.taskArray objectAtIndex:0]).photoDict==nil)
    {
     //   [self uploadTaskPhoto:[missionObj.taskArray objectAtIndex:0]];
    }
        
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}


- (void)dealloc
{
    [WarningAlert release];
    [LoadingView release];
    [missionObj release];
    [super dealloc];
}

#pragma mark -
#pragma mark call back Function Methods

-(void)cancelAllNotification
{

	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"addTaskNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"editMissionNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"addChallengersNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"addSpectatorsNotification" object:nil];
    
}

- (void)addTaskCallBackFunction :(NSNotification*)notification 
{
    taskModel *task=notification.object;
    
    NSLog(@"%@",task);
    NSLog(@"%@",missionObj);
    NSLog(@"%d",missionObj.missionType);
    
 /*   if(task.photoDict==nil)
    {
        [self uploadTaskPhoto:task];
    }*/
    
    [table reloadData];
}

- (void)editMissionCallBackFunction 
{
 //   [self showData];
   // [self uploadMissionPhoto];
    
}

-(void)addChallengersCallBackFunction
{
    [table reloadData];
}

-(void)addSpectatorsCallBackFunction
{
    [table reloadData]; 
}



#pragma mark -
#pragma mark action Function Methods


- (void)createAction
{
    [self showWarningAlert_create];
}

- (void)backAction 
{
    [self showWarningAlert_cancel];
}

- (void)landingAction 
{
    [self showWarningAlert_cancel];
}

- (void)addTaskAction
{
    
    taskModel *obj=[[[taskModel alloc] init] autorelease];
    appDelegate.temp.taskObj=obj;
    
    pickPlaceDishViewController *VC=[[pickPlaceDishViewController alloc] 
                                     initWithNibName:@"pickPlaceDishViewController" 
                                     bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];
    

    
}

-(void) showWarningAlert_cancel
{	
    self.WarningAlert = [[[TSAlertView alloc] init] autorelease];
    WarningAlert.tag=0;
	WarningAlert.title =NSLocalizedString(@"Warning!",@"Warning alert to notify user.");
	WarningAlert.message = NSLocalizedString(@"Abort this mission?",@"Warning alert to notify user.");
    WarningAlert.delegate=self;
    [WarningAlert addButtonWithTitle: GLOBAL_NO_STRING];
    [WarningAlert addButtonWithTitle: GLOBAL_YES_STRING];
	[WarningAlert show];
}

-(void) showWarningAlert_create
{	
    
    self.WarningAlert = [[[TSAlertView alloc] init] autorelease];
    WarningAlert.tag=1;
	WarningAlert.title =NSLocalizedString(@"Warning!",@"Warning alert to notify user.");
	WarningAlert.message = NSLocalizedString(@"Create this mission?",@"Warning alert to notify user.");
    WarningAlert.delegate=self;
    [WarningAlert addButtonWithTitle: GLOBAL_NO_STRING];
    [WarningAlert addButtonWithTitle: GLOBAL_YES_STRING];
	[WarningAlert show];
	
}

-(void) showWarningAlert_ok
{	
    
    self.WarningAlert = [[[TSAlertView alloc] init] autorelease];
    WarningAlert.tag=2;
	WarningAlert.title =NSLocalizedString(@"Warning!",@"Warning alert to notify user.");
	WarningAlert.message = NSLocalizedString(@"Create this mission successfully",@"Warning alert to notify user.");
    WarningAlert.delegate=self;
    [WarningAlert addButtonWithTitle: GLOBAL_OK_STRING];
	[WarningAlert show];
	
}


#pragma mark -
#pragma mark table Function Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
    
    if(section==0)
    {
        if(missionObj.missionType == DareMissiontype  ||missionObj.missionType == PrivateGroupMissionType)
        {
            return 5;
        }
        else  
        {
            return 40;
        }   
    }
    else if(section ==1)
    {
        return 40;
    
    }
    
    return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	oneLineTableHeaderView *view1=[[oneLineTableHeaderView alloc] init];
    
    
    
    if(missionObj.missionType == DareMissiontype  ||missionObj.missionType == PrivateGroupMissionType)
    {
        if(section==0)
        {
            [view1 setFrame:CGRectMake(0, 0, 320, 5)];
            view1.label1.hidden=YES;
        }
        else  if(section==1)
        {
           // view1 = [[oneLineTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
            [view1 setFrame:CGRectMake(0, 0, 320, 40)];
            view1.label1.text=NSLocalizedString(@"Tasks",@"[table] title");
            [self customizeLabel:view1.label1];
            
            UIButton *addbtn=[[UIButton alloc] initWithFrame:CGRectMake(280, 5, 30, 30)];
            [view1 addSubview:addbtn];
            [addbtn setBackgroundImage:[UIImage imageNamed:@"inactive-add-icon-1.png"] forState:UIControlStateNormal];
            [addbtn release];
            [addbtn addTarget:self action:@selector(addTaskAction) forControlEvents:UIControlEventTouchUpInside];
            
        }   
    }
    else
    {
      //  view1 = [[oneLineTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [view1 setFrame:CGRectMake(0, 0, 320, 40)];
        view1.label1.text=NSLocalizedString(@"Tasks",@"[table] title");
        [self customizeLabel:view1.label1];
        
        UIButton *addbtn=[[UIButton alloc] initWithFrame:CGRectMake(280, 5, 30, 30)];
        [view1 addSubview:addbtn];
        [addbtn setBackgroundImage:[UIImage imageNamed:@"inactive-add-icon-1.png"] forState:UIControlStateNormal];
        [addbtn release];
        [addbtn addTarget:self action:@selector(addTaskAction) forControlEvents:UIControlEventTouchUpInside];
    
    }

    
	return [view1 autorelease];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    if(missionObj.missionType == DareMissiontype  ||missionObj.missionType == PrivateGroupMissionType)
    {
        return 2;
    }
    else  
    {
        return 1;
    }   

    
    return  1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if(missionObj.missionType == DareMissiontype )
    {
        if(section==0)
        {
            
            return 2;
            
            
        }
        else  if(section==1)
        {
            return  [missionObj.taskArray count];
        }  
    }
    else if(missionObj.missionType == PrivateGroupMissionType)
    {
        if(section==0)
        {
            return 1;
        }
        else  if(section==1)
        {
            return  [missionObj.taskArray count];
        }  
    }
    else  
    {
        return [missionObj.taskArray count];
    }   
    

    return  0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
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
                cell.labelSubTitle.textColor=[UIColor grayColor];
                cell.labelSubTitle.numberOfLines=2;
                cell.labelSubTitle.font=[UIFont fontWithName:FONT_NORMAL size:12];
                
                cell.rightImageview.frame=CGRectMake(280, 15, 30, 30);
                
                cell.labelTitle.frame=CGRectMake( cell.labelTitle.frame.origin.x-10,
                                                 cell.labelTitle.frame.origin.y, 
                                                 cell.labelTitle.frame.size.width-10,  
                                                 cell.labelTitle.frame.size.height);
                
                cell.labelSubTitle.frame=CGRectMake( cell.labelSubTitle.frame.origin.x-10,
                                                 cell.labelSubTitle.frame.origin.y, 
                                                 cell.labelSubTitle.frame.size.width-10,  
                                                 cell.labelSubTitle.frame.size.height);
              
                cell.leftImageview.image=[UIImage imageNamed:@"inactive add-friend-1.png"];
                
            
            }
        }
    }
    
    if(missionObj.missionType == DareMissiontype )
    {
        cell.rightImageview.image=[UIImage imageNamed:@"inactive-add-icon-1.png"];
        
        NSArray *challengerArray=[missionObj.challengersDict allValues];
        NSArray *spectatorsArray=[missionObj.spectatorDict allValues];
       
        if(indexPath.section==0)
        {
            if(indexPath.row==0)
            {
                cell.labelTitle.text=NSLocalizedString(@"Challengers", @"[mission]");
                
                NSString *challengerString=nil;
                
               for( NSDictionary *temp in challengerArray)
               {
                   if(challengerString==nil)
                   { challengerString=[temp objectForKey:@"first_name"];}
                   else
                   {  challengerString=[NSString stringWithFormat:@"%@,%@",challengerString,[temp objectForKey:@"first_name"]];}
               
               }
                cell.labelSubTitle.text= challengerString;
                //cell.leftImageview.image=((taskModel *)[missionObj.taskArray objectAtIndex:indexPath.row]).taskPhoto;
                
                
            }
            else if(indexPath.row==1)
            {
                cell.labelTitle.text=NSLocalizedString(@"Spectators", @"[mission]");
                
                NSString *spectatorString=nil;
                
                for( NSDictionary *temp in spectatorsArray)
                {
                    if(spectatorString==nil)
                    { spectatorString=[temp objectForKey:@"first_name"];}
                    else
                    {  spectatorString=[NSString stringWithFormat:@"%@,%@",spectatorString,[temp objectForKey:@"first_name"]];}
                    
                }
                
                if(spectatorString==nil)
                    spectatorString=@"";
                cell.labelSubTitle.text= spectatorString;

                //  cell.leftImageview.image=((taskModel *)[missionObj.taskArray objectAtIndex:indexPath.row]).taskPhoto;
                
            }
        }
        else   if(indexPath.section==1)
        {
            cell.rightImageview.image=[UIImage imageNamed:@"list-box-rearrange-icon-1.png"];
            
            NSString *titleString=((taskModel *)[missionObj.taskArray objectAtIndex:indexPath.row]).taskTitle;
            NSString *aboutString=((taskModel *)[missionObj.taskArray objectAtIndex:indexPath.row]).taskAbout;
            
            cell.labelTitle.text=titleString;
            cell.labelSubTitle.text=aboutString;
            cell.leftImageview.image=((taskModel *)[missionObj.taskArray objectAtIndex:indexPath.row]).taskPhoto;
        }   

    }
    else if(missionObj.missionType == PrivateGroupMissionType)
    {
        cell.rightImageview.image=[UIImage imageNamed:@"inactive-add-icon-1.png"];
        
        NSArray *challengerArray=[missionObj.challengersDict allValues];
        
        
        if(indexPath.section==0)
        {
            if(indexPath.row==0)
            {
                cell.labelTitle.text=NSLocalizedString(@"Challengers", @"[mission]");
              
                NSString *challengerString=nil;
                
                for( NSDictionary *temp in challengerArray)
                {
                    if(challengerString==nil)
                    { challengerString=[temp objectForKey:@"first_name"];}
                    else
                    {  challengerString=[NSString stringWithFormat:@"%@,%@",challengerString,[temp objectForKey:@"first_name"]];}
                    
                }
                cell.labelSubTitle.text= challengerString;

                //cell.leftImageview.image=((taskModel *)[missionObj.taskArray objectAtIndex:indexPath.row]).taskPhoto;
            }
        }
        else  if(indexPath.section==1)
        {
            cell.rightImageview.image=[UIImage imageNamed:@"list-box-rearrange-icon-1.png"];
            
            NSString *titleString=((taskModel *)[missionObj.taskArray objectAtIndex:indexPath.row]).taskTitle;
            NSString *aboutString=((taskModel *)[missionObj.taskArray objectAtIndex:indexPath.row]).taskAbout;
            
            cell.labelTitle.text=titleString;
            cell.labelSubTitle.text=aboutString;
            cell.leftImageview.image=((taskModel *)[missionObj.taskArray objectAtIndex:indexPath.row]).taskPhoto;
        }   
    }
    else  
    {
        cell.rightImageview.image=[UIImage imageNamed:@"list-box-rearrange-icon-1.png"];
        
        NSString *titleString=((taskModel *)[missionObj.taskArray objectAtIndex:indexPath.row]).taskTitle;
        NSString *aboutString=((taskModel *)[missionObj.taskArray objectAtIndex:indexPath.row]).taskAbout;
        
        cell.labelTitle.text=titleString;
        cell.labelSubTitle.text=aboutString;
        cell.leftImageview.image=((taskModel *)[missionObj.taskArray objectAtIndex:indexPath.row]).taskPhoto;
    }   

   
   
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(missionObj.missionType==DareMissiontype || missionObj.missionType==PrivateGroupMissionType )
    {
        if(indexPath.section==0 && indexPath.row==0)
        {
            
            pickChallengersViewController *VC=[[pickChallengersViewController alloc] 
                                               initWithNibName:@"pickChallengersViewController" 
                                               bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            [VC release];
            
        }
        if(indexPath.section==0 && indexPath.row==1)
        {
            pickSpectatorViewController *VC=[[pickSpectatorViewController alloc] 
                                             initWithNibName:@"pickSpectatorViewController" 
                                             bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            [VC release];
        }
    }
    
    
}



#pragma mark -
#pragma mark request Function Methods


-(BOOL)checkAllPhotoIsUploaded
{
    
    if([missionObj.photoDict count]==0)
    {
        return NO;
    }
    
    for(taskModel *task in missionObj.taskArray)
    {
        if([task.photoDict count]==0)
        {
            return  NO;
        }
    }
    
    return YES;
}

-(void) createMission
{   
    
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }
    
    [self.view setUserInteractionEnabled:NO];
    [self showSpinnerView:LoadingView mesage:NSLocalizedString(@"Creating...", @"create mission")];
    
    if([self checkAllPhotoIsUploaded])
    {
        ACLog(@"start creating mission");
        [self createMissionConnection:network mission:missionObj created_user:appDelegate.userMe.uid];
        countDown=0;
    }
    else
    {
        countDown=countDown+3;
        
        if(countDown<60)
        {
            [self performSelector:@selector(createMission) withObject:nil afterDelay:3.0];
            ACLog(@"waiting for creating mission");
        }
        else
        {
            [self hideSpinnerView:LoadingView];
            [self.view setUserInteractionEnabled:YES];
            [self showErrorAlert:NSLocalizedString(@"Please try Again!", @"mission")];
            ACLog(@"fail creating mission");
             countDown=0;
        }
    
    }

    
}

- (void)uploadMissionPhoto
{
 //   isAllRequestFinished=NO;
    
    
    
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }

    
	UIImage *img=missionObj.missionPhoto;
	NSData *data= UIImageJPEGRepresentation(img, 1);
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:data forKey:@"uploadedfile"];
	[dict setObject:appDelegate.userMe.sessionKey forKey:@"session_key"];
	[dict setObject:appDelegate.userMe.uid forKey:@"uid"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"missionphoto" forKey:@"id"];
	
	ASIFormDataRequest *request= [network createNewRequest:URL_POST_UPLOAD_PHOTO 
                                        keyValueDictionary:dict 
                                         addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[network addRequestToRequestsQueue:request];
}

- (void)uploadTaskPhoto:(taskModel *)obj
{
    
//    isAllRequestFinished=NO;
    
    
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }

    
    UIImage *img=obj.taskPhoto;
	NSData *data= UIImageJPEGRepresentation(img, 1);
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:data forKey:@"uploadedfile"];
	[dict setObject:appDelegate.userMe.sessionKey forKey:@"session_key"];
	[dict setObject:appDelegate.userMe.uid forKey:@"uid"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"taskphoto" forKey:@"id"];
    [ADDdict setObject:obj forKey:@"taskobj"];
	
	ASIFormDataRequest *request= [network createNewRequest:URL_POST_UPLOAD_PHOTO 
                                        keyValueDictionary:dict 
                                         addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[network addRequestToRequestsQueue:request];
}

#pragma mark -

/*
-(void)AllRequestFinish
{
    isAllRequestFinished=YES;
}
*/
-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	
    [self.view setUserInteractionEnabled:YES];
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		NSLog(@"No Data");
	}
    
    ACLog(@"%@",temp);
    
	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"missionphoto"])
	{
        missionObj.photoDict=[NSMutableDictionary dictionaryWithDictionary:temp];
    }
    
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"taskphoto"])
	{
        for(taskModel *obj  in missionObj.taskArray)
        {
        
            if(obj==[request.additionDataDictionary objectForKey:@"taskobj"])
            {
                obj.photoDict=[NSMutableDictionary dictionaryWithDictionary:temp];
              //  NSLog(@"%@",obj.photoDict);
            }
        
        }
    }
    
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"createmission"])
	{
        
        [self hideSpinnerView:LoadingView];
        [self.view setUserInteractionEnabled:YES];

        
        NSLog(@"%@",temp);
        if([temp objectForKey:@"errorMessage"] )
        {
            if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSNumber class]])
            {
                if([[temp objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]])
                {
                    [self showWarningAlert_ok];
                }
                else
                {
                  //  [self showErrorAlert:GLOBAL_ERROR_STRING];
                }
            }
            else
            {
              //  [self showErrorAlert:GLOBAL_ERROR_STRING];
                //[self showErrorAlert:NSLocalizedString(@"", @"create mission error")];
                
            }
        }
    }
    
    
	
}
-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{
	[self hideSpinnerView:LoadingView];
	
//	[photoSpinner stopAnimating];
//	[ScrollView setUserInteractionEnabled:YES];
//	[table setUserInteractionEnabled:YES];
	[self.view setUserInteractionEnabled:YES];
	
//	NSString *errorString =CONNECTION_ERROR_STRING;
//	[self showErrorAlert:errorString];
}

#pragma mark -
#pragma mark TSAlert Delegate Function Methods


- (void)alertView:(TSAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(alert.tag==0 && buttonIndex==0)
	{
		
	}
    if(alert.tag==1  && buttonIndex==0)
	{
		
	}
    if(alert.tag==2 && buttonIndex==0) //ok
	{
        
        [network cancelAllRequestsInRequestsQueue];
        [network cancelAllPhotoRequestsInRequestsQueue];
		[self cancelAllNotification];
        appDelegate.temp.missionObj=nil;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTheMissionICreated" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyMission" object:nil];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
	}

    //================================
    
    
    if(alert.tag==0 && buttonIndex==1)
	{
        [network cancelAllRequestsInRequestsQueue];
        [network cancelAllPhotoRequestsInRequestsQueue];	
        [self cancelAllNotification];
        appDelegate.temp.missionObj=nil;
        
        [self.navigationController popToRootViewControllerAnimated:YES];

		
	}
    if(alert.tag==1  && buttonIndex==1)
	{
        
        NSString *isShow=@"";
        if(switcher.on){
            isShow=@"1";}
        else{
            isShow=@"0";}
        
        for(taskModel *task in missionObj.taskArray)
        {
            if([task.photoDict count]==0)
            {
                [self uploadTaskPhoto:task];
            }
            
            task.showNext=isShow;
        }
        
        [self createMission];
	}
    if(alert.tag==2 && buttonIndex==1 )
	{
       
	}
}



@end
