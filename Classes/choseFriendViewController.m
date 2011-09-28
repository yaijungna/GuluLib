//
//  choseFriendViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "choseFriendViewController.h"
#import "ACTableOneLineWithImage_Checkbox_Cell.h"

@implementation choseFriendViewController

@synthesize usersArray;
@synthesize chosedDict;

-(void)initViewController
{
    
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] 
             initTopBarView:ButtonTypeBack 
             middle:ButtonTypeGuluLogo 
             right:ButtonTypeDone];
	[self.view addSubview:topView];
	[topView release];
    
    [topView.topLeftButton addTarget:self 
                              action:@selector(backAction) 
                    forControlEvents:UIControlEventTouchUpInside];
    
    [topView.topRightButton addTarget:self 
                               action:@selector(nextAction) 
                     forControlEvents:UIControlEventTouchUpInside];
    
    

    [self customizeTextField:searchTextField];
    [self customizeTableView:table];
    
    searchTextField.placeholder=NSLocalizedString(@"Search friends.",@"[friend]" );
    
    [searchTextField setReturnKeyType:UIReturnKeySearch];
    
	[self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
	
    LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	LoadingView.hidden=YES;
    
    self.chosedDict=[[[NSMutableDictionary alloc] init] autorelease];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initViewController];
	[self getFriendUser];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
}

- (void)dealloc {
    
    [network cancelAllRequestsInRequestsQueue];
    
    [network release];
    [usersArray release];
    [chosedDict release];
    
    [LoadingView release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark action Function Methods


- (void)backAction 
{
    [network cancelAllRequestsInRequestsQueue];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)landingAction 
{
    
    [network cancelAllRequestsInRequestsQueue];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)nextAction 
{
     // need to overwrite this function
}



#pragma mark -
#pragma mark Table Delegate Function Methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [usersArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *cellIdentifier = @"ACTableOneLineWithImage_Checkbox_Cell";
	static NSString *nibNamed = @"ACTableOneLineWithImage_Checkbox_Cell";
	
	ACTableOneLineWithImage_Checkbox_Cell *cell = (ACTableOneLineWithImage_Checkbox_Cell*) [theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil];
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell= (ACTableOneLineWithImage_Checkbox_Cell*) currentObject;
				[cell initCell];
				cell.leftImageview.frame=CGRectMake(cell.leftImageview.frame.origin.x,
													cell.leftImageview.frame.origin.y-5, 
													cell.leftImageview.frame.size.width+10, 
													cell.leftImageview.frame.size.height+10);
				cell.checkBox.userInteractionEnabled=NO;
			}
		}
	}
    
    NSDictionary *userDict=[usersArray objectAtIndex:indexPath.row];
    NSString *firstname=[userDict  objectForKey:@"first_name"];
    NSString *lastname=[userDict  objectForKey:@"last_name"];
    
	if(firstname ==nil || [firstname isEqual:[NSNull null]])
		firstname=@"";
	
	if(lastname ==nil || [lastname isEqual:[NSNull null]])
		lastname=@"";
	
	
	cell.label1.text=[NSString stringWithFormat:@"%@ %@",firstname,lastname];
    
    NSDictionary *dict =[usersArray objectAtIndex:indexPath.row ];
	
	if([chosedDict objectForKey:[dict objectForKey:@"id"]])
	{
		cell.checkBox.selected=YES;
	}
	else
	{
		cell.checkBox.selected=NO;
	}

    

	return cell;
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexPath];
	NSDictionary *dict =[usersArray objectAtIndex:indexPath.row ];
	
	if(((ACTableOneLineWithImage_Checkbox_Cell *)cell).checkBox.selected==YES)
	{
		((ACTableOneLineWithImage_Checkbox_Cell *)cell).checkBox.selected=NO;
        [chosedDict removeObjectForKey:[dict objectForKey:@"id"]];
	}
	else
	{
		((ACTableOneLineWithImage_Checkbox_Cell *)cell).checkBox.selected=YES;
		[chosedDict setObject:dict forKey:[dict objectForKey:@"id"]];
	}
}

#pragma mark -
#pragma mark TextField Delegate Function Methods


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
    // [self searchUser];
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	return YES;
}

- (void) textFieldChange :(UITextField *)textField
{
	
}

#pragma mark -
#pragma mark request Delegate Function Methods

- (void)getFriendUser
{
    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    [self friendConnection:network];
}

- (void)searchUser 
{	

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
		NSLog(@"No Data");
	}
    
	NSLog(@"temp %@",temp);
    
    if([temp isKindOfClass:[NSDictionary class]])
    {
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
        {
            NSString *errorString =CONNECTION_ERROR_STRING;
            [self showErrorAlert:errorString];
            return;
        }
    }

    
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"friend"])
	{
		self.usersArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
		[table reloadData];
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

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}



@end
