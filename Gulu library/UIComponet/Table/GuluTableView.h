//
//  GuluTableView.h
//  GULUAPP
//
//  Created by alan on 11/9/15.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@protocol GuluTableViewRefreshDelegate;

@interface GuluTableView : UITableView<EGORefreshTableHeaderDelegate>
{
    BOOL canRefreshTable;
    
    EGORefreshTableHeaderView *refreshHeaderView;
	BOOL _reloading;
    id <GuluTableViewRefreshDelegate> refreshDelegate;
    
    UIActivityIndicatorView *loadingSpinner;
    
    NSMutableArray *tableArray;
}

@property (nonatomic,retain) UIActivityIndicatorView *loadingSpinner;
@property (nonatomic,assign) id <GuluTableViewRefreshDelegate> refreshDelegate;
@property (nonatomic,readonly) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic,assign) UINavigationController *navigationController;
@property(nonatomic,retain)NSMutableArray *tableArray;

- (id)initWithFrame:(CGRect)frame pullToRefresh:(BOOL)refresh;
- (void)doneLoadingGuluRefreshTableViewData;  // call this function to recovert tableview 
//[table performSelector:@selector(doneLoadingGuluRefreshTableViewData) withObject:nil afterDelay:0.1];

@end

@protocol GuluTableViewRefreshDelegate 
-(void)GuluTableViewRefreshDelegateTrgger :(GuluTableView *)guluTable; // drag down and release will trigger this function  
@end


/*
 
 Notice: if pulling to refreash dosent work, please remeber to copy and paste below code 
 
 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [yourtablename.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];	
 }
 
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [yourtablename.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];	
 }
 
 */
