//
//  MyGuluMyPostTableView.m
//  GULUAPP
//
//  Created by alan on 11/9/23.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "MyGuluMyPostTableView.h"

@implementation MyGuluMyPostTableView

@synthesize navigationController;

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GuluReviewModel *review=[tableArray objectAtIndex:indexPath.row];
    NSString *dishName=review.dish.name;
    NSString *placeName=review.restaurant.name;
    
    if(dishName==nil){
        dishName=@"";}

    UILabel *contentLabel=[[[UILabel alloc] init] autorelease];
    [contentLabel customizeLabelToGuluStyle];
    contentLabel.text=review.content;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn customizeLabelToGuluStyle];

    [btn setTitle:dishName forState:UIControlStateNormal];
    CGSize btn1Size=[btn dynamicSizeOfText:CGSizeMake(300, 20)];
    [btn setTitle:placeName forState:UIControlStateNormal];
    CGSize btn2Size=[btn dynamicSizeOfText:CGSizeMake(300, 20)];
    
    if(btn1Size.width + btn2Size.width >200){
        return 5+280+20+20+[contentLabel dynamicSizeOfText:CGSizeMake(300, 10000)].height+20+5+3;}
    else{
        return 5+280+20+[contentLabel dynamicSizeOfText:CGSizeMake(300, 10000)].height+20+5+3;}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"GuluTableViewCell_BigPhoto";
    GuluTableViewCell_BigPhoto *cell=[GuluTableViewCell_BigPhoto cellForIdentifierOfTable:cellIdentifier table:tableView];
         
    GuluReviewModel *review=[tableArray objectAtIndex:indexPath.row];
    
    NSString *dishName=review.dish.name;
    NSString *placeName=review.restaurant.name;
    

    
    [cell.bigImageview setImageWithURL:[NSURL URLWithString:review.photo.image_large]];
    
    cell.Btn1.titleLabel.text=dishName;
    cell.Btn2.titleLabel.text=placeName;
    
    [cell.Btn1 setTitle:dishName forState:UIControlStateNormal];
    [cell.Btn2 setTitle:placeName forState:UIControlStateNormal];
    cell.contentLabel.text=review.content;  
    cell.likeView.numOfLike=review.like_count;
    cell.commentView.numOfComment=review.comment_count;
        

    return  cell;
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GuluReviewModel *review=[tableArray objectAtIndex:indexPath.row];
   
    reviewProfileViewController *VC=[[reviewProfileViewController alloc] initWithNibName:@"reviewProfileViewController" bundle:nil];
    VC.reviewModel=review;
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];

    [self deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)dealloc {
	
    [super dealloc];
}


@end
