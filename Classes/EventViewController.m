//
//  EventViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/22.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "EventViewController.h"
#import "ContactListViewController.h"
#import "Invite_SearchRestaurantViewController.h"
#import "oneLineTableHeaderView.h"

#import "ACTableOneLineWithImageCell.h"

@implementation EventViewController

@synthesize inviteObj;
@synthesize event;

-(void) initViewController
{
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeSend];
	[self.view addSubview:topView];
	[topView release];
	[topView.topLeftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topRightButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
	((UIButton *) topView.topRightButton).enabled=NO;
	
	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	LoadingView.hidden=YES;	
	
	eventTitleLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 60, 300, 30)];
	[myView addSubview:eventTitleLabel];
	[eventTitleLabel release];
	[self customizeLabel_title:eventTitleLabel];
	eventTitleLabel.text=INVITE_WHAT_EVENT_STRING;
	
	titleTextField=[[UITextField alloc] initWithFrame:CGRectMake(10, 90, 300, 30)];
	titleTextField.delegate=self;
	[myView addSubview:titleTextField];
	[titleTextField release];
	[self customizeTextField:titleTextField];
	titleTextField.placeholder=INVITE_WHAT_PLACEHOLDER_STRING;
	[titleTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
	
	
	whereTitleLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 120, 300, 30)];
	[myView addSubview:whereTitleLabel];
	[whereTitleLabel release];
	[self customizeLabel_title:whereTitleLabel];
	whereTitleLabel.text=INVITE_WHERE_EVENT_STRING;
	
	whereTextField=[[UITextField alloc] initWithFrame:CGRectMake(10, 150, 300, 30)];
	whereTextField.delegate=self;
	[myView addSubview:whereTextField];
	[whereTextField release];
	[self customizeTextField:whereTextField];
	whereTextField.placeholder=INVITE_WHERE_PLACEHOLDER_STRING;
	
	whenTitleLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 180, 300, 30)];
	[myView addSubview:whenTitleLabel];
	[whenTitleLabel release];
	[self customizeLabel_title:whenTitleLabel];
	whenTitleLabel.text=INVITE_WHEN_EVENT_STRING;
	
	whenTextField=[[UITextField alloc] initWithFrame:CGRectMake(10, 210, 300, 30)];
	whenTextField.delegate=self;
	[myView addSubview:whenTextField];
	[whenTextField release];
	[self customizeTextField:whenTextField];
	whenTextField.placeholder=INVITE_WHEN_PLACEHOLDER_STRING;
	
	
	table = [[UITableView alloc] initWithFrame:CGRectMake(0, 250, 320, 210)];
	table.delegate=self;
	table.dataSource=self;
	[myView addSubview:table];
	[table release];
	[self customizeTableView:table];
	table.hidden=YES;
	
	
	inviteBtn=[ACCreateButtonClass createButton:ButtonTypeInviteGuests];
	[inviteBtn setFrame:CGRectMake( 160-inviteBtn.frame.size.width/2, 250, inviteBtn.frame.size.width, inviteBtn.frame.size.height)];
	[myView addSubview:inviteBtn];
	[inviteBtn addTarget:self action:@selector(gotoContactListAction) forControlEvents:UIControlEventTouchUpInside];
	
	
	//======================
	
	datePickerBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 460, 320, 250)];
	[myView addSubview:datePickerBackgroundView];
	[datePickerBackgroundView release];
	datePickerBackgroundView.backgroundColor=[UIColor blackColor];
	datePickerBackgroundView.alpha=0.8;
	
	datePickerDonebtn=[[UIButton alloc] initWithFrame:CGRectMake(250, 5, 65, 30)];
	[datePickerBackgroundView addSubview:datePickerDonebtn];
	[datePickerDonebtn release];
	[datePickerDonebtn setBackgroundImage:[UIImage imageNamed:@"button-1.png"] forState:UIControlStateNormal];
	[datePickerDonebtn setTitle:GLOBAL_DONE_STRING forState:UIControlStateNormal];
	[datePickerDonebtn.titleLabel setFont:[UIFont fontWithName:FONT_NORMAL size:14]];
	[datePickerDonebtn addTarget:self action:@selector(datePickerDoneAction) forControlEvents:UIControlEventTouchUpInside];
    
    datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 320, 210)];
	[datePickerBackgroundView addSubview:datePicker];
	[datePicker release];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
	datePicker.date=[[[NSDate alloc] init] autorelease];
     
	
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(callBackChangeContactListFunction)
	 name: @"ChangeContactList"
	 object:nil];
	
	
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(callBackSelectRestaurantFunction)
	 name: @"SelectRestaurant"
	 object:nil];
	
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
	
	
}

- (void)showData 
{
	[self shareGULUAPP];
		
	if(appDelegate.temp.inviteObj==nil)
	{
		self.inviteObj=[[[inviteModel alloc] init] autorelease];
		appDelegate.temp.inviteObj=inviteObj;
		NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
		appDelegate.temp.inviteObj.contactDict=dict;
	}
	else 
	{
		self.inviteObj=appDelegate.temp.inviteObj;
	}
	
	//  invite from somewhere not from create event
		
	if(inviteObj.restaurantDict)
	{
		whereTextField.text=[inviteObj.restaurantDict objectForKey:@"name"];
		whereTextField.enabled=NO;
	}
	
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
	[self initViewController];
	[self showData];
	[self sendButton_hidden_or_show_up];
}


- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];

}

- (void)viewDidUnload {
    [super viewDidUnload];

}


- (void)dealloc {
	[inviteObj release];
	[network release];
    [LoadingView release];
    [event release];
    [super dealloc];
}

#pragma mark -
#pragma mark action Function Methods

-(void)sendButton_hidden_or_show_up
{
	
	if( [titleTextField.text isEqualToString:@""] ||
	   titleTextField.text==nil ||
	   inviteObj.restaurantDict==nil ||
	   [inviteObj.restaurantDict count]==0 ||
	   [inviteObj.dateString isEqualToString:@""] ||
	   inviteObj.dateString==nil||
	   [inviteObj.contactDict count]==0 ||
	   inviteObj.contactDict==nil)
	{
		((UIButton *)topView.topRightButton).enabled=NO;
	}
	else 
	{
		((UIButton *)topView.topRightButton).enabled=YES;
	}

	
}


-(void)callBackChangeContactListFunction
{
	NSLog(@"%@",inviteObj.contactDict);
	
	if([inviteObj.contactDict count]!=0)
	{
		inviteBtn.hidden=YES;
		table.hidden=NO;
	}
	else
	{
		inviteBtn.hidden=NO;
		table.hidden=YES;
	}
	
	[table reloadData];
	[self sendButton_hidden_or_show_up];

}

-(void)callBackSelectRestaurantFunction
{
	NSLog(@"%@",inviteObj.restaurantDict);
	
	whereTextField.text=[inviteObj.restaurantDict objectForKey:@"name"];
	[self sendButton_hidden_or_show_up];
}


- (void)gotoContactListAction 
{
	
	ContactListViewController *VC=[[ContactListViewController alloc] initWithNibName:@"ContactListViewController" bundle:nil];
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];
	
}

- (void)backAction 
{
	self.inviteObj=nil;
	appDelegate.temp.inviteObj=nil;
	[network cancelAllRequestsInRequestsQueue];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)datePickerUp
{
	[self moveTheView:datePickerBackgroundView movwToPosition:CGPointMake(0, 210)];
}

- (void)datePickerDown
{
	[self moveTheView:datePickerBackgroundView movwToPosition:CGPointMake(0, 460)];
}

- (void)datePickerDoneAction
{
	[self datePickerDown];
	
	inviteObj.dateString=[ACUtility nsdateTofloatString:[datePicker date]];
	ACLog(@"%@",inviteObj.dateString);
	
    whenTextField.text=[ACUtility dateStringToDateFormatDate:[datePicker date]];
	
	[self sendButton_hidden_or_show_up];
}


- (void)submitAction 
{
    
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }
	
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
	
	NSString *rid=[inviteObj.restaurantDict objectForKey:@"id"];
	NSArray *array=[inviteObj.contactDict allValues];	
	NSString *contact_list=nil;
	
	for(int i=0;i<[array count];i++)
	{
		if(i==0)
		{
			contact_list=[[array objectAtIndex:i] objectForKey:@"id"];
		}
		else
		{
			contact_list=[NSString stringWithFormat:@"%@|%@",contact_list,[[array objectAtIndex:i] objectForKey:@"id"]];
		}
	}
	
	NSLog(@"%@",contact_list);
	
	[self createEventConnection:network restaurantID:rid
						  Title:titleTextField.text
						   date:inviteObj.dateString
					   contacts:contact_list];
}


#pragma mark -
#pragma mark TextField Delegate Function Methods


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	
	
	if(textField == titleTextField)
	{
		if(textField.text==nil)
			textField.text=@"";
		
		inviteObj.EventTitle=textField.text;
		
		NSLog(@"%@",inviteObj.EventTitle);
		
		return YES;
	}
	else if(textField == whereTextField)
	{
		
		return NO;	
	}
	else if(textField == whenTextField) 
	{
		return NO;
	}
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if(textField == titleTextField)
	{
		[self datePickerDown];
		return YES;
	}
	else if(textField == whereTextField)
	{
		Invite_SearchRestaurantViewController *VC=[[Invite_SearchRestaurantViewController alloc] initWithNibName:@"Invite_SearchRestaurantViewController" bundle:nil];
		[self.navigationController pushViewController:VC animated:YES];
		[VC release];
		
		return NO;	
	}
	else if(textField == whenTextField) 
	{
		[titleTextField resignFirstResponder];
		[self datePickerUp];
		return NO;
	}
	
	return NO;
}

- (void) textFieldChange :(UITextField *)textField
{
	[self sendButton_hidden_or_show_up];
}

#pragma mark -
#pragma mark tableView Delegate Function Methods


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 37;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	oneLineTableHeaderView *view1 = [[oneLineTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
//	view1.nameLabel.text=appDelegate.userMe.username;
	
	view1.rightBtn=[[[UIButton alloc] initWithFrame:CGRectMake(320-10-30, 3, 30,30 )] autorelease];
	[view1.rightBtn setBackgroundImage:[UIImage imageNamed:@"inactive-add-icon-1.png"] forState:UIControlStateNormal];
	[view1 addSubview:view1.rightBtn];
	[view1.rightBtn addTarget:self action:@selector(gotoContactListAction) forControlEvents:UIControlEventTouchUpInside];
	
	
	[self customizeLabel_title:view1.label1];
	view1.label1.text=INVITE_YOUR_GUESTS_STRING;
	
	
	return [view1 autorelease];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	[self shareGULUAPP];
	
	NSArray *arr =[appDelegate.temp.inviteObj.contactDict allValues];
	
	return [arr count];
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
				cell.leftImageview.hidden=YES;
				cell.rightImageview.hidden=YES;
				CGRect Frame=cell.label1.frame;
				[cell.label1 setFrame:CGRectMake(Frame.origin.x-30, Frame.origin.y, Frame.size.width, Frame.size.height)];
				cell.switcher.hidden=YES;
				
			}
		}
	}
	
	NSArray *arr =[appDelegate.temp.inviteObj.contactDict allValues];
	NSMutableDictionary *dict=[arr objectAtIndex:indexPath.row];
	
	NSString *firstname=[dict objectForKey:@"first_name"];
	NSString *lastname=[dict objectForKey:@"last_name"];
	
	if(firstname ==nil || [firstname isEqual:[NSNull null]])
		firstname=@"";
	
	if(lastname ==nil || [lastname isEqual:[NSNull null]])
		lastname=@"";
	
	
	cell.label1.text=[NSString stringWithFormat:@"%@ %@",firstname,lastname];

	
	
	return cell;
}


#pragma mark -
#pragma mark request Delegate Function Methods


- (void)getMyTodo 
{
	/*self.tableView.userInteractionEnabled=NO; 
	self.imageLoaderDictionary_post=[[NSMutableDictionary alloc] init];
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
	[self toDoListConnection:network];*/
}

#pragma mark -

-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
	self.view.userInteractionEnabled=YES; 
	
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		NSLog(@"No Data");
	}
	
	NSLog(@"temp %@",temp);
    
    
    if([temp  isKindOfClass:[NSDictionary class]])
    {
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
        {
            NSString *errorString =CONNECTION_ERROR_STRING;
            [self showErrorAlert:errorString];
            return;
        }
    }

	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"createEvent"])
	{
		appDelegate.temp.inviteObj=nil;
		
		if([[temp objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]])
		{
			
			[[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChat" object:nil];
			[self.navigationController popToRootViewControllerAnimated:YES];
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
	[self hideSpinnerView:LoadingView];	
	
	NSString *errorString =CONNECTION_ERROR_STRING;
	[self showErrorAlert:errorString];
}




@end
