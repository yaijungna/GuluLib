//
//  AroundMeTableView.m
//  GULUAPP
//
//  Created by alan on 11/9/23.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "AroundMeTableView.h"

@implementation AroundMeTableView

@synthesize navigationController;
@synthesize targetObjectRequest;

- (id)initWithFrame:(CGRect)frame pullToRefresh:(BOOL)refresh
{
    self = [super initWithFrame:frame pullToRefresh:refresh];
    if (self) {
        
        self.delegate=self;
        self.dataSource=self;
        
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    UserHeaderView *view1 = [[[UserHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];
    view1.tag=section;
    
    GuluAroundMeModel *aroundme=[tableArray objectAtIndex:section];
    NSString *name=aroundme.user.username;
    [view1.nameBtn setTitle:name forState:UIControlStateNormal ];
    
    [view1.imageView setImageWithURL:[NSURL URLWithString:aroundme.user.photo.image_small]];
  
    return view1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 5+280+20+0+20+5+3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [tableArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"GuluTableViewCell_BigPhoto";
    GuluTableViewCell_BigPhoto *cell=[GuluTableViewCell_BigPhoto cellForIdentifierOfTable:cellIdentifier table:tableView];
    
    GuluAroundMeModel *aroundme=[tableArray objectAtIndex:indexPath.section];
    NSString *placeName=aroundme.restaurant.name;
    
    [cell.bigImageview setImageWithURL:[NSURL URLWithString:aroundme.photo.image_large]];
    cell.Btn2.titleLabel.text=placeName;
    [cell.Btn2 setTitle:placeName forState:UIControlStateNormal];
    cell.likeView.numOfLike=aroundme.like_count;
    cell.commentView.numOfComment=aroundme.comment_count;
    
    return  cell;
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GuluAroundMeModel *aroundme=[tableArray objectAtIndex:indexPath.section];
    
    reviewProfileViewController *VC=[[reviewProfileViewController alloc] initWithNibName:@"reviewProfileViewController" bundle:nil];
    VC.targetID=aroundme.target_id;
    VC.targetType=aroundme.target_type;
    VC.reviewModel=[[[GuluReviewModel alloc] init] autorelease];
    VC.reviewModel.user=aroundme.user;
    VC.reviewModel.photo=aroundme.photo;
    VC.reviewModel.restaurant=aroundme.restaurant;
    VC.reviewModel.comment_count=aroundme.comment_count;
    VC.reviewModel.like_count=aroundme.like_count;
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];

    [self deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc {

    [super dealloc];
}


@end