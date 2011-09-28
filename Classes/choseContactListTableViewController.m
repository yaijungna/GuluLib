//
//  choseContactListTableViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/22.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "choseContactListTableViewController.h"
#import "ACTableOneLineWithImage_Checkbox_Cell.h"
#import "userFriendProfileViewController.h"

@implementation choseContactListTableViewController

@synthesize postArray;
@synthesize imageLoaderDictionary_post;
@synthesize navigationController;
@synthesize network;

- (void)viewDidLoad {
    [super viewDidLoad];
	[self customizeTableView:self.tableView];
	self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
	//	self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
	//	self.tableView.separatorColor=[UIColor grayColor];
	[self.tableView setFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 390)];
	
	[self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
	
	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.tableView addSubview:LoadingView];
	LoadingView.hidden=YES;
	
    if([ACCheckConnection isConnectedToNetwork])
    {
        [self getMyFriend];
    }
    else
    {
        NSString *string=CONNECTION_ERROR_STRING;
        [self showErrorAlert:string];
    }

}

- (void)viewDidUnload {
	
	[network cancelAllRequestsInRequestsQueue];
	[self cancelImageLoaders:imageLoaderDictionary_post];
	
    [super viewDidUnload];
	
}


- (void)dealloc {
	
	[network release];
	[postArray release];
	[imageLoaderDictionary_post release];
	[navigationController release];
	
    [LoadingView release];
    [super dealloc];
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
	
	static NSString *cellIdentifier = @"ACTableOneLineWithImage_Checkbox_Cell";
	static NSString *nibNamed = @"ACTableOneLineWithImage_Checkbox_Cell";
	
	ACTableOneLineWithImage_Checkbox_Cell *cell = (ACTableOneLineWithImage_Checkbox_Cell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
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
	
	NSString *firstname=[[postArray objectAtIndex:indexPath.row] objectForKey:@"first_name"];
	NSString *lastname=[[postArray objectAtIndex:indexPath.row] objectForKey:@"last_name"];
	
	if(firstname ==nil || [firstname isEqual:[NSNull null]])
		firstname=@"";
	
	if(lastname ==nil || [lastname isEqual:[NSNull null]])
		lastname=@"";
	
	
	cell.label1.text=[NSString stringWithFormat:@"%@ %@",firstname,lastname];
	
	
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
	
	[self shareGULUAPP];
	
	NSDictionary *dict =[postArray objectAtIndex:indexPath.row ];
	
	
	if( [appDelegate.temp.inviteObj.contactDict objectForKey:[dict objectForKey:@"id"]] !=nil)
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
	
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	
	NSDictionary *dict =[postArray objectAtIndex:indexPath.row ];
	
	
	if(((ACTableOneLineWithImage_Checkbox_Cell *)cell).checkBox.selected==YES)
	{
		((ACTableOneLineWithImage_Checkbox_Cell *)cell).checkBox.selected=NO;
		[self shareGULUAPP];
		
		[appDelegate.temp.inviteObj.contactDict removeObjectForKey:[dict objectForKey:@"id"]];
		
	}
	else
	{
		((ACTableOneLineWithImage_Checkbox_Cell *)cell).checkBox.selected=YES;
		
		[appDelegate.temp.inviteObj.contactDict setObject:dict forKey:[dict objectForKey:@"id"]];
		
	}

}


- (void)refresh {
    
    
    if([ACCheckConnection isConnectedToNetwork])
    {
        
        [self getMyFriend];

    }
    else
    {
        NSString *string=GLOBAL_ERROR_STRING;
        [self showErrorAlert:string];
         [self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.1];
    }
	
}

#pragma mark -
#pragma mark request Delegate Function Methods


- (void)getMyFriend 
{
	self.tableView.userInteractionEnabled=NO; 
	self.imageLoaderDictionary_post=[[[NSMutableDictionary alloc] init] autorelease];
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
	[self friendConnection:network];
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
    
    if([temp  isKindOfClass:[NSDictionary class]])
    {
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
        {
         //   NSString *errorString =CONNECTION_ERROR_STRING;
           // [self showErrorAlert:errorString];
            ACLog(@"request error : %@", temp);
            return;
        }
    }

	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"friend"])
	{
		
		self.postArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
		
		self.imageLoaderDictionary_post=[[[NSMutableDictionary alloc] init] autorelease];
		int i=0;
		for(NSDictionary *dict in postArray )
		{
			NSString *url_key=[dict  objectForKey:@"profile_pic"];
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
		((ACTableOneLineWithImage_Checkbox_Cell *)cell).leftImageview.image=imageloader.image;
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
