//
//  bestKnownForViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "bestKnownForViewController.h"
#import "ACTableOneLineWithImage_Checkbox_Cell.h"


@implementation bestKnownForViewController

@synthesize tableArray;
@synthesize originArray;
@synthesize delegate;

@synthesize network;
@synthesize table;
@synthesize term;
@synthesize searchTextField;
@synthesize bestkownforserial;

-(void)initViewController
{
    
    self.view.backgroundColor=[UIColor clearColor];
	
	table=[[UITableView alloc] initWithFrame:self.view.frame];
	[self.view addSubview:table];
    [self customizeTableView:table];
    table.backgroundColor=[UIColor clearColor];
	table.separatorStyle=UITableViewCellSeparatorStyleNone;
    table.dataSource=self;
    table.delegate=self;
    
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - table.bounds.size.height, self.view.frame.size.width,table.bounds.size.height)];
    
	_refreshHeaderView.delegate = self;
	[table addSubview:_refreshHeaderView];
	[_refreshHeaderView release];
	[_refreshHeaderView refreshLastUpdatedDate];
    
    //=============================
	
	searchTextField.delegate=self;
	[searchTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
	searchTextField.returnKeyType=UIReturnKeyDone;
	searchTextField.placeholder=NSLocalizedString(@"Suggest or select something!",@"best known for placeholder");
	
	[self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
	
	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	LoadingView.hidden=YES;
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initViewController];


}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
	
	[network cancelAllRequestsInRequestsQueue];
    [super viewDidUnload];
	
}


- (void)dealloc {
    
    [network cancelAllRequestsInRequestsQueue];
    
	[table release];
    [originArray release];
    [tableArray release];
    
    [searchTextField release];
    [term release];
    
    [LoadingView release];
    
    [bestkownforserial release];
    [super dealloc];
}


#pragma mark -
#pragma mark Table Delegate Function Methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	
	if([tableArray count]==0)
		return 1;
	else 
		return [tableArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellIdentifier = @"ACTableOneLineWithImage_Checkbox_Cell";
	static NSString *nibNamed = @"ACTableOneLineWithImage_Checkbox_Cell";
	
	ACTableOneLineWithImage_Checkbox_Cell *cell = (ACTableOneLineWithImage_Checkbox_Cell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil];
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell= (ACTableOneLineWithImage_Checkbox_Cell*) currentObject;
				[cell initCell];
				cell.leftImageview.hidden=YES;

				cell.checkBox.userInteractionEnabled=NO;
				cell.label1.frame=CGRectMake(40, 0, 260, 50);
				
			}
		}
	}
	
	if([tableArray count]==0)
	{
		cell.label1.text= [NSString stringWithFormat:@"+%@ %@", NSLocalizedString(@"Add",@"[post] add a new place"),searchTextField.text];
		[cell.label1 setTextColor:ADD_TEXT_COLOR ];
	}
	else
	{
		cell.label1.text=[tableArray objectAtIndex:indexPath.row];
		[cell.label1 setTextColor:TEXT_COLOR ];
	}

	
	
	return cell;
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	[self shareGULUAPP];
	
	if([tableArray count]==0)
	{
		appDelegate.temp.postObj.bestKnownFor=searchTextField.text;
	}
	else
	{
		appDelegate.temp.postObj.bestKnownFor=[tableArray objectAtIndex:indexPath.row];
	}
	[searchTextField resignFirstResponder];
	[self moveTheView:self.view movwToPosition:CGPointMake(0, 460)];

	[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeBestKnownFor" object:nil];
	

}


#pragma mark -
#pragma mark TextField Delegate Function Methods


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	return YES;
}

- (void) textFieldChange :(UITextField *)textField
{
	self.term=[NSString stringWithFormat:@"%@",textField.text];
	
	if([term isEqualToString:@""])
	{
		self.tableArray=originArray;
	}
	else
	{
		self.tableArray=[ACUtility doSearchArray:originArray searchTerm:term];
	}
	
	[table reloadData];
}

#pragma mark -
#pragma mark request Delegate Function Methods

- (void)getBestKnownForList :(NSString *)serial
{	
    
    if([ACCheckConnection isConnectedToNetwork])
    {
        [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
        [self bestKnownForConnection:network serial:serial];
    }
    else
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
    }
    
}


-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{
	[self hideSpinnerView:LoadingView];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.1];
	
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		NSLog(@"No Data");
        return;
	}
	
	NSLog(@"temp %@",temp);
	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"bestknownfor"])
	{
		self.originArray=[NSMutableArray arrayWithArray:[temp objectForKey:@"tags"]];
		self.tableArray=originArray;
		[table reloadData];
		
	}
}
-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{
	[self hideSpinnerView:LoadingView];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.1];
}

#pragma mark -
#pragma mark scroll view delegate Methods


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{	
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods


- (void)reloadTableViewDataSource{
    
    if([ACCheckConnection isConnectedToNetwork])
    {
        _reloading= YES;
        
        [self getBestKnownForList:bestkownforserial];
    }
    else
    {
        
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.1];
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
    }
    
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:table];
	
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	//[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
    [self reloadTableViewDataSource];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
    
}



@end
