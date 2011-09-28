//
//  MyGuluMyPostTableView.h
//  GULUAPP
//
//  Created by alan on 11/9/23.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+WebCache.h"
#import "GuluTableView.h"
#import "UILabel+Custom.h"
#import "GuluTableViewCell_BigPhoto.h"
#import "GuluReviewModel.h"

#import "reviewProfileViewController.h"

@interface MyGuluMyPostTableView : GuluTableView <UITableViewDelegate , UITableViewDataSource>
{
    
}

@property (nonatomic,assign) UINavigationController *navigationController;
@end
