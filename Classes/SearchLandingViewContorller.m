//
//  SearchLandingViewContorller.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/7.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "SearchLandingViewContorller.h"

@implementation SearchLandingViewContorller

@synthesize restaurantArray,dishArray,missionArray;
@synthesize placeSearchRequest,dishSearchRequest,missionSearchRequest,todoRequest,favoriteRequest;

-(void)initViewController
{
    
	NSArray  *array=[NSArray arrayWithObjects:SEARCH_RESTAURANT_STRING,SEARCH_DISH_STRING,SEARCH_MISSIONS_STRING,nil];
	
	segment=[[ACSegmentController alloc] initWithFrame:CGRectMake(0, 40, 320, 40)];
	[segment initCustomSegment:array normalimage:[UIImage imageNamed:@"seg03-2.png"] selectedimage:[UIImage imageNamed:@"seg03-1.png"]  textfont:[UIFont fontWithName:FONT_BOLD size:12]];
	[segment setSelectedButtonAtIndex:0];
	segment.delegate=self;
	[self.view addSubview:segment];

	
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeNoneType middle:ButtonTypeGuluLogo right:ButtonTypeImHungry];
	[self.view addSubview:topView];
    
    [topView.topRightButton addTarget:self action:@selector(iamhungry) forControlEvents:UIControlEventTouchUpInside];

	
	bottomView=[[[BottomMenuBarView alloc] initWithFrame:CGRectMake(0, 410, 320, 50)] initBottomBarView:ButtonTypeMyGulu second:ButtonTypeChat third:ButtonTypePost forth:ButtonTypeMissions fifth:ButtonTypeSearch];
    [bottomView setUpMainBtnAction];
	[self.view addSubview:bottomView];
	
	[bottomView setUpMainBtnSelected:4];
	
	searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 90, 260, 30)];
	searchTextField.delegate=self;
	searchTextField.placeholder=SEARCH_BAR_RESTAURANT_STRING;
	searchTextField.returnKeyType=UIReturnKeyDone;
	[searchTextField customizeTextFieldToGuluStyle];
	[self.view addSubview:searchTextField];
	[searchTextField release];
	[searchTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
	
	
	searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(280, 90, 30, 30)];
	[searchBtn setBackgroundImage:[UIImage imageNamed:@"search-pin-button-1.png"] forState:UIControlStateNormal];
	[self.view addSubview:searchBtn];
	[searchBtn release];
	[searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
	
    placeTable=[[searchPlaceTableView alloc] initWithFrame:CGRectMake(0, 130, 320, 280) pullToRefresh:YES];
    dishTable=[[searchDishTableView alloc] initWithFrame:CGRectMake(0, 130, 320, 280) pullToRefresh:YES];
    missionTable=[[searchMissionTable alloc] initWithFrame:CGRectMake(0, 130, 320, 280) pullToRefresh:YES];
    
    [self.view addSubview:placeTable];
    [self.view addSubview:dishTable];
    [self.view addSubview:missionTable];
    
    placeTable.refreshDelegate=self;
    dishTable.refreshDelegate=self;
    missionTable.refreshDelegate=self;   
    
    placeTable.navigationController=self.navigationController;
    dishTable.navigationController=self.navigationController;
    missionTable.navigationController=self.navigationController;
    
    placeTable.moreDelegateVC=self;
//    dishTable.navigationController=self.navigationController;
//    missionTable.navigationController=self.navigationController;
    
    [placeTable release];
    [dishTable release];
    [missionTable release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initViewController];
    [self search];
    [self touchSegmentAtIndex:RestaurantTableType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
        
	[segment release];
    [topView release];
    [bottomView release];
    
	[restaurantArray release];
	[dishArray release];
	[missionArray release];
    
    [placeSearchRequest release];
    [dishSearchRequest release];
    [missionSearchRequest release];
	[todoRequest release];
    [favoriteRequest release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark action Function Methods

- (void)moreAction :(id)more  actionType: (GuluMoreType ) actionType 
{


}

- (void)search
{	
    [loadingSpinner startAnimating];
	[self searchPlace];
    [self searchDish];
    [self searchMission];	
}
/*
- (void)mapAction :(UIButton *)btn
{
	NSInteger index=btn.tag;
	
	if(table.tag==RestaurantTableType) //restaurant
	{
        GuluPlaceModel *place=[tableArray objectAtIndex:2];
        
		[self gotoMap:place] ;	
      
        
        
    
	}
	else if(table.tag==DishTableType) //dish
	{
        GuluDishModel *dish=[tableArray objectAtIndex:index];
		[self gotoMap:dish.restaurant];
	}
}

- (void)favoriteAction :(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)[[btn superview] superview] ;
    NSIndexPath *indexPath = [table indexPathForCell:cell];
	NSInteger index=indexPath.row;
	table.allowsSelection=NO;	
    
	if(table.tag==RestaurantTableType) //restaurant
	{
		[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
		segment.userInteractionEnabled=NO;
		
        GuluPlaceModel *place=[tableArray objectAtIndex:index];
		[[GuluAPIAccessManager sharedManager] favoriteSomething:self target_id:place.ID target_type:GuluTargetType_place];
		
	}
	else if(table.tag==DishTableType) //dish
	{
		[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
		segment.userInteractionEnabled=NO;
        GuluDishModel *dish=[tableArray objectAtIndex:index];
		[[GuluAPIAccessManager sharedManager] favoriteSomething:self target_id:dish.ID target_type:GuluTargetType_dish];
	}
}

- (void)todoAction :(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)[[btn superview] superview] ;
    NSIndexPath *indexPath = [table indexPathForCell:cell];
	NSInteger index=indexPath.row;
	table.allowsSelection=NO;	
	
	if(table.tag==RestaurantTableType) //restaurant
	{
		[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
		segment.userInteractionEnabled=NO;
        
        GuluPlaceModel *place=[tableArray objectAtIndex:index];
        [[GuluAPIAccessManager sharedManager] addPlaceToToDoList:self place_id:place.ID];
		
	}
	else if(table.tag==DishTableType) //dish
	{
		[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
		segment.userInteractionEnabled=NO;
        
        GuluDishModel *dish=[tableArray objectAtIndex:index];
        [[GuluAPIAccessManager sharedManager] addDishToToDoList:self dish_id:dish.ID];
	}
}

- (void)inviteAction :(UIButton *)btn
{	
	EventViewController *VC=[[EventViewController alloc] initWithNibName:@"EventViewController" bundle:nil];
	
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];
 
}
*/
#pragma mark -
#pragma mark Table Delegate Function Methods
/*
- (UITableViewCell *)tableView:(UITableView *)theTableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSString *cellClassStr = @"GuluTableViewCell_Image_Twoline";
    
    GuluTableViewCell_Image_Twoline *cell = [GuluTableViewCell cellForIdentifierOfTable:cellClassStr table:theTableView];
    cell.tag=indexPath.row;
    
    if(!cell.isReusedCell)
    {
        [cell.label1 customizeLabelToGuluStyle];
        [cell.label2 customizeLabelToGuluStyle];
        
        moreView *more=[[[moreView alloc] initWithFrame:CGRectMake(320, 0, 320, 60)] autorelease];
        cell.viewForMore=more;
        [cell.contentView addSubview:more];
        [more.mapbtn.btn addTarget:self action:@selector(mapAction:) forControlEvents:UIControlEventTouchUpInside];
        [more.favoritebtn.btn addTarget:self action:@selector(favoriteAction:) forControlEvents:UIControlEventTouchUpInside];
        [more.todobtn.btn addTarget:self action:@selector(todoAction:) forControlEvents:UIControlEventTouchUpInside];
        [more.invitebtn.btn addTarget:self action:@selector(inviteAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0, 0.0, 25, 25);
        [button setBackgroundImage:[UIImage imageNamed:@"more-icon-1.png"] forState:UIControlStateNormal];        
        [button addTarget:self action:@selector(checkButtonTapped:event:)  forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = button;

    }    
    

   
	if(table.tag==RestaurantTableType) //restaurant
	{
        GuluPlaceModel *place=[tableArray objectAtIndex:indexPath.row];
	
		CLLocation *Location = [[[CLLocation alloc] initWithLatitude:place.latitude longitude:place.longitude] autorelease]; 
		float d=[self calculateDistanceFromUserToPlace:Location];
		
		cell.label1.text=place.name;
		cell.label2.text=[NSString stringWithFormat: @"%.2f km",d];
		
        NSString *url_key=place.photo.image_small;
        [cell.leftImageview setImageWithURL:[NSURL URLWithString:url_key]];
        
	}
	else if(table.tag==DishTableType) //dish
	{ 
        
        GuluDishModel *dish=[tableArray objectAtIndex:indexPath.row];
		
		CLLocation *Location = [[[CLLocation alloc] initWithLatitude:dish.restaurant.latitude 
														  longitude:dish.restaurant.longitude] autorelease]; 
		float d=[self calculateDistanceFromUserToPlace:Location];
		
		cell.label1.text=[NSString stringWithFormat:@"%@ @ %@",dish.name,dish.restaurant.name];
		cell.label2.text=[NSString stringWithFormat: @"%.2f km",d];
		
        NSString *url_key=dish.photo.image_small;
        [cell.leftImageview setImageWithURL:[NSURL URLWithString:url_key]];
	}
	else if(table.tag==MissionType) //mission
	{
        GuluMissionModel *mission=[tableArray objectAtIndex:indexPath.row];    
        
		cell.label1.text=mission.title;
		cell.label2.text=[NSString stringWithFormat: @"%@ %@",NSLocalizedString(@"by", @"by whom create this mission"),mission.created_user.username];
		
        NSString *url_key=mission.badge_pic.image_small;
        [cell.leftImageview setImageWithURL:[NSURL URLWithString:url_key]];		
	}

	return cell;
}
- (void)checkButtonTapped:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:table];
    NSIndexPath *indexPath = [table indexPathForRowAtPoint: currentTouchPosition];
    if (indexPath != nil)
    {
        [self tableView: table accessoryButtonTappedForRowWithIndexPath: indexPath];
    }
}


*/
#pragma mark -
#pragma mark TextField Delegate Function Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	return YES;
}
- (void) textFieldChange :(UITextField *)textField
{
	[self search];
}

#pragma mark -
#pragma mark segment Delegate Function Methods

- (void) touchSegmentAtIndex:(NSInteger)segmentIndex
{    
    placeTable.hidden=YES;
    dishTable.hidden=YES;
    missionTable.hidden=YES;
    
    
	if(segmentIndex==0) //restaurant
	{
		searchTextField.placeholder=SEARCH_BAR_RESTAURANT_STRING;
        placeTable.hidden=NO;

	}
	else if(segmentIndex==1) //dish
	{ 
		searchTextField.placeholder=SEARCH_BAR_DISH_STRING;
        dishTable.hidden=NO;

	}
	else if(segmentIndex==2) //mission
	{
		searchTextField.placeholder=SEARCH_BAR_MISSION_STRING;
        missionTable.hidden=NO;
	}
    
    /*
    if(indexPathRowForMore>=0)
	{
		NSIndexPath *indexPath=[NSIndexPath indexPathForRow:indexPathRowForMore inSection:0]	;
        UITableViewCell *cell = [table cellForRowAtIndexPath:indexPath];
        GuluTableViewCell_Image_Twoline *guluCell= (GuluTableViewCell_Image_Twoline *)cell;
        [GuluUtility moveTheView:guluCell.viewForMore moveToPosition:CGPointMake(320,0)];
        guluCell.accessoryView.hidden=NO;
		indexPathRowForMore=-1;
	}
     */
}


#pragma mark -
#pragma mark request Delegate Function Methods


- (void)searchPlace 
{	
	NSString *searchterm;	
	if(searchTextField.text==nil){
		searchterm=@"";}
	else {
		searchterm=searchTextField.text;}
	
	[placeSearchRequest cancel];
	self.placeSearchRequest=[[GuluAPIAccessManager sharedManager] searchPlace:self 
                                                                   searchTerm:searchterm 
                                                                          lat:appDelegate.myLoaction.coordinate.latitude 
                                                                          lng:appDelegate.myLoaction.coordinate.longitude];
}

- (void)searchDish 
{	   
	NSString *searchterm;	
	if(searchTextField.text==nil){
		searchterm=@"";}
	else {
		searchterm=searchTextField.text;}
	
    [dishSearchRequest cancel];
	self.dishSearchRequest=[[GuluAPIAccessManager sharedManager] searchDish:self 
                                                                 searchTerm:searchterm 
                                                                        lat:appDelegate.myLoaction.coordinate.latitude 
                                                                        lng:appDelegate.myLoaction.coordinate.longitude];
}

- (void)searchMission
{	
 	NSString *searchterm;	
	if(searchTextField.text==nil){
		searchterm=@"";}
	else {
		searchterm=searchTextField.text;}
	
    [missionSearchRequest cancel];
    self.missionSearchRequest=[[GuluAPIAccessManager sharedManager] searchMission:self searchTerm:searchterm];    
}


- (void)GuluAPIAccessManagerSuccessed:(GuluHttpRequest*)httpRequest info:(id)info
{
    [loadingSpinner stopAnimating];
    
    if([info isKindOfClass:[GuluErrorMessageModel class]]){
        return;
    }

    if(httpRequest == placeSearchRequest)
    {
        self.restaurantArray=[[[NSMutableArray alloc] initWithArray:info] autorelease];
        [placeTable performSelector:@selector(doneLoadingGuluRefreshTableViewData) withObject:nil afterDelay:0.1];
        placeTable.tableArray=restaurantArray;
        [placeTable reloadData];
    }
    
    if(httpRequest == dishSearchRequest)
    {
        self.dishArray=[[[NSMutableArray alloc] initWithArray:info] autorelease];
        [dishTable performSelector:@selector(doneLoadingGuluRefreshTableViewData) withObject:nil afterDelay:0.1];
        dishTable.tableArray=dishArray;
        [dishTable reloadData];
    }
    
    if(httpRequest == missionSearchRequest)
    {
        self.missionArray=[[[NSMutableArray alloc] initWithArray:info] autorelease];
        [missionTable performSelector:@selector(doneLoadingGuluRefreshTableViewData) withObject:nil afterDelay:0.1];
        missionTable.tableArray=missionArray;
        [missionTable reloadData];
    }

}

- (void)GuluAPIAccessManagerFailed:(GuluHttpRequest*)httpRequest info:(id)info
{
    [loadingSpinner stopAnimating];
    [placeTable performSelector:@selector(doneLoadingGuluRefreshTableViewData) withObject:nil afterDelay:0.1];
    [dishTable performSelector:@selector(doneLoadingGuluRefreshTableViewData) withObject:nil afterDelay:0.1];
    [missionTable performSelector:@selector(doneLoadingGuluRefreshTableViewData) withObject:nil afterDelay:0.1];
    
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods


-(void)GuluTableViewRefreshDelegateTrgger :(GuluTableView *)guluTable
{
    [self search];
}




@end
