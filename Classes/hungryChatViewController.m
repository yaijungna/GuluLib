//
//  hungryChatViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/15.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "hungryChatViewController.h"


@implementation hungryChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    ((UIButton *)topView.topRightButton).hidden=YES;
    
    [self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
	
	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	[LoadingView release];
	LoadingView.hidden=YES;
    
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

#pragma mark -
#pragma mark tabel Function Methods
/*
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
*/

#pragma mark -
#pragma mark request Delegate Function Methods

#pragma mark -

-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	
/*	[self hideSpinnerView:LoadingView];
	
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		NSLog(@"No Data");
	}
	
	NSLog(@"temp %@",temp);
	
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
	*/
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	
/*	[self hideSpinnerView:LoadingView];
	
	NSString *errorString =CONNECTION_ERROR_STRING;
	[self showErrorAlert:errorString];*/
}


@end;

