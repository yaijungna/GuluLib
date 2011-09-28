//
//  GuluTableView.m
//  GULUAPP
//
//  Created by alan on 11/9/15.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluTableView.h"

@implementation GuluTableView

@synthesize refreshDelegate;
@synthesize refreshHeaderView;
@synthesize loadingSpinner;
@synthesize navigationController;
@synthesize tableArray;

- (id)initWithFrame:(CGRect)frame pullToRefresh:(BOOL)refresh
{
    self = [super initWithFrame:frame];
    canRefreshTable=refresh;
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        if(canRefreshTable)
        {
            refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width,self.bounds.size.height)];
            
            refreshHeaderView.delegate = self;
            [self addSubview:refreshHeaderView];
            [refreshHeaderView release];
            [refreshHeaderView refreshLastUpdatedDate];
            
            loadingSpinner=[[UIActivityIndicatorView alloc] init];
            [loadingSpinner setHidesWhenStopped:YES];
            [loadingSpinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
            loadingSpinner.frame=CGRectMake(self.center.x-18,self.center.y-18,36,36);
            [self addSubview:loadingSpinner];
            [loadingSpinner stopAnimating];
            [loadingSpinner release];
        }
    }
    return self;
}


- (void)doneLoadingGuluRefreshTableViewData
{
    if(canRefreshTable){
        _reloading = NO;
        [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    }
}

- (void)dealloc {
    [tableArray release];
    [super dealloc];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
    _reloading = YES;
    [refreshDelegate GuluTableViewRefreshDelegateTrgger:self];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
    return _reloading; 
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];	
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];	
}




@end
