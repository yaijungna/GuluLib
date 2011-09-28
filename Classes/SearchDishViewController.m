//
//  SearchDishViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "SearchDishViewController.h"
#import "oneLineTableHeaderView.h"

#import "ACTableOneLineWithImageCell.h"

#import "PostAddNewRestaurantViewController.h"

#import "UIImageView+WebCache.h"

@implementation SearchDishViewController

@synthesize  network;
@synthesize table;
@synthesize postArray;
@synthesize term;
@synthesize rid;
@synthesize  searchTextField;
@synthesize  delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor clearColor];
    // [self.view setFrame:CGRectMake(0, 0, [self.view superview].frame.size.width, [self.view superview].frame.size.height)];
	
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
	
	[self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
	
	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	LoadingView.hidden=YES;
	
    
    if([ACCheckConnection isConnectedToNetwork])
    {
        [self getDishOfPlace];
    }
    else
    {
    //    NSString *errorString =CONNECTION_ERROR_STRING;
     //   [self showErrorAlert:errorString];
    }
    
	
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
    [postArray release];    
    [searchTextField release];
    [rid release];
    
    [LoadingView release];
    [super dealloc];
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
	self.term=textField.text;
    
    UITableViewCell *cell = [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    ((ACTableOneLineWithImageCell *)cell).label1.text=[NSString stringWithFormat:@"%@ : %@",NSLocalizedString(@"+Add", @""),term];
}

#pragma mark -
#pragma mark table Delegate Function Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    oneLineTableHeaderView *view1 = [[[oneLineTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)]autorelease];
    
    view1.label1.text=NSLocalizedString(@"Dishes",@"[title]");
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
    return [postArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	static NSString *cellIdentifier = @"ACTableOneLineWithImageCell";
	static NSString *nibNamed = @"ACTableOneLineWithImageCell";
	
	ACTableOneLineWithImageCell *cell = (ACTableOneLineWithImageCell*) [table dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil];
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell= (ACTableOneLineWithImageCell*) currentObject;
				[cell initCell];
				cell.switcher.hidden=YES;
				cell.leftImageview.frame=CGRectMake(cell.leftImageview.frame.origin.x,
													cell.leftImageview.frame.origin.y-5, 
													cell.leftImageview.frame.size.width+10, 
													cell.leftImageview.frame.size.height+10);
			//	[self customizeImageView_cell:cell.leftImageview];
                cell.rightImageview.hidden=YES;
			}
		}
	}
    [cell.label1 setTextColor:TEXT_COLOR ];
    if(indexPath.row==0)
    {
        [cell.label1 setTextColor:ADD_TEXT_COLOR ];
        cell.leftImageview.hidden=YES;
        
        self.term=searchTextField.text;
         
        if(term==nil)
            self.term=@"";

        cell.label1.text=[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"+Add :", @""),term];
    }
    else if(indexPath.row==1)
    {
        [cell.label1 setTextColor:ADD_TEXT_COLOR ];
        cell.leftImageview.hidden=YES;

        cell.label1.text=NSLocalizedString(@"Skip", @"");
    }
    else
    {
        NSDictionary *dishDict=[postArray objectAtIndex:indexPath.row] ;
        NSString *dishName=[dishDict objectForKey:@"name"];
        
        cell.label1.text=[NSString stringWithFormat:@"%@",dishName];
        
        NSString *url_key=[[dishDict objectForKey:@"photo"] objectForKey:@"image_medium"];
        [cell.leftImageview setImageWithURL:[NSURL URLWithString:url_key]];
        
        cell.leftImageview.hidden=NO;  
        
    }
    
    
	
	return cell;
}


- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:[postArray objectAtIndex:indexPath.row]];
    
    self.term=searchTextField.text;
    if(term==nil)
    {
        self.term=@"";
    }
    
    if(indexPath.row==0) //add
    {
        if([searchTextField.text isEqualToString:@""] || searchTextField.text==nil)
        {
            return;
        }

        [dict setObject:term forKey:@"app_newdish"];
    }
    else if(indexPath.row==1) //skip
    {
        [dict setObject:@"skip" forKey:@"app_skip"];
    }
    
     [searchTextField resignFirstResponder];
    
    [delegate selectedDishDictionary:dict];
}

#pragma mark -
#pragma mark request Delegate Function Methods

- (void)searchDish 
{
    
}

- (void)getDishOfPlace 
{
    
    if(rid==nil)
    {
        [self hideSpinnerView:LoadingView];
        self.view.userInteractionEnabled=YES; 
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.1];
        
    
		self.postArray=[[[NSMutableArray alloc] init] autorelease];
        
        NSMutableDictionary *dict1=[[[NSMutableDictionary alloc] init] autorelease];
        NSMutableDictionary *dict2=[[[NSMutableDictionary alloc] init] autorelease];
        
        [postArray insertObject:dict1 atIndex:0];
        [postArray insertObject:dict2 atIndex:0];
		
        [table reloadData];
        
        return;
    }
    
    self.postArray=nil;
    [table reloadData];
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
	if(self.term==nil)
		self.term=@"";
	
	[network cancelAllRequestsInRequestsQueue];
    [self searchNearDishbyPlace:network restaurant:rid];
    
}


#pragma mark -

-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
	self.view.userInteractionEnabled=YES; 
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.1];
	
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		NSLog(@"No Data");
	}
	
//	NSLog(@"temp %@",temp);
	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"dishofrestaurant"])
	{
        if([temp count]==0)
            temp=[[[NSMutableArray alloc] init] autorelease];
		
		self.postArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
        
        NSMutableDictionary *dict1=[[[NSMutableDictionary alloc] init] autorelease];
        NSMutableDictionary *dict2=[[[NSMutableDictionary alloc] init] autorelease];
        
        [postArray insertObject:dict1 atIndex:0];
        [postArray insertObject:dict2 atIndex:0];
		
        [table reloadData];
	}
	
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.1];
}


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
        
        [self getDishOfPlace];
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