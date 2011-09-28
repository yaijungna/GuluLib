//
//  pickPlaceDishViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/30.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "pickPlaceDishViewController.h"

#import "ACTableOneLineWithImageCell.h"

#import "DesignMissionTaskProfileViewController.h"

#import "oneLineTableHeaderView.h"

@implementation pickPlaceDishViewController

@synthesize dishArray,restaurantArray;

@synthesize imageLoaderDictionary_restaurant,imageLoaderDictionary_dish;


-(void)initViewController
{

	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] 
             initTopBarView:ButtonTypeBack 
             middle:ButtonTypeGuluLogo 
             right:ButtonTypeNoneType];
	[self.view addSubview:topView];
	[topView release];
    
    [topView.topLeftButton addTarget:self 
                              action:@selector(backAction) 
                    forControlEvents:UIControlEventTouchUpInside];
    
    
    [self customizeLabel_title:titleLabel];
    [self customizeTextField:searchTextField];
    [self customizeTableView:table];
    
    titleLabel.text=@"Add a dish or place.";
    searchTextField.placeholder=NSLocalizedString(@"Specify a place or dish.",@"[design mission]" );
    
    [searchTextField setReturnKeyType:UIReturnKeySearch];

   	
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
	[self searchDish];
    [self searchRestaurant];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
}


- (void)dealloc {
    
    [network release];
    [dishArray release];
    [restaurantArray release];
    
    [imageLoaderDictionary_dish release];
    [imageLoaderDictionary_restaurant release];
    
    [LoadingView release];
    
    
    [super dealloc];
}

#pragma mark -
#pragma mark action Function Methods


- (void)backAction 
{
    [self cancelImageLoaders:imageLoaderDictionary_dish];
    [self cancelImageLoaders:imageLoaderDictionary_restaurant];
    [network cancelAllRequestsInRequestsQueue];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)landingAction 
{
    [self cancelImageLoaders:imageLoaderDictionary_dish];
    [self cancelImageLoaders:imageLoaderDictionary_restaurant];
    [network cancelAllRequestsInRequestsQueue];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Table Delegate Function Methods



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    oneLineTableHeaderView *view1 = [[[oneLineTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)]autorelease];
    
    if(section==0)
    {
        view1.label1.text=NSLocalizedString(@"Restaurants",@"[title]");
    }
    else if(section==1)
    {
        view1.label1.text=NSLocalizedString(@"Dishes",@"[title]");
    }
    
    view1.rightBtn.hidden=YES;
    [self customizeLabel:view1.label1];
    
	return view1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section==0)
    {
        return  [restaurantArray count];
    }
    else if(section==1)
    {
        return  [dishArray count];
    }
    
    return 0;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString *cellIdentifier = @"ACTableOneLineWithImageCell";
	static NSString *nibNamed = @"ACTableOneLineWithImageCell";
	
	ACTableOneLineWithImageCell *cell = (ACTableOneLineWithImageCell*) [theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	
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
			}
		}
	} 
    NSDictionary *dishDict;
    NSDictionary *restaurantDict;
    NSString *restaurantName=nil;
    NSString *dishName=nil;
    
    if(indexPath.section==0)  //restaurant
    {
        restaurantDict=[restaurantArray objectAtIndex:indexPath.row] ;
        restaurantName=[[[NSString alloc] initWithFormat:@"%@",[restaurantDict objectForKey:@"name"]] autorelease];
        
        cell.label1.text=[NSString stringWithFormat:@"%@",restaurantName];
        
        
        ACImageLoader *iconDownloader=[imageLoaderDictionary_restaurant objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
        if (!iconDownloader.image)
        {
            if (theTableView.dragging == NO && theTableView.decelerating == NO)
            {
                iconDownloader.delegate=self;
                iconDownloader.indexPath=indexPath;
                [iconDownloader startDownload];
            }
            
            cell.leftImageview.image=nil;               
        }
        else
        {
            cell.leftImageview.image=iconDownloader.image;
        }
    }
    
    if(indexPath.section==1)  //dish
    {
        dishDict=[dishArray objectAtIndex:indexPath.row] ;
        dishName=[NSString stringWithFormat:@"%@",[dishDict objectForKey:@"name"]];
        
        restaurantDict=[dishDict objectForKey:@"restaurant"];
        restaurantName=[NSString stringWithFormat:@"%@",[restaurantDict objectForKey:@"name"]];
        
        cell.label1.text=[NSString stringWithFormat:@"%@ @ %@",dishName,restaurantName];
            

        ACImageLoader *iconDownloader=[imageLoaderDictionary_dish objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
        if (!iconDownloader.image)
        {
            if (theTableView.dragging == NO && theTableView.decelerating == NO)
            {
                iconDownloader.delegate=self;
                iconDownloader.indexPath=indexPath;
                [iconDownloader startDownload];
            }
            
            cell.leftImageview.image=nil;               
        }
        else
        {
            cell.leftImageview.image=iconDownloader.image;
        }
        
    }
    
       return cell;

     
     
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [network cancelAllRequestsInRequestsQueue];

    if(indexPath.section==0)  //restaurant
    {
        NSDictionary *restaurantDict=[restaurantArray objectAtIndex:indexPath.row];
        appDelegate.temp.taskObj.restaurantDict=[NSMutableDictionary dictionaryWithDictionary:restaurantDict];
        
        
        DesignMissionTaskProfileViewController *VC=[[DesignMissionTaskProfileViewController alloc] initWithNibName:@"DesignMissionTaskProfileViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];

        
    }
    if(indexPath.section==1)  //dish
    {
        NSDictionary *dishDict=[dishArray objectAtIndex:indexPath.row];
        NSDictionary *restaurantDict=[dishDict objectForKey:@"restaurant"];
        
        appDelegate.temp.taskObj.dishDict=[NSMutableDictionary dictionaryWithDictionary:dishDict];
        appDelegate.temp.taskObj.restaurantDict=[NSMutableDictionary dictionaryWithDictionary:restaurantDict];
        
        DesignMissionTaskProfileViewController *VC=[[DesignMissionTaskProfileViewController alloc] initWithNibName:@"DesignMissionTaskProfileViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
    }

    

}


#pragma mark -
#pragma mark TextField Delegate Function Methods


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [network cancelAllRequestsInRequestsQueue];

	[textField resignFirstResponder];
    [self searchDish];
    [self searchRestaurant];
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

- (void)searchRestaurant
{
    
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }

    
    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    
	NSString *searchterm;	
	if(searchTextField.text==nil){
		searchterm=@"";}
	else {
		searchterm=searchTextField.text;}

    [self searchRestaurantConnection:network searchTerm:searchterm nearby:appDelegate.userMe.myLocation];
}


- (void)searchDish 
{	
    
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }

    
    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    
	NSString *searchterm;	
	if(searchTextField.text==nil){
		searchterm=@"";}
	else {
		searchterm=searchTextField.text;}
	
	[self searchDishConnection:network searchTerm:searchterm nearby:appDelegate.userMe.myLocation];
    
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
		ACLog(@"No Data");
	}

    if([temp  isKindOfClass:[NSDictionary class]])
    {
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
        {
            NSString *errorString =CONNECTION_ERROR_STRING;
            [self showErrorAlert:errorString];
            return;
        }
    }
    
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"dishSearch"])
	{
		self.dishArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
      
        self.imageLoaderDictionary_dish=[[[NSMutableDictionary alloc] init] autorelease];
        int i=0;
        for(NSDictionary *Dict in  dishArray )
		{
            ACImageLoader *iconDownloader= [[[ACImageLoader alloc] init] autorelease];
            
            NSString *url_key=[[Dict  objectForKey:@"photo"] objectForKey:@"image_small"];
            iconDownloader.URLStr=url_key;
            [imageLoaderDictionary_dish setObject:iconDownloader forKey:[NSString stringWithFormat:@"%d",i]];
            i++;
     
        }        
        
        
		[table reloadData];

	}
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"restaurantSearch"])
	{
		self.restaurantArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
        
         self.imageLoaderDictionary_restaurant=[[[NSMutableDictionary alloc] init] autorelease];
        int i=0;
        for(NSDictionary *Dict in  restaurantArray )
		{
            ACImageLoader *iconDownloader= [[[ACImageLoader alloc] init] autorelease];
            
            NSString *url_key=[[Dict  objectForKey:@"photo"] objectForKey:@"image_small"];
            iconDownloader.URLStr=url_key;
            [imageLoaderDictionary_restaurant setObject:iconDownloader forKey:[NSString stringWithFormat:@"%d",i]];
            i++;
            
        }        

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
#pragma mark imageloader Methods

- (void)ACImageDidLoad:(ACImageLoader *)imageloader
{
	if (imageloader.image != nil)
	{
		UITableViewCell *cell = [table cellForRowAtIndexPath:imageloader.indexPath];
		((ACTableOneLineWithImageCell *)cell).leftImageview.image=imageloader.image;
	}	 
}

- (void)loadImagesForOnscreenRows :(UITableView*)tableview  imageLoadersDict:(NSMutableDictionary *)dict
{
	NSArray *visiblePaths = [tableview indexPathsForVisibleRows];
	for (NSIndexPath *indexPath in visiblePaths)
	{
        if(indexPath.section==0)  //place
        {
            ACImageLoader *iconDownloader=[imageLoaderDictionary_restaurant objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
            
            if(iconDownloader.image==nil)
            {
                iconDownloader.indexPath=indexPath;
                iconDownloader.delegate=self;
                [iconDownloader startDownload];
            }
        }
        if(indexPath.section==1)  //dish
        {
            ACImageLoader *iconDownloader=[imageLoaderDictionary_dish objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
            
            if(iconDownloader.image==nil)
            {
                iconDownloader.indexPath=indexPath;
                iconDownloader.delegate=self;
                [iconDownloader startDownload];
            }
        }
        
	}
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{	
	[self loadImagesForOnscreenRows:table imageLoadersDict:imageLoaderDictionary_dish];
    [self loadImagesForOnscreenRows:table imageLoadersDict:imageLoaderDictionary_restaurant];
}



#pragma mark -
#pragma mark Data Source Loading / Reloading Methods
/*
- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:table];
	
}
*/

#pragma mark -
#pragma mark UIScrollViewDelegate Methods
/*
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
 
 [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
 
 }
 
 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
 
 [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
 
 }
 */

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
/*
 - (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
 
 [self reloadTableViewDataSource];
 [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
 
 }
 
 - (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
 
 return _reloading; // should return if data source model is reloading
 
 }
 
 - (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
 
 return [NSDate date]; // should return date data source was last changed
 
 }
 
 */




@end
