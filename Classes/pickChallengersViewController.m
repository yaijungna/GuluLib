//
//  pickChallengersViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/30.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "pickChallengersViewController.h"

#import "ACTableOneLineWithImage_Checkbox_Cell.h"

#import "DesignMissionTaskProfileViewController.h"

#import "pickPlaceDishViewController.h"

#import "pickSpectatorViewController.h"

#import "MissionSummaryViewController.h"


@implementation pickChallengersViewController

@synthesize usersArray;


-(void)initViewController
{
    
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] 
             initTopBarView:ButtonTypeBack 
             middle:ButtonTypeGuluLogo 
             right:ButtonTypeNext];
	[self.view addSubview:topView];
	[topView release];
    
    [topView.topLeftButton addTarget:self 
                              action:@selector(backAction) 
                    forControlEvents:UIControlEventTouchUpInside];
    
    [topView.topRightButton addTarget:self 
                              action:@selector(nextAction) 
                    forControlEvents:UIControlEventTouchUpInside];
    
    
    [self customizeLabel_title:titleLabel];
    [self customizeTextField:searchTextField];
    [self customizeTableView:table];
    
    titleLabel.text=@"Pick Challengers!.";
    searchTextField.placeholder=NSLocalizedString(@"Pick friends to recruit to the dare.",@"[design mission]" );
    
    [searchTextField setReturnKeyType:UIReturnKeySearch];
    
	[self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
	
    LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	LoadingView.hidden=YES;
    
    missionObj= appDelegate.temp.missionObj;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initViewController];
	[self searchUser];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
}


- (void)dealloc {
    
    [network release];
    [usersArray release];
    
    [LoadingView release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark action Function Methods


- (void)backAction 
{
    NSArray *subviewsArray=[self.navigationController viewControllers];    
    
    for(id viewController in  subviewsArray)
    {
        if([viewController isKindOfClass:[MissionSummaryViewController class]])
        {
            
            if(![self checkFieldIsCorrect])
                return;
        }
    }

    [network cancelAllRequestsInRequestsQueue];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addChallengersNotification" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)landingAction 
{
    [network cancelAllRequestsInRequestsQueue];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)nextAction 
{
    
    if(![self checkFieldIsCorrect])
        return;
    
    
    NSArray *subviewsArray=[self.navigationController viewControllers];    
    
    for(id viewController in  subviewsArray)
    {
        if([viewController isKindOfClass:[MissionSummaryViewController class]])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"addChallengersNotification" object:nil];
            [self.navigationController popToViewController:viewController animated:YES]; 
            return;
        }
    }

    
    
    if(missionObj.missionType==DareMissiontype)
    {
        pickSpectatorViewController *VC=[[pickSpectatorViewController alloc] 
                                         initWithNibName:@"pickSpectatorViewController" 
                                         bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
        
    }
    else
    {
        
        pickPlaceDishViewController *VC=[[pickPlaceDishViewController alloc] 
                                         initWithNibName:@"pickPlaceDishViewController" 
                                         bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
    }
    
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
                
                cell.leftImageview.hidden=YES;
                
                [cell.label1 setFrame:CGRectMake(40, 0, cell.frame.size.width-50, cell.frame.size.height)];
				
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
    
    if( [missionObj.spectatorDict objectForKey:[dict objectForKey:@"id"]] !=nil)
	{
		cell.userInteractionEnabled=NO;
        cell.label1.textColor=[UIColor lightGrayColor];
	}
	else
	{
		cell.userInteractionEnabled=YES;
        cell.label1.textColor=TEXT_COLOR;
	}
	
	if( [missionObj.challengersDict objectForKey:[dict objectForKey:@"id"]] !=nil)
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
		[self shareGULUAPP];
		
		[missionObj.challengersDict removeObjectForKey:[dict objectForKey:@"id"]];
		
	}
	else
	{
		((ACTableOneLineWithImage_Checkbox_Cell *)cell).checkBox.selected=YES;
		[missionObj.challengersDict setObject:dict forKey:[dict objectForKey:@"id"]];
		
	}
      
}
#pragma mark -
#pragma mark check Function Methods

-(BOOL)checkFieldIsCorrect
{
   
    if([[missionObj.challengersDict allValues] count]==0)
    {
        [self showWarningAlert:NSLocalizedString(@"Please select at least one challenger.", @"error message")];  
        return NO;
    }
    
	return YES;
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


- (void)searchUser 
{	
    
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }
    
    
    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    
    /*
	NSString *searchterm;	
	if(searchTextField.text==nil)
    {
		searchterm=@"";
    }
	else 
    {
		searchterm=searchTextField.text;
    }
    */
    [self friendConnection:network];
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
    
   // ACLog(@"temp %@",temp);
    
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"friend"])
	{
		self.usersArray=[NSMutableArray arrayWithArray:temp] ;
        
        for(int i=0; i<[usersArray count];i++)
        {
            NSDictionary *dict=[usersArray objectAtIndex:i];
            ACLog(@"%@",dict);
            
           if([dict objectForKey:@"gulu_user_id"]==nil || [[dict objectForKey:@"gulu_user_id"] isEqual:[NSNull null]])
                [usersArray removeObjectAtIndex:i];
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

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
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
