//
//  GuluMissionListTableView.m
//  GULUAPP
//
//  Created by alan on 11/9/27.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluMissionListTableView.h"

@implementation GuluMissionListTableView


- (id)initWithFrame:(CGRect)frame pullToRefresh:(BOOL)refresh
{
    self = [super initWithFrame:frame pullToRefresh:refresh];
    if (self) {
        
        self.delegate=self;
        self.dataSource=self;
        
    }
    return self;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    NSString *cellClassStr = @"GuluTableViewCell_Image_Twoline";
    
    GuluTableViewCell_Image_Twoline *cell = [GuluTableViewCell cellForIdentifierOfTable:cellClassStr table:tableView];
    cell.tag=indexPath.row;
    
    GuluMissionModel *mission=[tableArray objectAtIndex:indexPath.row];
    
    cell.label1.text=mission.title;
    cell.label2.text=[NSString stringWithFormat: @"%@ %@",NSLocalizedString(@"created by", @"by whom create this mission"),mission.created_user.username];
    
    NSString *url_key=mission.badge_pic.image_small;
    [cell.leftImageview setImageWithURL:[NSURL URLWithString:url_key]];		
    
    return cell;
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



- (void)dealloc {
	
    [super dealloc];
}


@end