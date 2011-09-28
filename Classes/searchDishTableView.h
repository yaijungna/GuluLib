//
//  searchDishTableView.h
//  GULUAPP
//
//  Created by alan on 11/9/27.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluNavigationManager.h"
#import "GuluDishListTableView.h"
#import "moreView.h"

@interface searchDishTableView : GuluDishListTableView
{
    NSIndexPath *indexPathRowForMore;
    id  moreDelegateVC;
}

@property(nonatomic,retain) NSIndexPath *indexPathRowForMore;
@property(nonatomic,retain) id moreDelegateVC;

@end
