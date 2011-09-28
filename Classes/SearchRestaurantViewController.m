//
//  SearchRestaurantViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/22.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "SearchRestaurantViewController.h"
#import "oneLineTableHeaderView.h"
#import "ACTableTwoLinesWithImageCell.h"

#import "ACTableOneLineCell.h"

#import "PostAddNewRestaurantViewController.h"

#import "UIImageView+WebCache.h"

@implementation SearchRestaurantViewController

@synthesize  network;
@synthesize table;
@synthesize postArray;
@synthesize term;
@synthesize  searchTextField;
@synthesize  delegate;
@synthesize allowAddNewPlace;

@synthesize navigationController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [self.view setFrame:CGRectMake(0, 0, [self.view superview].frame.size.width, [self.view superview].frame.size.height)];
	
	table=[[UITableView alloc] initWithFrame:self.view.frame];
	[self.view addSubview:table];
    [self customizeTableView:table];
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
        [self searchRestaurant];
    }
    else
    {
      //  NSString *errorString =CONNECTION_ERROR_STRING;
     //   [self showErrorAlert:errorString];
    }
    
    [[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(callBackChangePostRestaurantDictionary:)
	 name: @"ChangePostRestaurantDictionary"
	 object:nil];
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
    
    [LoadingView release];
    
    
    [super dealloc];
}

-(void) callBackChangePostRestaurantDictionary:(NSNotification *)noti
{
  //  ACLog(@"%@", noti);
    
    NSMutableDictionary *dict=[noti object];
    
    ACLog(@"%@,%@", delegate,dict);
    
    @try {
       [ delegate selectedDictionary:dict];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
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
	[self searchRestaurant];
    
    
    UITableViewCell *cell = [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    ((ACTableTwoLinesWithImageCell *)cell).label2.text=term;
}

#pragma mark -
#pragma mark table Delegate Function Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    oneLineTableHeaderView *view1 = [[[oneLineTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)]autorelease];
    
    view1.label1.text=NSLocalizedString(@"Nearby Restaurants",@"[title]");
    view1.rightBtn.hidden=YES;
    [self customizeLabel:view1.label1];
    
	return view1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [postArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	

	static NSString *cellIdentifier = @"ACTableTwoLinesWithImageCell";
	static NSString *nibNamed = @"ACTableTwoLinesWithImageCell";
	
	ACTableTwoLinesWithImageCell *cell = (ACTableTwoLinesWithImageCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil];
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell= (ACTableTwoLinesWithImageCell*) currentObject;
				[cell initCell];
                
			//	[self customizeImageView_cell:cell.leftImageview];
                cell.rightViewImage.hidden=YES;
			}
		}
	}
    [cell.label1 setTextColor:TEXT_COLOR ];
    [cell.label2 setTextColor:TEXT_COLOR ];
    cell.leftImageview.hidden=NO;
    
    
    if(indexPath.row==0 && allowAddNewPlace)
    {
        [cell.label1 setTextColor:ADD_TEXT_COLOR ];
        [cell.label2 setTextColor:ADD_TEXT_COLOR ];

        cell.leftImageview.hidden=YES;
        
        cell.label1.text=NSLocalizedString(@"+Add new place :", @"");
        
        self.term=searchTextField.text;
        
        if(term==nil)
            self.term=@"";
        cell.label2.text=term;
        
    }
    else
    {
        NSDictionary *restaurantDict=[postArray objectAtIndex:indexPath.row] ;
        NSString *restaurantName=[restaurantDict objectForKey:@"name"];
        
        cell.label1.text=restaurantName;
        
        CLLocation *Location = [[[CLLocation alloc] initWithLatitude:[[restaurantDict objectForKey:@"latitude"] floatValue] 
                                                           longitude:[[restaurantDict objectForKey:@"longitude"] floatValue]] autorelease]; 
        
        float d=[self calculateDistanceFromUserToPlace:Location];
        
        cell.label1.text=restaurantName;
        cell.label2.text=[NSString stringWithFormat: @"%.2f km",d];
        
        NSString *url_key=[[restaurantDict  objectForKey:@"photo"] objectForKey:@"image_medium"];
        [cell.leftImageview setImageWithURL:[NSURL URLWithString:url_key]];
	}
        
	return cell;
}


- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0 && allowAddNewPlace)
    {
        
      //  return;
        
        if([searchTextField.text isEqualToString:@""] || searchTextField.text==nil)
        {
            return;
        }
        
        PostAddNewRestaurantViewController *VC=[[PostAddNewRestaurantViewController alloc] initWithNibName:@"PostAddNewRestaurantViewController" bundle:nil];
        
        self.term=searchTextField.text;
        
        if(term==nil)
            self.term=@"";
        
        [searchTextField resignFirstResponder];
        
        VC.name=term;
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
    }
    else
    {
        
        NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:[postArray objectAtIndex:indexPath.row]];
        [delegate selectedDictionary:dict];
    }
}

#pragma mark -
#pragma mark request Delegate Function Methods

- (void)searchRestaurant 
{
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
	if(self.term==nil)
		self.term=@"";
	
	[network cancelAllRequestsInRequestsQueue];
	[self searchRestaurantConnection:network searchTerm:term nearby:appDelegate.userMe.myLocation];
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
	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"restaurantSearch"])
	{
		
        if([temp count]==0)
            temp=[[[NSMutableArray alloc] init] autorelease];
        
		self.postArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
        
        if(allowAddNewPlace)
        {
            NSMutableDictionary *dict1=[[[NSMutableDictionary alloc] init] autorelease];
            
            [postArray insertObject:dict1 atIndex:0];
        }

		[table reloadData];
	}
	
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.1];
	
	
//	NSString *errorString =CONNECTION_ERROR_STRING;
//	[self showErrorAlert:errorString];
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
#pragma mark UIScrollViewDelegate Methods
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
    
    if(table_mine.hidden==NO)
    {
        [_refreshHeaderView_mine egoRefreshScrollViewDidScroll:scrollView];
    }
    
    if(table_grade.hidden==NO)
    {
        [_refreshHeaderView_grade egoRefreshScrollViewDidScroll:scrollView];
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
    if(table_mine.hidden==NO)
    {
        [_refreshHeaderView_mine egoRefreshScrollViewDidEndDragging:scrollView];
        [self loadImagesForOnscreenRows:table_mine imageLoadersDict:imageLoaderDictionary_mine];
    }
    if(table_grade.hidden==NO)
    {
        [_refreshHeaderView_grade egoRefreshScrollViewDidEndDragging:scrollView];
        [self loadImagesForOnscreenRows:table_grade imageLoadersDict:imageLoaderDictionary_grade];
    }
    
}
*/



#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods


- (void)reloadTableViewDataSource{
    
    if([ACCheckConnection isConnectedToNetwork])
    {
        _reloading= YES;
        
        [self searchRestaurant];
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
