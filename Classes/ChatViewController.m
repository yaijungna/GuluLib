//
//  ChatViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/7.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ChatViewController.h"

#import "guestListViewController.h"
#import "EventEditViewController.h"

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	network =[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
	
	
	if([[[[chatDictionary objectForKey:@"object"]objectForKey:@"inviter"] objectForKey:@"id"] isEqualToString:appDelegate.userMe.uid])
	{
		[topView.topRightButton addTarget:self action:@selector(EditAction) forControlEvents:UIControlEventTouchUpInside];
		[topView.topRightButton setTitle:NSLocalizedString(@"Edit",@"edit") forState:UIControlStateNormal];
		//((UIButton *)topView.topRightButton).hidden=YES;
	}
	else
	{
		[topView.topRightButton addTarget:self action:@selector(RSVPAction) forControlEvents:UIControlEventTouchUpInside];
		[topView.topRightButton setTitle:NSLocalizedString(@"R.S.V.P.",@"R.S.V.P.") forState:UIControlStateNormal];
	}	
	
	pickerBg=[[UIView alloc] initWithFrame:CGRectMake(0, 460, 320, 260)];
	[self.view  addSubview:pickerBg];
	[pickerBg release];
	pickerBg.backgroundColor=[UIColor blackColor];
	pickerBg.alpha=0.8;
	
	
	selectBtn=[[UIButton alloc] initWithFrame:CGRectMake(250, 5, 65, 34)];
	[pickerBg addSubview:selectBtn];
	[selectBtn release];
	[selectBtn setBackgroundImage:[UIImage imageNamed:@"button-1.png"] forState:UIControlStateNormal];
	[selectBtn setTitle:GLOBAL_DONE_STRING forState:UIControlStateNormal];
	[selectBtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:14]];
	[selectBtn addTarget:self action:@selector(PickerDoneAction) forControlEvents:UIControlEventTouchUpInside];
	
	
	RSVPPicker =[[UIPickerView alloc] initWithFrame:CGRectMake(0,44 , 320, 216)];
	RSVPPicker.delegate=self;
	RSVPPicker.dataSource=self;
	RSVPPicker.showsSelectionIndicator=YES;
	[pickerBg addSubview:RSVPPicker];
	[RSVPPicker release];
    
    
    [self enterChatRoom];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {	
	[tableHeaderView release];
    [network release];
	
    [super dealloc];
}

#pragma mark -
#pragma mark action Function Methods


- (void)pickerUp 
{
	[self  moveTheView:pickerBg movwToPosition:CGPointMake(0, 200)];
}

- (void)pickerDown 
{
	[self  moveTheView:pickerBg movwToPosition:CGPointMake(0, 460)];
}

- (void)backAction 
{
	[network cancelAllRequestsInRequestsQueue];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)landingAction 
{
	[network cancelAllRequestsInRequestsQueue];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)RSVPAction 
{
	[self pickerUp];
}

- (void)EditAction 
{

	[self  shareGULUAPP];
	
	appDelegate.temp.inviteObj=[[[inviteModel alloc] init] autorelease];
	appDelegate.temp.inviteObj.EventTitle=[[chatDictionary objectForKey:@"object"] objectForKey:@"title"];
	appDelegate.temp.inviteObj.restaurantDict=[[chatDictionary objectForKey:@"object"] objectForKey:@"restaurant"];
	appDelegate.temp.inviteObj.dateString=[[chatDictionary objectForKey:@"object"] objectForKey:@"start_time"];
	appDelegate.temp.inviteObj.eid=[[chatDictionary objectForKey:@"object"] objectForKey:@"id"];
	
	NSMutableArray *contactArray=[[chatDictionary objectForKey:@"object"]objectForKey:@"guest_list"];
	NSMutableDictionary *contactDict=[[[NSMutableDictionary alloc] init] autorelease];

	
	for( NSDictionary *dict in contactArray)
	{
		NSMutableDictionary *newDict=[NSMutableDictionary dictionaryWithDictionary:dict];
		[newDict setObject:@"1" forKey:@"alreadyIn"];
		[contactDict setObject:newDict forKey:[newDict objectForKey:@"contact_id"] ];
	}
	
	appDelegate.temp.inviteObj.contactDict=contactDict;
	
	//NSLog(@"%@",appDelegate.temp.inviteObj.contactDict);
	
	EventEditViewController *VC=[[EventEditViewController alloc] initWithNibName:@"EventEditViewController" bundle:nil];
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];
	

}
- (void)guestListAction 
{
	guestListViewController *VC=[[guestListViewController alloc] initWithNibName:@"guestListViewController" bundle:nil];
	VC.eid=[[chatDictionary objectForKey:@"object"] objectForKey:@"id"];
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];
}


-(void)PickerDoneAction
{
	[self pickerDown];

	if(selectRow==0)
	{
		[self attendEvent];
	}
	else if (selectRow==1) 
	{
		[self refuseEvent];
	}

}

#pragma mark -
#pragma mark tableView Delegate Function Methods


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
	
	NSDictionary *restaurantDict=[[chatDictionary objectForKey:@"object"] objectForKey:@"restaurant"];
    
    if([restaurantDict isEqual:[ NSNull null]])
    {
        restaurantDict=nil;
    }
    
	NSString *eventTitle =[[chatDictionary objectForKey:@"object"] objectForKey:@"title"];
	NSString *start_time =[[chatDictionary objectForKey:@"object"] objectForKey:@"start_time"];
	NSString *name=[restaurantDict objectForKey:@"name"];
    if(name==nil)
        name=@"";
	NSString *date=[ACUtility dateStringToDateFormatString:start_time];
	tableHeaderView.label1.text=[NSString stringWithFormat:@"%@ @ %@",eventTitle,name];
	tableHeaderView.label2.text=date;
    
    if(start_time==nil || [start_time isEqual:[NSNull null]])
    {
        tableHeaderView.label2.hidden=YES;
    }
	
	if([[[chatDictionary objectForKey:@"object"] objectForKey:@"status"] isEqualToNumber:[NSNumber numberWithInt:1]])
	{
		tableHeaderView.label3.text=NSLocalizedString(@"You need to R.S.V.P",@"invite");
	}
	else if([[[chatDictionary objectForKey:@"object"] objectForKey:@"status"] isEqualToNumber:[NSNumber numberWithInt:2]])
	{
		tableHeaderView.label3.text=NSLocalizedString(@"You are attending.",@"invite");
	}
	else if([[[chatDictionary objectForKey:@"object"] objectForKey:@"status"] isEqualToNumber:[NSNumber numberWithInt:3]])
	{
		tableHeaderView.label3.text=NSLocalizedString(@"You are not going!",@"invite");
	}
	
	if([[[[chatDictionary objectForKey:@"object"]objectForKey:@"inviter"] objectForKey:@"id"] isEqualToString:appDelegate.userMe.uid])
	{
		tableHeaderView.label3.text=NSLocalizedString(@"You created this event.",@"invite");
	}
	
	[tableHeaderView.rightBtn.btn addTarget:self action:@selector(guestListAction) forControlEvents:UIControlEventTouchUpInside];
	
	
	return tableHeaderView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 1;
}


#pragma mark -
#pragma mark PickerView Delegate Function Methods

//PickerViewController.m
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
	return 2;
}

//PickerViewController.m
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	if(row==0)
	{
		return NSLocalizedString(@"I am going!",@"RSVP");
	}
	if(row==1)
	{
		return NSLocalizedString(@"I am not going!",@"RSVP");
	}
	
	return nil;

}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	selectRow=row;
}
#pragma mark -
#pragma mark request Delegate Function Methods


- (void)attendEvent  
{
	NSString *eid=[[chatDictionary objectForKey:@"object"] objectForKey:@"id"];
	[self attendEventConnection:network eventID:eid];
}

- (void)refuseEvent  
{
	NSString *eid=[[chatDictionary objectForKey:@"object"] objectForKey:@"id"];
	[self refuseEventConnection:network eventID:eid];
}

#pragma mark -

-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		NSLog(@"No Data");
	}
	
	NSLog(@"temp %@",temp);
	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"attendEvent"])
	{
		
		if([[temp objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]])
		{
			tableHeaderView.label3.text=NSLocalizedString(@"You are attending.",@"invite");
		}
		else
		{
			NSString *errorString =[temp objectForKey:@"errorMessage"];
			[self showErrorAlert:errorString];
		}
	}
	else if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"refuseEvent"])
	{
		if([[temp objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]])
		{
			tableHeaderView.label3.text=NSLocalizedString(@"You are not going!",@"invite");
		}
		else
		{
			NSString *errorString =[temp objectForKey:@"errorMessage"];
			[self showErrorAlert:errorString];
		}
		
	}
	
	
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	
	NSString *errorString =CONNECTION_ERROR_STRING;
	[self showErrorAlert:errorString];
}




@end
