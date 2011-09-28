//
//  SettingsViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/15.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "SettingsViewController.h"
#import "ACTableOneLineWithImageCell.h"
#import "oneLineTableHeaderView.h"
#import "userProfileViewController.h"
#import "UserVoice.h"

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray  *array=[NSArray arrayWithObjects:
                     NSLocalizedString(@"Notifications", @"[settings]Main tab"),
                     //    NSLocalizedString(@"Design Mission", @"[mission]Main tab"),
                     NSLocalizedString(@"Settings", @"[settings]Main tab"),nil];
	
	//segment=[[ACSegmentController alloc] initWithFrame:CGRectMake(0, 40, 320, 40)];
	segment=[[ACSegmentController alloc] initWithFrame:CGRectMake(0, 40, 320, 40)];
	[segment initCustomSegment:array 
                   normalimage:[UIImage imageNamed:@"seg02-2.png"]
                 selectedimage:[UIImage imageNamed:@"seg02-1.png"] 
                      textfont:[UIFont fontWithName:FONT_BOLD size:10]];
	[segment setSelectedButtonAtIndex:0];
	segment.delegate=self;
	[self.view addSubview:segment];
	[segment release];	
    [self touchSegmentAtIndex:0];

	
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
	[self.view addSubview:topView];
	[topView release];
	
	[topView.topLeftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	
	strArray=[[NSArray alloc] initWithObjects:
					   SETTINGS_MYRPOFILE_STRING,
                 //    SETTINGS_NOTIFICATION_STRING,
				/*	   SETTINGS_SOCIALNETWORK_STRING,
					   SETTINGS_PRIVACY_STRING,*/
					   SETTINGS_SENDFEDDBACK_STRING,
					   SETTINGS_LOGOUT_STRING,
					   nil];
	
	photoArray=[[NSArray alloc] initWithObjects:
						 @"my-profile-icon-1.png",
             //           @"notifications-icon-1.png",
			/*			 @"social-networks-icon-1.png",
						 @"privacy-icon-1.png",*/
						 @"send-feedback-icon-1.png",
						 @"log-out-icon-1.png",
						 nil] ;
	
	[self customizeTableView:table];
	table.delegate=self;
	table.dataSource=self;
    
    notifyVC=[[notificationViewController alloc] initWithNibName:@"notificationViewController" bundle:nil];
    notifyVC.navigationController=self.navigationController;
    [self.view addSubview:notifyVC.view];
    [notifyVC.view setFrame:table.frame];
    
    
    //==========
    
    network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
    
    LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	LoadingView.hidden=YES;
	
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
}


- (void)dealloc {
    [notifyVC release];
	[strArray release];
	[photoArray release];
    [network release];
    [LoadingView release];
    [super dealloc];
}


#pragma mark -
#pragma mark segment Delegate Function Methods

- (void) touchSegmentAtIndex:(NSInteger)segmentIndex
{
    table.hidden=YES;
    notifyVC.view.hidden=YES;
    
    if(segmentIndex==0)
    {
       notifyVC.view.hidden=NO;
    }
    if(segmentIndex==1)
    {
        table.hidden=NO;
    }
}


#pragma mark -
#pragma mark action Function Methods


- (void)backAction 
{
    [network cancelAllRequestsInRequestsQueue];
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark table Function Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    oneLineTableHeaderView *view1 = [[[oneLineTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)]autorelease];
    
    view1.label1.text=NSLocalizedString(@"Settings",@"[title]");
    view1.rightBtn.hidden=YES;
    [self customizeLabel:view1.label1];
    
	return view1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [strArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellIdentifier = @"ACTableOneLineWithImageCell";
	static NSString *nibNamed = @"ACTableOneLineWithImageCell";
	
	ACTableOneLineWithImageCell *cell = (ACTableOneLineWithImageCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil];
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell= (ACTableOneLineWithImageCell*) currentObject;
				[cell initCell];
			}
		}
	}
	
	if(indexPath.row==settings_Notification)
	{
		cell.switcher.hidden=YES;
	}
	else
	{
		cell.switcher.hidden=YES;
		
	}

	
	cell.leftImageview.image=[UIImage imageNamed:[photoArray objectAtIndex:indexPath.row]];
	cell.label1.text=[strArray objectAtIndex:indexPath.row];
	
		
	return cell;
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

	if(indexPath.row==settings_Notification   ||  indexPath.row==settings_socialNetwork)
	{
		//UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexPath];
		//[((ACTableOneLineWithImageCell *)cell) setArrowDirection];
        
        notificationViewController *VC=[[notificationViewController alloc] initWithNibName:@"notificationViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
      
       
	}
	
	
	if(indexPath.row==settings_profile)
	{
		userProfileViewController *VC=[[userProfileViewController alloc] initWithNibName:@"userProfileViewController" bundle:nil];	
		VC.userDict=[NSMutableDictionary dictionaryWithDictionary:appDelegate.userMe.userDictionary];
		[self.navigationController pushViewController:VC animated:YES];
		[VC release];
	}
    
    if(indexPath.row==settings_sendFeedback)
	{
       /* 
         [UserVoice presentUserVoiceModalViewControllerForParent:self
         andSite:UserVoiceSite
         andKey:UserVoiceKey
         andSecret:UserVoiceSecret];
        
        */
        
        if(![ACCheckConnection isConnectedToNetwork])
        {
            NSString *errorString =CONNECTION_ERROR_STRING;
            [self showErrorAlert:errorString];
            return;
        }

        
        [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
        [self getUserVoiceTokenConnection:network];
        

        
	}
	
	
	if(indexPath.row==settings_Logout)
	{
        TSAlertView* av = [[[TSAlertView alloc] init] autorelease];
        av.title =GLOBAL_WARNING_STRING;
        av.message = SETTINGS_LOGOUT_WARNING_STRING;
        av.delegate=self;
        [av addButtonWithTitle: GLOBAL_NO_STRING];
        [av addButtonWithTitle: GLOBAL_YES_STRING];
        [av show];
	}
    
}

#pragma mark -
#pragma mark TSAlert Delegate Function Methods


- (void)alertView:(TSAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1) //logout
    {
        //====== alan add these ==
        [((UVToken *)[UVSession currentSession].currentToken) remove];
        [[UVSession currentSession] clearSession];
        //======
        
        [self shareGULUAPP];
        [appDelegate.userMe logout];
        [appDelegate reBoot];
        [appDelegate clearDB];
    }    
}



#pragma mark -
#pragma mark request Delegate Function Methods

-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	
    [self hideSpinnerView:LoadingView];
    NSData *data1= [request responseData];
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

	
    ACLog(@"temp %@",temp);
    ACLog(@"request ok");
    

	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"uservoice"])
	{
        if([temp objectForKey:@"sso_token"])
        {
            NSString *token=[temp objectForKey:@"sso_token"];
            
            ACLog(@"token %@",token);
            
            [UserVoice presentUserVoiceModalViewControllerForParent:self andSite:UserVoiceSite andKey:UserVoiceKey andSecret:UserVoiceSecret andSsoToken:token];
        }
    }
	
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	
    [self hideSpinnerView:LoadingView];
    ACLog(@"request fail");
}






@end
