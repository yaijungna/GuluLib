//
//  commentViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/27.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "commentViewController.h"
#import "ACCommentCell.h"

#import "UserHeaderView.h"


@implementation commentViewController

@synthesize targetObj;
@synthesize commentsArray;
@synthesize imageLoaderDictionary;


-(void) initViewController
{
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
	[self.view addSubview:topView];
	[topView release];
	[topView.topLeftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topRightButton addTarget:self action:@selector(landingAction) forControlEvents:UIControlEventTouchUpInside];
	
	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	LoadingView.hidden=YES;	
	
    [self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
    
    //=====================================
    
    [self customizeTableView:table];
    
	_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - table.bounds.size.height, self.view.frame.size.width,table.bounds.size.height)];
	_refreshHeaderView.delegate = self;
	[table addSubview:_refreshHeaderView];
	[_refreshHeaderView release];
	[_refreshHeaderView refreshLastUpdatedDate];
    
    //====================================
    
    chatView =[[ChatTextFieldView alloc] initWithFrame:CGRectMake(0, 405, 320, 55)];
	[self.view addSubview:chatView];
	[self customizeTextField:chatView.chatTextField];
	chatView.chatTextField.placeholder=NSLocalizedString(@"", @"comment placeholder ");
	chatView.chatTextField.delegate=self;
	

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];
    [self getcommentList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
 
}


- (void)dealloc {
    [network cancelAllRequestsInRequestsQueue];
    [self cancelImageLoaders:imageLoaderDictionary];
    
    [LoadingView release];
    [chatView release];
    [targetObj release];
    [commentsArray release];
    [imageLoaderDictionary release];
    [super dealloc];
}

#pragma mark -
#pragma mark action Function Methods

-(void)backAction
{
    [network cancelAllRequestsInRequestsQueue];
    [self cancelImageLoaders:imageLoaderDictionary];
	[self.navigationController popViewControllerAnimated:YES];    	
}

-(void)landingAction
{
    [network cancelAllRequestsInRequestsQueue];
    [self cancelImageLoaders:imageLoaderDictionary];
    [self.navigationController popToRootViewControllerAnimated:YES];	
}

-(void)textViewUp
{
    NSInteger index=[commentsArray count]-1;
    
    if(index >= 0)
    {
        [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[commentsArray count]-1 inSection:0]
                     atScrollPosition:UITableViewScrollPositionBottom 
                             animated:YES];
    }
    
   [self moveTheView:self.view movwToPosition:CGPointMake(0, -215)];
}

-(void)textViewDown
{
  	[self moveTheView:self.view movwToPosition:CGPointMake(0, 0)];
}

#pragma mark -
#pragma mark TextField Delegate Function Methods


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self textViewDown];
    [textField resignFirstResponder];
    
    if([textField.text isEqualToString:@""] || textField.text==nil)
    {
        return YES;
    }
    else
    {
        [self postComment];
        return YES;
    }
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self textViewUp];
	return YES;
}



#pragma mark -
#pragma mark table Function Methods


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	UserHeaderView *view1 = [[UserHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
	view1.backgroundColor=[UIColor blueColor];
	return [view1 autorelease];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *contentString=[[commentsArray objectAtIndex:indexPath.row] objectForKey:@"comment"];

    UIFont *font = [UIFont fontWithName:FONT_NORMAL size:12];
    
    CGSize size = [contentString sizeWithFont:font
                         constrainedToSize:CGSizeMake(300, 1000)
                             lineBreakMode:UILineBreakModeWordWrap];
    
    if (size.height<35) {
        size.height=35;
    }
    
	return (5+20+size.height+5)+5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [commentsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellIdentifier = @"ACCommentCell";
	static NSString *nibNamed = @"ACCommentCell";
	
	ACCommentCell *cell = (ACCommentCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil];
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell= (ACCommentCell*) currentObject;
				[cell initCell];
                [self customizeLabel_title:cell.labelTitle];
                [self customizeLabel:cell.labelContent];
                cell.labelContent.font=[UIFont fontWithName:FONT_NORMAL size:12];
                cell.labelContent.numberOfLines=0;
                cell.labelContent.lineBreakMode=UILineBreakModeWordWrap;
                
			}
		}
	}
    
    NSString *contentString=[[commentsArray objectAtIndex:indexPath.row] objectForKey:@"comment"];
    NSString *nameString=[[[commentsArray objectAtIndex:indexPath.row] objectForKey:@"user"] objectForKey:@"username"];
    
    cell.labelTitle.text =nameString;
    cell.labelContent.text =contentString;
    [cell sizeToFitCell];
    
    
    ACImageLoader *iconDownloader=[imageLoaderDictionary objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    if (!iconDownloader.image)
    {
        if (table.dragging == NO && table.decelerating == NO)
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
#pragma mark ACImageDidLoad Delegate and Function Methods

- (void)ACImageDidLoad:(ACImageLoader *)imageloader
{
	if (imageloader.image != nil)
	{
        UITableViewCell *cell = [table cellForRowAtIndexPath:imageloader.indexPath];
        ((ACCommentCell *)cell).leftImageview.image=imageloader.image;
	}	 
}

- (void)loadImagesForOnscreenRows :(UITableView*)tableview  imageLoadersDict:(NSMutableDictionary *)dict
{
	NSArray *visiblePaths = [tableview indexPathsForVisibleRows];
	for (NSIndexPath *indexPath in visiblePaths)
	{
		ACImageLoader *iconDownloader=[dict
									   objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
		
		if(iconDownloader.image==nil)
		{
			iconDownloader.indexPath=indexPath;
			iconDownloader.delegate=self;
			[iconDownloader startDownload];
		}
	}
}




#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo

    [self getcommentList];
	
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:table];
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [self loadImagesForOnscreenRows:table imageLoadersDict:imageLoaderDictionary];
	
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{		
    [self loadImagesForOnscreenRows:table imageLoadersDict:imageLoaderDictionary ];
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	//[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed

}


#pragma mark -
#pragma mark request Methods

-(void)getcommentList
{
    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    
    NSString *target_id=[targetObj objectForKey:@"target_id"];
    [self commentListConnection:network target_id:target_id];
}

-(void)postComment
{
    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];

    NSString *target_id=[targetObj objectForKey:@"target_id"];
    NSString *target_type=[targetObj objectForKey:@"target_type"];
    
    [self commentPostConnection:network target_id:target_id target_type:target_type text:chatView.chatTextField.text];
    chatView.chatTextField.text=@"";

}


-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:.1];
	
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		NSLog(@"No Data");
	}
	
    NSLog(@"temp %@",temp);
    
	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"commentlist"])
	{
		
		self.commentsArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
		
		self.imageLoaderDictionary=[[[NSMutableDictionary alloc] init] autorelease];
		int i=0;
		for(NSDictionary *dict in commentsArray )
		{
			NSString *url_key=[[[dict  objectForKey:@"user"] objectForKey:@"photo"] objectForKey:@"image_small"];
			ACImageLoader *iconDownloader= [[ACImageLoader alloc] init];
			iconDownloader.URLStr=url_key;
			[imageLoaderDictionary setObject:iconDownloader forKey:[NSString stringWithFormat:@"%d",i]];	
			[iconDownloader release]; 
			i++;
		}
        
		[table reloadData];
        
        NSInteger index=[commentsArray count]-1;
        
        if(index >= 0)
        {
            [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[commentsArray count]-1 inSection:0]
                         atScrollPosition:UITableViewScrollPositionBottom 
                                 animated:YES];
        }
        
	}
    
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"commentpost"])
	{
        [self getcommentList];
    }

}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	
    [self hideSpinnerView:LoadingView];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:.1];
	
	NSString *errorString =CONNECTION_ERROR_STRING;
	[self showErrorAlert:errorString];
}


@end
