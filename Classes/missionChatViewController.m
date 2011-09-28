//
//  missionChatViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/7.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "missionChatViewController.h"

#import "missionProfileviewcontroller.h"

#import "recruitViewController.h"

@implementation missionChatViewController

@synthesize fromProfile;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // [topView.topRightButton setTitle:NSLocalizedString(@"Recruit", @"[mission] recruit people") forState:UIControlStateNormal];
    [topView.topRightButton setTitle:NSLocalizedString(@"Profile", @"[mission]") forState:UIControlStateNormal];
    [topView.topRightButton addTarget:self action:@selector(gotoMissionProfile) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
	
	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	[LoadingView release];
	LoadingView.hidden=YES;
    
    missionDict = [chatDictionary objectForKey:@"object"];
   // NSLog(@"%@",missionDict);
    
    NSNumber *member_status=[missionDict objectForKey:@"member_status"];
      
    if([member_status isEqualToNumber:[NSNumber numberWithInt:0]])  // i have been recruited
    {
        [self showRecruitAlert];
    }
    
    [self enterChatRoom];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


- (void)dealloc
{
    [network release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


#
#pragma mark -
#pragma mark action Function Methods


- (void)backAction 
{
    [network cancelAllRequestsInRequestsQueue];    
    [super backAction];
}

- (void)landingAction
{
    [network cancelAllRequestsInRequestsQueue];
    [super landingAction];
}

- (void)gotoMissionProfile
{
    
    if(fromProfile)
    {
        [self backAction];
        return;
    }
    
    missionProfileviewcontroller *VC=[[missionProfileviewcontroller alloc] initWithNibName:@"missionProfileviewcontroller" bundle:nil];
    
    VC.missionDict=[chatDictionary objectForKey:@"object"];
    VC.fromChat=YES;
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];
    
}

- (void)gotoRecruit
{
    recruitViewController *VC=[[recruitViewController alloc] initWithNibName:@"choseFriendViewController" bundle:nil];
    VC.missionDict=[chatDictionary objectForKey:@"object"];
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];
}

- (void)showRecruitAlert
{

    recruitAlert = [[[TSAlertView alloc] init] autorelease];
    recruitAlert.title =NSLocalizedString(@"Warning!",@"Warning alert to notify user.");
	recruitAlert.message = NSLocalizedString(@"Join this mission?",@"Warning alert to notify user.") ;
    recruitAlert.delegate=self;
    [recruitAlert addButtonWithTitle: GLOBAL_NO_STRING];
    [recruitAlert addButtonWithTitle: GLOBAL_YES_STRING];
	[recruitAlert show];
    
  
}


#pragma mark -
#pragma mark tabel Function Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	tableHeaderView = [[ChatEventHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 75)] ;
	[self customizeLabel_title:tableHeaderView.label1];
	[self customizeLabel:tableHeaderView.label2];
	tableHeaderView.label2.textColor=[UIColor grayColor];
	[self customizeLabel:tableHeaderView.label3];
	tableHeaderView.label3.textColor=[UIColor grayColor];
    
    missionDict=[chatDictionary objectForKey:@"object"];
    
	NSString *Title =[missionDict objectForKey:@"title"];
	NSString *username =[[missionDict objectForKey:@"created_user"] objectForKey:@"username"];
	NSString *about=[missionDict objectForKey:@"description"];
    tableHeaderView.label1.text=Title;
	tableHeaderView.label2.text=[NSString stringWithFormat:@"%@ %@",
                                 NSLocalizedString(@"This mission is created by", @"[grade mission]"),
                                 username];
    tableHeaderView.label3.text=about;
    
    tableHeaderView.rightBtn.hidden=NO;
    [tableHeaderView.rightBtn.btn addTarget:self action:@selector(gotoRecruit) forControlEvents:UIControlEventTouchUpInside];
    tableHeaderView.rightBtn.btnTitleLabel.text=NSLocalizedString(@"Recruit", @"[mission] recruit people");
	
    
	return tableHeaderView;
}

#pragma mark -
#pragma mark request Delegate Function Methods

- (void)refuseRecruit
{
    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    NSString *gid=[missionDict objectForKey:@"group_id"]; 
    [self rejectRecruitMissionConnection:network groupID:gid];
}

- (void)joinRecruit
{
    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    NSString *gid=[missionDict objectForKey:@"group_id"]; 
    [self acceptRecruitMissionConnection:network groupID:gid];
    
}


#pragma mark -

-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
	
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		//NSLog(@"No Data");
       ACLog(@"No Data");
	}
	
	//NSLog(@"temp %@",temp);
    ACLog(@"request ok");
	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"acceptrecruit"])
	{		
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSNumber class]])
        {
            if([[temp objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyMission" object:nil];
                return;
            }
        }
    }
    
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"rejectrecruit"])
	{		
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSNumber class]])
        {
            if([[temp objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]])
            {
                [self.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyMission" object:nil];
                
                return;
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
#pragma mark TSAlert Delegate Function Methods


- (void)alertView:(TSAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex==0)
    {
        [self refuseRecruit];
        
    }
    if(buttonIndex==1)
    {
        
        [self joinRecruit];
    }
    
}



@end
