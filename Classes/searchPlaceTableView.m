//
//  searchPlaceTableView.m
//  GULUAPP
//
//  Created by alan on 11/9/27.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "searchPlaceTableView.h"

@implementation searchPlaceTableView

@synthesize indexPathRowForMore;
@synthesize moreDelegateVC;

- (UITableViewCell *)tableView:(UITableView *)theTableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *tablecell = [super tableView:theTableView cellForRowAtIndexPath:indexPath];
    GuluTableViewCell_Image_Twoline *cell = (GuluTableViewCell_Image_Twoline *)tablecell;
    cell.contentView.tag=indexPath.row;
    if(!cell.isReusedCell)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(290, 18, 25, 25);
        [button setBackgroundImage:[UIImage imageNamed:@"more-icon-1.png"] forState:UIControlStateNormal];        
        [button addTarget:self action:@selector(checkButtonTapped:event:)  forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
        
        moreView *more=[[[moreView alloc] initWithFrame:CGRectMake(320, 0, 320, 60)] autorelease];
        more.tag=0;
        more.delegate=moreDelegateVC;
        cell.viewForMore=more;
        [cell.contentView addSubview:more];
    }   
    
    return  cell;
} 

- (void)checkButtonTapped:(id)sender event:(id)event
{
    UITableViewCell *cellToOrigin = [self cellForRowAtIndexPath:indexPathRowForMore];
    GuluTableViewCell_Image_Twoline *guluCellToOrigin= (GuluTableViewCell_Image_Twoline *)cellToOrigin;
    [GuluUtility moveTheView:guluCellToOrigin.viewForMore moveToPosition:CGPointMake(320,0)];
    
    NSInteger index=[((UIButton *)sender) superview].tag;
    self.indexPathRowForMore=[NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *tablecell = [self cellForRowAtIndexPath:indexPathRowForMore];
    GuluTableViewCell_Image_Twoline *guluCell= (GuluTableViewCell_Image_Twoline *)tablecell;
    [GuluUtility moveTheView:guluCell.viewForMore moveToPosition:CGPointMake(0,0)];

}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableview deselectRowAtIndexPath:indexPath animated:YES];
    [GuluNavigationManager gotoPlaceProfile:self.navigationController place:[tableArray objectAtIndex:indexPath.row]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPathRowForMore];
    GuluTableViewCell_Image_Twoline *guluCell= (GuluTableViewCell_Image_Twoline *)cell;
    [GuluUtility moveTheView:guluCell.viewForMore moveToPosition:CGPointMake(320,0)];	
	[self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];	
}

-(void)reloadData
{
    [super reloadData];
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPathRowForMore];
    GuluTableViewCell_Image_Twoline *guluCell= (GuluTableViewCell_Image_Twoline *)cell;
    [GuluUtility moveTheView:guluCell.viewForMore moveToPosition:CGPointMake(320,0)];	
    self.indexPathRowForMore=nil;
}

-(void)dealloc
{
    [indexPathRowForMore release];
    [super dealloc];
}

@end
