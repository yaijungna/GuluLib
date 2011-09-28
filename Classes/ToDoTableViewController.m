//
//  ToDoTableViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/20.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ToDoTableViewController.h"

#import "ACTableOneLineWithImageCell.h"
#import "oneLineTableHeaderView.h"

#import "dishProfileViewController.h"
#import "RestaurantProfileViewController.h"


#import "UIImageView+WebCache.h"


@implementation ToDoTableViewController


@synthesize tableView;
@synthesize postArray;

@synthesize postArray_dish,postArray_restaurant;

@synthesize navigationController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableViewContainer=[[UIView alloc] initWithFrame:CGRectMake(0, -19, 320, 325)];
    [self.view addSubview:tableViewContainer];

    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 325)];
	//[self.view addSubview:tableView];
    [tableViewContainer addSubview:tableView];
    [self customizeTableView:tableView];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.dataSource=self;
    tableView.delegate=self;
    
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tableView.bounds.size.height, self.view.frame.size.width,tableView.bounds.size.height)];
    
	_refreshHeaderView.delegate = self;
	[tableView addSubview:_refreshHeaderView];
	[_refreshHeaderView release];
	[_refreshHeaderView refreshLastUpdatedDate];

    
    //================
	
	[self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
	
	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.tableView addSubview:LoadingView];
	LoadingView.hidden=YES;
	
    if([ACCheckConnection isConnectedToNetwork])
    {
        [self getMyTodo];
    }
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(reloadTableViewDataSource)
     name: @"refreshTodoList"
     object:nil];
	
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    oneLineTableHeaderView *view1 = [[[oneLineTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)]autorelease];
    
    if(section==0)
    {
        view1.label1.text=NSLocalizedString(@"Dishes",@"[title]");
    }
    else if(section==1)
    {
        view1.label1.text=NSLocalizedString(@"Restaurants",@"[title]");
    }
/*    else if(section==2)
    {
        view1.label1.text=NSLocalizedString(@"Mission",@"[title]");
    }
*/    
    view1.rightBtn.hidden=YES;
    [self customizeLabel:view1.label1];
    
	return view1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section==0)
    {
       return  [postArray_dish count];
    }
    else if(section==1)
    {
       return  [postArray_restaurant count];
    }
    
    return 0;

}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

	
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
				[self customizeImageView_cell:cell.leftImageview];
				//	[cell.rightBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
				//	[cell.more.mapbtn.btn addTarget:self action:@selector(mapAction:) forControlEvents:UIControlEventTouchUpInside];
				//	[cell.more.favoritebtn.btn addTarget:self action:@selector(favoriteAction:) forControlEvents:UIControlEventTouchUpInside];
			}
		}
	}
    
	NSDictionary *dishDict;
	NSDictionary *restaurantDict;
	NSString *restaurantName=nil;
	NSString *dishName=nil;
    
    if(indexPath.section==0)  //dish
    {
        dishDict=[[postArray_dish objectAtIndex:indexPath.row] objectForKey:@"object"];
		dishName=[[NSString alloc] initWithFormat:@"%@",[dishDict objectForKey:@"name"]];
		
		restaurantDict=[dishDict objectForKey:@"restaurant"];
		restaurantName=[[NSString alloc] initWithFormat:@"%@",[restaurantDict objectForKey:@"name"]];
        
        cell.label1.text=[NSString stringWithFormat:@"%@ @ %@",dishName,restaurantName];
		[dishName release];
		[restaurantName release];
        
         NSString *url_key=[[dishDict  objectForKey:@"photo"] objectForKey:@"image_small"];
        [cell.leftImageview setImageWithURL:[NSURL URLWithString:url_key]];
        

    }
    
    if(indexPath.section==1)  //restaurant
    {
        restaurantDict=[[postArray_restaurant objectAtIndex:indexPath.row] objectForKey:@"object"];
		restaurantName=[[NSString alloc] initWithFormat:@"%@",[restaurantDict objectForKey:@"name"]];
        
        cell.label1.text=[NSString stringWithFormat:@"%@",restaurantName];
		[restaurantName release];
            
        NSString *url_key=[[restaurantDict  objectForKey:@"photo"] objectForKey:@"image_small"];
        [cell.leftImageview setImageWithURL:[NSURL URLWithString:url_key]];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{	 
    
    selectedIndexPath=indexPath;
    
    ACActionSheetView *sheet=[[[ACActionSheetView alloc] initWithAboveSheet:tableViewContainer] autorelease];
    sheet.deleagte=self;
    
    UIButton *btn1=[[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 140,50 )] autorelease];
    UIButton *btn2=[[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 140,50 )] autorelease];
    UIButton *btn3=[[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 140,50 )] autorelease];
    
    [btn1 setBackgroundImage:[UIImage imageNamed:@"button-2.png"] forState:UIControlStateNormal];
    [btn1.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:18]];
    [btn1.titleLabel setTextColor:TEXT_COLOR];
    [btn1 setTitle:NSLocalizedString(@"Complete", @"") forState:UIControlStateNormal];
    
    [btn2 setBackgroundImage:[UIImage imageNamed:@"button-2.png"] forState:UIControlStateNormal];
    [btn2.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:18]];
    [btn2.titleLabel setTextColor:TEXT_COLOR];
    [btn2 setTitle:NSLocalizedString(@"Profile", @"restaurant or dish or mission profile") forState:UIControlStateNormal];
    
    [btn3 setBackgroundImage:[UIImage imageNamed:@"button-2.png"] forState:UIControlStateNormal];
    [btn3.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:18]];
    [btn3.titleLabel setTextColor:TEXT_COLOR];
    [btn3 setTitle:NSLocalizedString(@"Cancel", @"") forState:UIControlStateNormal];
    
    [sheet addButton:btn1];
    [sheet addButton:btn2];
    [sheet addButton:btn3];
    
    [sheet showFromBottom];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableview 
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	return UITableViewCellEditingStyleDelete;
	
}

- (void)tableView:(UITableView *)tableview commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (editingStyle == UITableViewCellEditingStyleDelete) 
	{
        
        if(![ACCheckConnection isConnectedToNetwork])
        {
            NSString *errorString =CONNECTION_ERROR_STRING;
            [self showErrorAlert:errorString];
            return;
        }

        
        
        if(indexPath.section==0)  //dish
        {
            [self deletetMyTodo:[[postArray_dish objectAtIndex:indexPath.row] objectForKey:@"id"]];
        }
        if(indexPath.section==1)  //restaurant
        {
            [self deletetMyTodo:[[postArray_restaurant objectAtIndex:indexPath.row] objectForKey:@"id"]];    
        }

	}     
}


- (void)viewDidUnload {
	
//	[network cancelAllRequestsInRequestsQueue];
	
    [super viewDidUnload];
	
}


- (void)dealloc {
	
    [tableViewContainer release];
    
	[network cancelAllRequestsInRequestsQueue];
	
	[network release];
	[postArray release];
    
    [postArray_dish release];
    [postArray_restaurant release];

    
    
    [LoadingView release];
    
	
	network=nil;
	postArray=nil;
	LoadingView=nil;
	
	
    [super dealloc];
}

#pragma mark -
#pragma mark AC action sheet  Methods

-(void) ACActionSheetViewTapAtIndexButton:(ACActionSheetView *)view index:(NSInteger)index
{
    [view dismissSheet];
    
    if(index==0)// complete
    {
        appDelegate.temp.postObj=[[[postModel alloc] init] autorelease];
        
        if(selectedIndexPath.section==0)  //dish
        {
            
            NSDictionary *dict=[postArray_dish objectAtIndex:selectedIndexPath.row];
            
            appDelegate.temp.postObj.dishDict=[dict objectForKey:@"object"];
            appDelegate.temp.postObj.restaurantDict=[appDelegate.temp.postObj.dishDict objectForKey:@"restaurant"];
            //  NSLog(@"%@",appDelegate.temp.postObj.restaurantDict);
            //  NSLog(@"%@",appDelegate.temp.postObj.dishDict);
            
            appDelegate.temp.postObj.todoid=[[postArray objectAtIndex:selectedIndexPath.row] objectForKey:@"id"];
            
        }
        if(selectedIndexPath.section==1)  //restaurant
        {
            
            NSDictionary *dict=[postArray_restaurant objectAtIndex:selectedIndexPath.row];
            
            appDelegate.temp.postObj.restaurantDict=[dict objectForKey:@"object"];
            //  NSLog(@"%@",appDelegate.temp.postObj.restaurantDict);
            
            appDelegate.temp.postObj.todoid=[[postArray objectAtIndex:selectedIndexPath.row] objectForKey:@"id"];   
        }
        
        [BottomMenuBarView thirdBtnAction];
    }
    
    if(index==1) //profile
    {
        
        if(selectedIndexPath.section==0)  //dish
        {
            NSDictionary *dict=[[postArray_dish objectAtIndex:selectedIndexPath.row] objectForKey:@"object"];
            
            ACLog(@"%@", dict);
            
            dishProfileViewController *VC=[[dishProfileViewController alloc] initWithNibName:@"dishProfileViewController" bundle:nil];	
     //       VC.dishDict=[NSMutableDictionary dictionaryWithDictionary:dict];
            [self.navigationController pushViewController:VC animated:YES];
            [VC release];
        }
        if(selectedIndexPath.section==1)  //restaurant
        {
            NSDictionary *dict=[[postArray_restaurant objectAtIndex:selectedIndexPath.row] objectForKey:@"object"];
            
            ACLog(@"%@", dict);
            
            RestaurantProfileViewController *VC=[[RestaurantProfileViewController alloc] initWithNibName:@"RestaurantProfileViewController" bundle:nil];	
 //           VC.restaurantDict=[NSMutableDictionary dictionaryWithDictionary:dict];
            [self.navigationController pushViewController:VC animated:YES];
            [VC release];
        }
    }
}



#pragma mark -
#pragma mark request Delegate Function Methods


- (void)getMyTodo 
{
	self.tableView.userInteractionEnabled=NO; 
//	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
	[self toDoListConnection:network];
}

- (void)deletetMyTodo:(NSString *)todo_id
{
	self.tableView.userInteractionEnabled=NO; 
//	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
	[self deleteToDoConnection:network ID:todo_id];
}


#pragma mark -

-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
	self.tableView.userInteractionEnabled=YES; 
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.1];
	
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		ACLog(@"No Data");
	}
	
	//ACLog(@"temp %@",temp);
    
    ACLog(@"request ok");
    
    if([temp  isKindOfClass:[NSDictionary class]])
    {
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
        {
        //    NSString *errorString =CONNECTION_ERROR_STRING;
         //   [self showErrorAlert:errorString];
              ACLog(@"request error %@",temp);
            return;
        }
    }

	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"todolist"])
	{
		
		self.postArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
        
        self.postArray_dish         = [[[NSMutableArray alloc] init] autorelease];
        self.postArray_restaurant   = [[[NSMutableArray alloc] init] autorelease];

 
        for(NSDictionary *Dict in  postArray )
		{
            NSNumber *type=[Dict objectForKey:@"type"];

            if([type isEqualToNumber:[NSNumber numberWithInt:0]])  // dish
            {
                [postArray_dish addObject:Dict];
            }
            else  if([type isEqualToNumber:[NSNumber numberWithInt:1]]) //restaurant
            {
                [postArray_restaurant addObject:Dict];
            }
        }



		[self.tableView reloadData];
		
		
	}
	
	else if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"deleteToDo"])
	{
		NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:temp];
		
		if([dict count]==0)
			return;
		
		if (![[dict objectForKey:@"errorMessage"] isEqual:[NSNull null]] ) 
		{
			if([[dict objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
			{
				[self showErrorAlert:[dict objectForKey:@"errorMessage"]];
				return;
			}
			else if ([[dict objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]] ) 
			{
				[self getMyTodo];
				return;
			}
		}
		
	}
	
	 
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	
    ACLog(@"request failed");
    
	[self hideSpinnerView:LoadingView];
	self.tableView.userInteractionEnabled=YES; 
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.1];	
	
//	NSString *errorString =CONNECTION_ERROR_STRING;
//	[self showErrorAlert:errorString];
}


#pragma mark -
#pragma mark ACImageDidLoad Delegate and Function Methods

- (void)ACImageDidLoad:(ACImageLoader *)imageloader
{
	if (imageloader.image != nil)
	{
		UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:imageloader.indexPath];
		((ACTableOneLineWithImageCell *)cell).leftImageview.image=imageloader.image;
	}	 
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//	[super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];  //refresh need to comment this line
	
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
       [self getMyTodo];
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
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tableView];
	
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

