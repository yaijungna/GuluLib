//
//  AroundMeTableView.h
//  GULUAPP
//
//  Created by alan on 11/9/23.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluTableView.h"
#import "UILabel+Custom.h"
#import "GuluTableViewCell_BigPhoto.h"
#import "GuluAroundMeModel.h"
#import "GuluAPIManager.h"

#import "reviewProfileViewController.h"

@interface AroundMeTableView : GuluTableView <UITableViewDelegate , UITableViewDataSource>
{   
    GuluHttpRequest *targetObjectRequest;
}

@property (nonatomic,assign) UINavigationController *navigationController;
@property (nonatomic,retain) GuluHttpRequest *targetObjectRequest;


@end
