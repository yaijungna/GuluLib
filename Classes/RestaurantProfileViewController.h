//
//  RestaurantProfileViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/16.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_moreView.h"
#import "AppStrings_search.h"
#import "ACSegmentController.h"
#import "RestaurantProfileView.h"
#import "reviewProfileViewController.h"
#import "dishProfileViewController.h"
#import "EventViewController.h"


#import "GuluAPIManager.h"
#import "GuluTableView.h"
#import "GuluTableViewCell_3Images.h"
#import "UIImageView+WebCache.h"
#import "UIButton+Custom.h"
#import "GuluUtility.h"

@interface RestaurantProfileViewController : UIViewController <GuluAPIAccessManagerDelegate,GuluTableViewRefreshDelegate,ACSegmentControllerDelegate,UITableViewDelegate ,UITableViewDataSource> {
	TopMenuBarView *topView;
	BottomMenuBarView *bottomView;
	loadingSpinnerAndMessageView *spinView;
	GuluTableView *table;
	ACSegmentController *segment;
	RestaurantProfileView *restaurantView;
	
	IBOutlet UIView *myView;
	
	NSMutableArray *photoArray;
	NSMutableArray *dishArray;
	NSMutableArray *reviewArray;
	NSMutableArray *tableArray;

    GuluPlaceModel *place;
    GuluHttpRequest  *reviewRequest;
    GuluHttpRequest  *dishRequest;
	
}

- (void)getResturantDish;
- (void)getResturantReview;

- (void)mapAction ;
- (void)inviteAction;

@property (nonatomic,retain)GuluPlaceModel *place;
@property (nonatomic,retain)GuluHttpRequest  *reviewRequest;
@property (nonatomic,retain)GuluHttpRequest  *dishRequest;

@property (nonatomic,retain)NSMutableArray *dishArray;
@property (nonatomic,retain)NSMutableArray *photoArray;
@property (nonatomic,retain)NSMutableArray *reviewArray;



@end
