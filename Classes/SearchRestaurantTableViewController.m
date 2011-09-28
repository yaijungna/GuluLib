//
//  SearchRestaurantTableViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/22.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "SearchRestaurantTableViewController.h"
#import "ACTableTwoLinesWithImageCell.h"
#import "oneLineTableHeaderView.h"

@implementation SearchRestaurantTableViewController

@synthesize postArray;
@synthesize imageLoaderDictionary_post;
@synthesize navigationController;
@synthesize network;
@synthesize term;

- (void)viewDidLoad {
    [super viewDidLoad];
	[self customizeTableView:self.tableView];
	self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
	//self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
	self.tableView.separatorColor=[UIColor grayColor];
	[self.tableView setFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 340)];
	
	[self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
	
	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.tableView addSubview:LoadingView];
	[LoadingView release];
	LoadingView.hidden=YES;
	
	[self searchRestaurant];
}

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
		
				[self customizeImageView_cell:cell.leftImageview];
                cell.rightViewImage.hidden=YES;
			}
		}
	}
	
	NSDictionary *restaurantDict=[postArray objectAtIndex:indexPath.row] ;
	NSString *restaurantName=[restaurantDict objectForKey:@"name"];
		
	cell.label1.text=restaurantName;
	
	CLLocation *Location = [[[CLLocation alloc] initWithLatitude:[[restaurantDict objectForKey:@"latitude"] floatValue] 
													  longitude:[[restaurantDict objectForKey:@"longitude"] floatValue]] autorelease]; 
	
	float d=[self calculateDistanceFromUserToPlace:Location];
	
	cell.label1.text=restaurantName;
	cell.label2.text=[NSString stringWithFormat: @"%.2f km",d];
	
	ACImageLoader *iconDownloader=[imageLoaderDictionary_post objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
	if (!iconDownloader.image)
	{
		if (tableView.dragging == NO && tableView.decelerating == NO)
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
	
	return cell;
}


- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
/*	[self shareGULUAPP];
	
	NSDictionary *dict=[postArray objectAtIndex:indexPath.row];
	
	appDelegate.temp.inviteObj.restaurantDict=[[[NSMutableDictionary alloc] initWithDictionary:dict] autorelease];
	
	[network cancelAllRequestsInRequestsQueue];
	[self cancelImageLoaders:imageLoaderDictionary_post];
	
	[navigationController popViewControllerAnimated:YES];
		
	[[NSNotificationCenter defaultCenter] postNotificationName:@"SelectRestaurant" object:nil];
 */
}


- (void)refresh {
	[self searchRestaurant];
	
}

- (void)viewDidUnload {
	
	[network cancelAllRequestsInRequestsQueue];
	[self cancelImageLoaders:imageLoaderDictionary_post];
	
    [super viewDidUnload];
	
}

- (void)dealloc {
    
    [network cancelAllRequestsInRequestsQueue];
	[self cancelImageLoaders:imageLoaderDictionary_post];
	
	[network release];
	[postArray release];
	[imageLoaderDictionary_post release];
	[navigationController release];
	[term release];
	
    [super dealloc];
}


#pragma mark -
#pragma mark request Delegate Function Methods

- (void)searchRestaurant 
{
	self.tableView.userInteractionEnabled=NO; 
	self.imageLoaderDictionary_post=[[[NSMutableDictionary alloc] init] autorelease];
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
	[self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.1];
	
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		NSLog(@"No Data");
	}
	
	NSLog(@"temp %@",temp);
	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"restaurantSearch"])
	{
		
		self.postArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
		
		self.imageLoaderDictionary_post=[[[NSMutableDictionary alloc] init] autorelease];
		int i=0;
		for(NSDictionary *dict in postArray )
		{
			NSString *url_key=[[dict  objectForKey:@"photo"] objectForKey:@"image_medium"];
			ACImageLoader *iconDownloader= [[ACImageLoader alloc] init];
			iconDownloader.URLStr=url_key;
			[imageLoaderDictionary_post setObject:iconDownloader forKey:[NSString stringWithFormat:@"%d",i]];	
			[iconDownloader release]; 
			i++;
		}
		
		[self.tableView reloadData];
		
		
	}
	
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
	self.tableView.userInteractionEnabled=YES; 
	[self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.1];
	
	
	NSString *errorString =CONNECTION_ERROR_STRING;
	[self showErrorAlert:errorString];
}


#pragma mark -
#pragma mark ACImageDidLoad Delegate and Function Methods

- (void)ACImageDidLoad:(ACImageLoader *)imageloader
{
	if (imageloader.image != nil)
	{
		UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:imageloader.indexPath];
		((ACTableTwoLinesWithImageCell *)cell).leftImageview.image=imageloader.image;
	}	 
}

- (void)loadImagesForOnscreenRows :(UITableView*)tableview  imageLoadersDict:(NSMutableDictionary *)dict
{
	NSArray *visiblePaths = [tableview indexPathsForVisibleRows];
	for (NSIndexPath *indexPath in visiblePaths)
	{
		ACImageLoader *iconDownloader=[dict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
		
		if(iconDownloader.image==nil)
		{
			iconDownloader.indexPath=indexPath;
			iconDownloader.delegate=self;
			[iconDownloader startDownload];
		}
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
	
    if (!decelerate)
	{
		[self loadImagesForOnscreenRows:self.tableView imageLoadersDict:imageLoaderDictionary_post];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{	
	[self loadImagesForOnscreenRows:self.tableView imageLoadersDict:imageLoaderDictionary_post ];
}



@end