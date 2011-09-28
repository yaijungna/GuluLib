//
//  searchMissionTable.m
//  GULUAPP
//
//  Created by alan on 11/9/27.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "searchMissionTable.h"

@implementation searchMissionTable

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableview deselectRowAtIndexPath:indexPath animated:YES];
    [GuluNavigationManager gotoMissionProfile:self.navigationController missions:[tableArray objectAtIndex:indexPath.row]];
}

@end
