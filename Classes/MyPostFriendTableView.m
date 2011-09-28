//
//  MyPostFriendTableView.m
//  GULUAPP
//
//  Created by alan on 11/9/23.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "MyPostFriendTableView.h"

#import "userFriendProfileViewController.h"
#import "FriendHeaderView.h"
#import "addFriendViewController.h"


@implementation MyPostFriendTableView

@synthesize navigationController;

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   /* addFriendViewController *VC=[[addFriendViewController alloc] initWithNibName:@"addFriendView" bundle:nil];
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];*/
    
    [self deselectRowAtIndexPath:indexPath animated:YES];
}


@end
