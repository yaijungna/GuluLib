//
//  GuluFriendListTableView.m
//  GULUAPP
//
//  Created by alan on 11/9/22.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluFriendListTableView.h"


@implementation GuluFriendListTableView

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
	return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    NSString *cellClassStr = @"GuluTableViewCell_Image_Oneline";
    
    GuluTableViewCell_Image_Oneline *cell = [GuluTableViewCell cellForIdentifierOfTable:cellClassStr table:tableView];
    cell.tag=indexPath.row;
    
    if(!cell.isReusedCell)
    {
        [cell.label1 customizeLabelToGuluStyle];
    } 
    
    GuluContactModel *user=[tableArray objectAtIndex:indexPath.row];
    
    if(user.first_name==nil){
        user.first_name=@"";}
    if(user.last_name==nil){
        user.last_name=@"";}
    
    [cell.leftImageview setImageWithURL:[NSURL URLWithString:user.profile_pic]];
    cell.label1.text=[NSString stringWithFormat:@"%@ %@",user.first_name,user.last_name];  
    
    return cell;
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


- (void)dealloc {
    [super dealloc];
}


@end
