//
//  guestListViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "guestListViewController.h"
#import "ACTableOneLineWithImageCell.h"

@implementation guestListViewController

@synthesize postArray;
@synthesize imageLoaderDictionary_post;
@synthesize eid;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
	[self.view addSubview:topView];
	[topView release];
	[topView.topLeftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	
	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	LoadingView.hidden=YES;
	
	
	network =[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
	
	[self customizeTableView:table];
    
    
    if([ACCheckConnection isConnectedToNetwork])
    {
        [self getList];
    }
    else
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
    }

}


- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
	
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
}


- (void)dealloc {
	[postArray release];
	[imageLoaderDictionary_post release];
	[eid release];
    [LoadingView release];
    [super dealloc];
}


- (void)backAction 
{
	[network cancelAllRequestsInRequestsQueue];
	[self cancelImageLoaders:imageLoaderDictionary_post];
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark tabel Delegate Function Methods

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
	
	ACTableOneLineWithImageCell *cell = (ACTableOneLineWithImageCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil];
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell= (ACTableOneLineWithImageCell*) currentObject;
				[cell initCell];
				cell.leftImageview.frame=CGRectMake(cell.leftImageview.frame.origin.x,
													cell.leftImageview.frame.origin.y-5, 
													cell.leftImageview.frame.size.width+10, 
													cell.leftImageview.frame.size.height+10);
				cell.switcher.hidden=YES;
				cell.rightImageview.hidden=YES;

				
				
			}
		}
	}
	
	NSString *display_name=[[postArray objectAtIndex:indexPath.row] objectForKey:@"display_name"];
	
	
	if(display_name ==nil || [display_name isEqual:[NSNull null]])
		display_name=@"";

	cell.label1.text=display_name;
	
	
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
    
    
}

#pragma mark -
#pragma mark request Delegate Function Methods


- (void)getList 
{
	self.imageLoaderDictionary_post=[[[NSMutableDictionary alloc] init] autorelease];
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
	[self eventGuetListConnection:network eventID:eid];
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

	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"eventGuestList"])
	{
		
		self.postArray=[[[NSMutableArray alloc] initWithArray:[temp objectForKey:@"guest_list"]] autorelease];
		
		self.imageLoaderDictionary_post=[[[NSMutableDictionary alloc] init] autorelease];
		int i=0;
		for(NSDictionary *dict in postArray )
		{
			NSString *url_key=[dict  objectForKey:@"photo_url"];
			ACImageLoader *iconDownloader= [[ACImageLoader alloc] init];
			iconDownloader.URLStr=url_key;
			[imageLoaderDictionary_post setObject:iconDownloader forKey:[NSString stringWithFormat:@"%d",i]];	
			[iconDownloader release]; 
			i++;
		}
		
		
		
		
		[table reloadData];
	}
	
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
//	NSString *errorString =CONNECTION_ERROR_STRING;
//	[self showErrorAlert:errorString];
}


#pragma mark -
#pragma mark ACImageDidLoad Delegate and Function Methods

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
	//[super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
	
    if (!decelerate)
	{
		[self loadImagesForOnscreenRows:table imageLoadersDict:imageLoaderDictionary_post];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{	
	[self loadImagesForOnscreenRows:table imageLoadersDict:imageLoaderDictionary_post ];
}




@end
