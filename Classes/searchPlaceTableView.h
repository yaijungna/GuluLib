//
//  searchPlaceTableView.h
//  GULUAPP
//
//  Created by alan on 11/9/27.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluNavigationManager.h"
#import "GuluPlaceListTableView.h"
#import "moreView.h"

@interface searchPlaceTableView : GuluPlaceListTableView
{
    NSIndexPath *indexPathRowForMore;
    id  moreDelegateVC;
}

@property(nonatomic,retain) NSIndexPath *indexPathRowForMore;
@property(nonatomic,retain) id moreDelegateVC;

@end
