//
//  ReviewAndCommentsListTableView.m
//  GULUAPP
//
//  Created by alan on 11/9/23.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "ReviewAndCommentsListTableView.h"

@implementation ReviewAndCommentsListTableView


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UserHeaderView *view1 = [[[UserHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];
    
    GuluReviewModel *review=[tableArray objectAtIndex:0];
    
    NSString *name=review.user.username;
    [view1.nameBtn setTitle:name forState:UIControlStateNormal ];
    [view1.imageView setImageWithURL:[NSURL URLWithString:review.user.photo.image_small]];
    
    return view1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     GuluReviewModel *review=[tableArray objectAtIndex:0];
    
    if(indexPath.row==0)
    {
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
    
    else
    {
        float height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
        
        return height;
    }
    
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

     GuluReviewModel *review=[tableArray objectAtIndex:0];
    
    if(indexPath.row==0)
    {
        static NSString *cellIdentifier = @"GuluTableViewCell_BigPhoto";
        GuluTableViewCell_BigPhoto *cell=[GuluTableViewCell_BigPhoto cellForIdentifierOfTable:cellIdentifier table:tableView];
        
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
        return cell;
    }
    else
    {
        UITableViewCell *cell=[super tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell;
    }
    
    return  nil;


}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deselectRowAtIndexPath:indexPath animated:NO];    
}


- (void)dealloc {

    [super dealloc];
}



@end
