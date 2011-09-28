//
//  MissionLandingViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/7.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "MissionLandingViewController.h"
#import "ACTableTwoLinesWithImageCell.h"
#import "ACTableMissionLandingCell.h"

#import "RestaurantProfileViewController.h"
#import "oneLineTableHeaderView.h"

#import "DesignMissionProfileViewController.h"

#import "pickChallengersViewController.h"

#import "missionChatViewController.h"

#import "gradeMissionViewContorller.h"

#import "CreateMissionViewController.h"

#import "missionProfileviewcontroller.h"

#import "UIImageView+WebCache.h"

@implementation MissionLandingViewController

@synthesize gradeMissionArray;
@synthesize myMissionArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray  *array=[NSArray arrayWithObjects:
                     NSLocalizedString(@"My Missions", @"[mission]Main tab"),
                     NSLocalizedString(@"Grade Challengers", @"[mission]Main tab"),nil];
	
	//segment=[[ACSegmentController alloc] initWithFrame:CGRectMake(0, 40, 320, 40)];
	segment=[[ACSegmentController alloc] initWithFrame:CGRectMake(0, 40, 320, 40)];
	[segment initCustomSegment:array 
                   normalimage:[UIImage imageNamed:@"seg02-2.png"]
                 selectedimage:[UIImage imageNamed:@"seg02-1.png"] 
                      textfont:[UIFont fontWithName:FONT_BOLD size:10]];
	[segment setSelectedButtonAtIndex:MyMissionLandingType];
	segment.delegate=self;
	[self.view addSubview:segment];
	[segment release];	
    [self touchSegmentAtIndex:0];

	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeCreateMission
                                                                                      middle:ButtonTypeGuluLogo right:ButtonTypeImHungry];
	[self.view addSubview:topView];

    
    [topView.topLeftButton	addTarget:self action:@selector(createAction) forControlEvents:UIControlEventTouchUpInside];  
    [topView.topRightButton addTarget:self action:@selector(iamhungry) forControlEvents:UIControlEventTouchUpInside];
    
    
	bottomView=[[[BottomMenuBarView alloc] initWithFrame:CGRectMake(0, 410, 320, 50)] initBottomBarView:ButtonTypeMyGulu
                                                                                                second:ButtonTypeChat 
                                                                                                 third:ButtonTypePost 
                                                                                                 forth:ButtonTypeMissions 
                                                                                                 fifth:ButtonTypeSearch];
	[bottomView setUpMainBtnAction];
	[self.view addSubview:bottomView];

	
	[bottomView setUpMainBtnSelected:3];
    
    [self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
    
    LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	LoadingView.hidden=YES;

    //=================================================
    
    [self customizeTableView:table_mine];
	_refreshHeaderView_mine = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - table_mine.bounds.size.height, self.view.frame.size.width,table_mine.bounds.size.height)];
	_refreshHeaderView_mine.delegate = self;
	[table_mine addSubview:_refreshHeaderView_mine];
	[_refreshHeaderView_mine release];
	[_refreshHeaderView_mine refreshLastUpdatedDate];
    
    [self customizeTableView:table_grade];
	_refreshHeaderView_grade = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - table_grade.bounds.size.height, self.view.frame.size.width,table_grade.bounds.size.height)];
	_refreshHeaderView_grade.delegate = self;
	[table_grade addSubview:_refreshHeaderView_grade];
	[_refreshHeaderView_grade release];
	[_refreshHeaderView_grade refreshLastUpdatedDate];
    
    
    if([ACCheckConnection isConnectedToNetwork])
    {
        [self getMyMissionList];
        [self getMyCreatedMissionList];
    }
    else
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
    }
    
    [[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(getMyMissionList)
	 name: @"refreshMyMission"
	 object:nil];
    
    [[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(getMyCreatedMissionList)
	 name: @"refreshTheMissionICreated"
	 object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(hungryStatusNotifyAction)
     name: @"hungryStatusNotify"
     object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hungryStatusNotify" object:nil];
}

- (void)didReceiveMemoryWarning {
   
    [super didReceiveMemoryWarning];
    
   
}

- (void)viewDidUnload {
    [super viewDidUnload];
   
}


- (void)dealloc {
    [super dealloc];
    
    [gradeMissionArray release];
    [myMissionArray release];
    
    [topView release];topView=nil;
    [bottomView release];bottomView=nil;
    
    [network release];
    
    [LoadingView release];
    
}


#pragma mark -
#pragma mark action Function Methods



- (void)createAction
{
    CreateMissionViewController *VC=[[CreateMissionViewController alloc] initWithNibName:@"CreateMissionViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];
}


-(void)hungryStatusNotifyAction
{
    if(![topView.topRightButton isKindOfClass:[UIButton class]])
        return;
    
    if(appDelegate.hungry.hungryStatus==NO)
    {
        [((UIButton *)topView.topRightButton) setTitle:NSLocalizedString(@"I'm Hungry", @"cancel") forState:UIControlStateNormal];
    }
    else
    {
        [((UIButton *)topView.topRightButton) setTitle:NSLocalizedString(@"Cancel Hungry", @"cancel") forState:UIControlStateNormal];
    }
}


#pragma mark -
#pragma mark segment Delegate Function Methods

- (void) touchSegmentAtIndex:(NSInteger)segmentIndex
{
    table_grade.hidden=YES;
    table_mine.hidden=YES;
    
	if(segmentIndex==MyMissionLandingType) //mymission
	{
		table_mine.hidden=NO;
	}
	else if(segmentIndex==GradeMissionType) //grade
	{
		table_grade.hidden=NO;
	}
}

#pragma mark -
#pragma mark Table Delegate Function Methods


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    oneLineTableHeaderView *view1 = [[[oneLineTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)]autorelease];
    
    if(tableView==table_mine) //mymission
	{
        if(section==0)
        {
            view1.label1.text=NSLocalizedString(@"Missions I'm Doing",@"[title]");
        }
        else if(section==1)
        {
            view1.label1.text=NSLocalizedString(@"Mission I've Been Recruited To",@"[title]");
        }
        else if(section==2)
        {
            view1.label1.text=NSLocalizedString(@"Mission I've Completed",@"[title]");
        }
        
        view1.rightBtn.hidden=YES;
        [self customizeLabel:view1.label1];
	}
    else if(tableView==table_grade) //grade
	{
        view1.label1.text=NSLocalizedString(@"Missions To Be Graded",@"[title]");
        view1.rightBtn.hidden=YES;
        [self customizeLabel:view1.label1];
	}

	return view1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if(tableView==table_mine) //mymission
	{
		return 3;
	}
	else if(tableView==table_grade) //grade
	{
		return  1;
	}
    
    return  0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if(tableView==table_mine) //mymission
	{
        if(section==0)
        {
            return [[myMissionArray objectAtIndex:0] count];
        }
        if(section==1)
        {
            return [[myMissionArray objectAtIndex:1] count];
        }
        if(section==2)
        {
            return [[myMissionArray objectAtIndex:2] count];
        }
        
		return  0;
	}
	else if(tableView==table_grade) //grade
	{
		return [gradeMissionArray count];
	}

    return  0;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView==table_mine) //mymission
	{
		return  60;
	}
	else if(tableView==table_grade) //grade
	{
		return 60;
	}
    
    return  0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if(tableView==table_mine) //mymission
	{
        
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
                    [cell setRightBtnToNormaltype];
                }
            }
        }
        
        if(indexPath.section==0)
        {
            NSDictionary *missionDict=[[[myMissionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"object"];
            NSString *titleString=[missionDict objectForKey:@"title"];
            NSString *subtitleString=[missionDict objectForKey:@"description"];
            
            cell.label1.text=titleString;
            cell.label2.text=subtitleString;
            
            
        }
        if(indexPath.section==1)
        {
            NSDictionary *missionDict=[[[myMissionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"object"];
            NSString *titleString=[missionDict objectForKey:@"title"];
            NSString *subtitleString=[[missionDict objectForKey:@"inviter"] objectForKey:@"username"];
            
            cell.label1.text=titleString;
            cell.label2.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"You have been recruited by", @"[mission]"),subtitleString];
            
        }
        if(indexPath.section==2)
        {
            
            NSDictionary *missionDict=[[[myMissionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"object"];
            NSString *titleString=[missionDict objectForKey:@"title"];
            NSString *subtitleString=[missionDict objectForKey:@"description"];
            
            cell.label1.text=titleString;
            cell.label2.text=subtitleString;
            
        }
        
        //=================================================
        
        NSDictionary *dict=[[[myMissionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"object"];
        NSString *url_key=[[dict  objectForKey:@"badge_pic"]  objectForKey:@"image_small"];
        [cell.leftImageview setImageWithURL:[NSURL URLWithString:url_key]];
        
        
        return cell;
        
    }
    else if(tableView==table_grade) //grade
	{
        
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
                    [cell setRightBtnToNormaltype];
                }
            }
        }
        
        
        NSDictionary *missionDict=[gradeMissionArray  objectAtIndex:indexPath.row] ;
        NSString *titleString=[missionDict objectForKey:@"title"];
        NSString *challenger=[missionDict objectForKey:@"grade_number"];
        NSString *group=[missionDict objectForKey:@"group_number"];
        
        NSString *subtitleString=[NSString stringWithFormat:@"%@:%@ / %@:%@",
                                  NSLocalizedString(@"Challengers", @"mission"),
                                  challenger,
                                   NSLocalizedString(@"Groups", @"mission"),
                                  group];
        
        cell.label1.text=titleString;
        cell.label2.text=subtitleString;
        
        
        //=================================================
        NSDictionary *dict=[gradeMissionArray  objectAtIndex:indexPath.row];
        NSString *url_key=[[dict  objectForKey:@"badge_pic"]  objectForKey:@"image_small"];
        [cell.leftImageview setImageWithURL:[NSURL URLWithString:url_key]];

        return cell;
		
	}
	
	return nil;
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self shareGULUAPP];
  
    
    if(tableview==table_mine)
    {
        
        NSDictionary *missiondict=[[[myMissionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"object"];
        
        missionProfileviewcontroller *VC=[[missionProfileviewcontroller alloc] initWithNibName:@"missionProfileviewcontroller" bundle:nil];
        VC.missionDict=missiondict;
        VC.chatDict=[[myMissionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        VC.fromChat=NO;
        VC.fromMission=YES;
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
        
    }
    if(tableview==table_grade)
    {
        gradeMissionViewContorller *VC=[[gradeMissionViewContorller alloc] initWithNibName:@"gradeMissionViewContorller" bundle:nil];	
        VC.missionDict=[gradeMissionArray objectAtIndex:indexPath.row] ;
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
    
    }
    
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableview 
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if(tableview==table_mine)
    {
        
        if(indexPath.section==0)
        {
            return UITableViewCellEditingStyleDelete;
        }
        else
        {
            return UITableViewCellEditingStyleNone;
        }
    }
    else
    {
        return UITableViewCellEditingStyleNone;
    }
    
    return UITableViewCellEditingStyleNone;
	
}

- (void)tableView:(UITableView *)tableview commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (editingStyle == UITableViewCellEditingStyleDelete) 
	{
		if(tableview==table_mine) //mymission
        {
            NSDictionary *missionDict=[[[myMissionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"object"];                  
            NSString *mid=[missionDict objectForKey: @"id"];
            
            [self leaveMission:mid];
        }
	}     
}



#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource_mine{
    
    
    if([ACCheckConnection isConnectedToNetwork])
    {
        _reloading_mine = YES;
        [self getMyMissionList];
    }
    else
    {
        [self performSelector:@selector(doneLoadingTableViewData_mine) withObject:nil afterDelay:0.1];
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
    }

}

- (void)doneLoadingTableViewData_mine{
	
	//  model should call this when its done loading
	
	_reloading_mine = NO;
	[_refreshHeaderView_mine egoRefreshScrollViewDataSourceDidFinishedLoading:table_mine];
	
}

//============

- (void)reloadTableViewDataSource_grade{
    
    if([ACCheckConnection isConnectedToNetwork])
    {
        _reloading_grade = YES;
        [self getMyCreatedMissionList];
    }
    else
    {
        [self performSelector:@selector(doneLoadingTableViewData_grade) withObject:nil afterDelay:0.1];
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
    }
}

- (void)doneLoadingTableViewData_grade{
	
	//  model should call this when its done loading
	
	_reloading_grade = NO;
	[_refreshHeaderView_grade egoRefreshScrollViewDataSourceDidFinishedLoading:table_grade];
	
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

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
    }
    
    if(table_grade.hidden==NO)
    {
        [_refreshHeaderView_grade egoRefreshScrollViewDidEndDragging:scrollView];
    }
    

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{		

}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	//[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
    
    if(view==_refreshHeaderView_grade)
    {
        [self reloadTableViewDataSource_grade];
        
    }
    if(view==_refreshHeaderView_mine)
    {
        [self reloadTableViewDataSource_mine];
    }
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
    
    if(view==_refreshHeaderView_grade)
    {
        return _reloading_grade; // should return if data source model is reloading
    }
    if(view==_refreshHeaderView_mine)
    {
        return _reloading_mine; // should return if data source model is reloading
    }
	
    return NO;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
    
}


#pragma mark -
#pragma mark  request Delegate Methods

-(void)getMyMissionList
{
    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    [self myMissionConnection:network];
}

-(void)getMyCreatedMissionList
{
    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    [self myCreatedMissionConnection:network];
}

-(void)leaveMission:(NSString *)mid
{

    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    [self leaveMissionConnection:network missionID:mid];
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
    ACLog(@"request ok");
    
    if([temp  isKindOfClass:[NSDictionary class]])
    {
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
        {
            ACLog(@"request error");
            [self performSelector:@selector(doneLoadingTableViewData_mine) withObject:nil afterDelay:0.1];
            [self performSelector:@selector(doneLoadingTableViewData_grade) withObject:nil afterDelay:0.1];
            return;
        }
    }

    
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"missionMine"])
	{
        [self performSelector:@selector(doneLoadingTableViewData_mine) withObject:nil afterDelay:0.1];
        
        if([temp isKindOfClass:[NSDictionary class]])
        {
            if([temp objectForKey:@"errorMessage"])
            {
                [self showErrorAlert:GLOBAL_ERROR_STRING];
                return;
            }
        }
        
		self.myMissionArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
        
        NSMutableArray  *myMissionArray_1 = [[[NSMutableArray alloc] init] autorelease];
        NSMutableArray  *myMissionArray_2 = [[[NSMutableArray alloc] init] autorelease];
        NSMutableArray  *myMissionArray_3 = [[[NSMutableArray alloc] init] autorelease];
        
        
        for(NSDictionary *Dict in  myMissionArray )
		{
            NSDictionary *dict=[Dict objectForKey:@"object"];
         
            NSNumber *member_status=[dict objectForKey:@"member_status"];
            NSNumber *group_status=[dict objectForKey:@"group_status"];
            
            if([member_status isEqualToNumber:[NSNumber numberWithInt:0]])  // i have been recruited
            {
                [myMissionArray_2 addObject:Dict];
            }
            else  if([member_status isEqualToNumber:[NSNumber numberWithInt:1]])
            {
                if([group_status isEqualToNumber:[NSNumber numberWithInt:0]]  ||
                   [group_status isEqualToNumber:[NSNumber numberWithInt:2]])   // i am doing
                {
                    [myMissionArray_1 addObject:Dict];
                }
                else   // i am done
                {
                    [myMissionArray_3 addObject:Dict];
                }
            }
            else if([member_status isEqualToNumber:[NSNumber numberWithInt:2]])
            {
            
            }
        }
        self.myMissionArray=[[[NSMutableArray alloc] init] autorelease];
        [myMissionArray addObject:myMissionArray_1];
        [myMissionArray addObject:myMissionArray_2];
        [myMissionArray addObject:myMissionArray_3];

        [table_mine reloadData];
	}
    
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"mycreatedmission"])
	{
        [self performSelector:@selector(doneLoadingTableViewData_grade) withObject:nil afterDelay:0.1];
        
        if([temp isKindOfClass:[NSDictionary class]])
        {
            if([temp objectForKey:@"errorMessage"])
            {
                [self showErrorAlert:GLOBAL_ERROR_STRING];
                return;
            }
        }
        
		self.gradeMissionArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
        
        [table_grade reloadData];
	}
    
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"leavemission"])
	{
        
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
        {
            [self showErrorAlert:GLOBAL_ERROR_STRING];
            return;
        }
        
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSNumber class]])
        {

            if([[temp objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]])
            {
                [self showOKAlert:NSLocalizedString(@"Delete mission ok", @"[mission]")];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyMission" object:nil];
            }
        }
    }
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	
    [self hideSpinnerView:LoadingView];
   
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"missionMine"])
	{
        [self performSelector:@selector(doneLoadingTableViewData_mine) withObject:nil afterDelay:0.1];
    }
    
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"mygrademission"])
	{
        [self performSelector:@selector(doneLoadingTableViewData_grade) withObject:nil afterDelay:0.1];
    }
	
}



@end
