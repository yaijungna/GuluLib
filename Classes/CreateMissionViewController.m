//
//  CreateMissionViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/9.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "CreateMissionViewController.h"

#import "ACTableTwoLinesWithImageCell.h"
#import "ACTableMissionLandingCell.h"

#import "oneLineTableHeaderView.h"

#import "DesignMissionProfileViewController.h"

#import "pickChallengersViewController.h"


@implementation CreateMissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack
                                                                                      middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
	[self.view addSubview:topView];
	[topView release];
    
    [topView.topLeftButton	addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topMiddleButton addTarget:self action:@selector(landingAction) forControlEvents:UIControlEventTouchUpInside];

	
	
    //=================================================
    
    [self customizeTableView:table_design];
    

    //==========================================
    
    designMissionPhotoArray=[[NSArray alloc] initWithObjects:
                             @"food-guide-icon-1.png",
                             @"dare-mission-icon-1.png",
                             @"treasure-hunt-icon-1.png",
                             @"time-critical-mission-icon-1.png",
                             @"private-group-mission-icon-1.png",
                             nil];
    
    designMissionStringArray=[[NSArray alloc] initWithObjects:
                              NSLocalizedString(@"Food Guide", @"[Mission type]"),
                              NSLocalizedString(@"Dare Mission", @"[Mission type]"),
                              NSLocalizedString(@"Treasure Hunt", @"[Mission type]"),
                              NSLocalizedString(@"Time Critical Mission", @"[Mission type]"),
                              NSLocalizedString(@"Private Group Mission", @"[Mission type]"),
                              nil];
    
    designMissionSubTitleStringArray =[[NSArray alloc] initWithObjects:
                                       NSLocalizedString(@"Make a guide of great food & restaurants.", @"[Mission type]"),
                                       NSLocalizedString(@"Dare a friend on a dining mission while friends spectate.", @"[Mission type]"),
                                       NSLocalizedString(@"Make a food treasure hunt or dining puzzle.", @"[Mission type]"),
                                       NSLocalizedString(@"You need to finish this mission in a certain time frame.", @"[Mission type]"),
                                       NSLocalizedString(@"Tonight's agenda with friends, Barcrawl,etc...", @"[Mission type]"),
                                       nil];
    

    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [designMissionPhotoArray release];
    [designMissionStringArray release];
    [designMissionSubTitleStringArray release];
    
    [super dealloc];
    
}

#pragma mark -
#pragma mark action Function Methods



- (void)backAction 
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)landingAction 
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}



#pragma mark -
#pragma mark Table Delegate Function Methods


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    oneLineTableHeaderView *view1 = [[[oneLineTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)]autorelease];
    
    view1.label1.text=NSLocalizedString(@"What kind of mission are you designing",@"[title]");
    view1.rightBtn.hidden=YES;
    [self customizeLabel:view1.label1];
    
	return view1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
 
		return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 	[designMissionPhotoArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 	60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *cellIdentifier = @"ACTableMissionLandingCell";
    static NSString *nibNamed = @"ACTableMissionLandingCell";
    
    ACTableMissionLandingCell *cell = (ACTableMissionLandingCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell= (ACTableMissionLandingCell*) currentObject;
                [cell initCell];
                [self customizeLabel_title:cell.labelTitle ];
                [self customizeLabel:cell.labelSubTitle ];
                cell.labelSubTitle.textColor=[UIColor grayColor];
                cell.labelSubTitle.numberOfLines=2;
                cell.labelSubTitle.font=[UIFont fontWithName:FONT_NORMAL size:12];
            }
        }
    }
    
    cell.leftImageview.image=[UIImage imageNamed:[designMissionPhotoArray objectAtIndex:indexPath.row]];
    cell.labelTitle.text=[designMissionStringArray objectAtIndex:indexPath.row];
    cell.labelSubTitle.text=[designMissionSubTitleStringArray objectAtIndex:indexPath.row];
    
    return cell;

}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self shareGULUAPP];
    
        missionModel *obj=[[[missionModel alloc] init] autorelease];
        obj.challengersDict=[[[NSMutableDictionary alloc] init] autorelease];
        obj.spectatorDict=[[[NSMutableDictionary alloc] init] autorelease];
        appDelegate.temp.missionObj=obj;
        
        DesignMissionProfileViewController *VC=[[DesignMissionProfileViewController alloc] initWithNibName:@"DesignMissionProfileViewController" bundle:nil];
        
        
        if(indexPath.row==FoodGuideMissionType)
        {
            appDelegate.temp.missionObj.missionType=FoodGuideMissionType;
        }
        else if(indexPath.row==DareMissiontype)
        {
            appDelegate.temp.missionObj.missionType=DareMissiontype;
        }
        else if(indexPath.row==TreasureHuntMissionType)
        {
            appDelegate.temp.missionObj.missionType=TreasureHuntMissionType;
        }
        else if(indexPath.row==TimeCriticalMissionType)
        {
            appDelegate.temp.missionObj.missionType=TimeCriticalMissionType;
        }
        else if(indexPath.row==PrivateGroupMissionType)
        {
            appDelegate.temp.missionObj.missionType=PrivateGroupMissionType;
        }
        
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
       
}






@end