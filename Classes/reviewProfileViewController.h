//
//  reviewProfileViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/5.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"

#import "ChatTextFieldView.h"
#import "UserHeaderView.h"

#import "GuluAPIManager.h"
#import "GuluCommentListTableView.h"
#import "UIImageView+WebCache.h"
#import "GuluBasicViewController.h"
#import "ReviewAndCommentsListTableView.h"

@interface reviewProfileViewController : GuluBasicViewController <GuluTableViewRefreshDelegate,GuluAPIAccessManagerDelegate,UITextFieldDelegate>
{
    IBOutlet UIView *myView;
    ReviewAndCommentsListTableView *commentTable;
    ChatTextFieldView *chatView;
    
    GuluHttpRequest  *objectRequest;
    GuluHttpRequest  *commentRequest;
    
    NSString *targetID;
    GuluTargetType targetType;
    GuluReviewModel *reviewModel;
   
}

@property (nonatomic,retain)NSString *targetID;
@property (nonatomic,assign)GuluTargetType targetType;
@property (nonatomic,retain)GuluReviewModel *reviewModel;

@property (nonatomic,retain) GuluHttpRequest  *objectRequest;
@property (nonatomic,retain) GuluHttpRequest  *commentRequest;

-(void)getGeneralObject;
-(void)getcommentList;
-(void)postComment;
-(void)scrollToTableEnd;

@end
