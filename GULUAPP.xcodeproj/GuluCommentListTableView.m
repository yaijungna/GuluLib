//
//  GuluCommentListTableView.m
//  GULUAPP
//
//  Created by alan on 11/9/23.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluCommentListTableView.h"

@implementation GuluCommentListTableView

- (id)initWithFrame:(CGRect)frame pullToRefresh:(BOOL)refresh
{
    self = [super initWithFrame:frame pullToRefresh:refresh];
    if (self) {
        
        self.delegate=self;
        self.dataSource=self;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableArray count];
}
 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GuluCommentModel *comment=[tableArray objectAtIndex:indexPath.row];
    UILabel *contentLabel=[[[UILabel alloc] init] autorelease];
    [contentLabel customizeLabelToGuluStyle];
    contentLabel.text=comment.comment;
    
    return 5+25+[contentLabel dynamicSizeOfText:CGSizeMake(235, 1000)].height+25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"GuluTableViewCell_Comment";
    GuluTableViewCell_Comment *cell=[GuluTableViewCell cellForIdentifierOfTable:cellIdentifier table:tableView];
    cell.tag=indexPath.row;
    GuluCommentModel *comment=[tableArray objectAtIndex:indexPath.row];
    
    cell.timeLabel.text=[GuluUtility timeAgoString:comment.time_ago];
    [cell.userNameBtn setTitle:comment.user.username forState:UIControlStateNormal];
    [cell.userImageview setImageWithURL:[NSURL URLWithString:comment.user.photo.image_small]];
    cell.contentLabel.text=comment.comment;

    return cell;
}
 
- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



- (void)dealloc {

    [super dealloc];
}

@end
