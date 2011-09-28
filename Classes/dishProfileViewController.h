//
//  dishProfileViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/17.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "UIViewControllerAddtion_moreView.h"
#import "AppStrings_search.h"
#import "ACSegmentController.h"
#import "dishProfileView.h"
#import "reviewProfileViewController.h"
#import "dishProfileViewController.h"

#import "GuluAPIManager.h"
#import "GuluTableView.h"
#import "GuluTableViewCell_3Images.h"
#import "UIImageView+WebCache.h"
#import "GuluUtility.h"


@interface dishProfileViewController : UIViewController  <GuluTableViewRefreshDelegate,GuluAPIAccessManagerDelegate,UITableViewDelegate ,UITableViewDataSource>{
	TopMenuBarView *topView;
	BottomMenuBarView *bottomView;
	loadingSpinnerAndMessageView *spinView;
	GuluTableView *table;
	dishProfileView *restaurantView;

    NSMutableArray *tableArray;
	IBOutlet UIView *myView;

	NSMutableArray *dishPhotoArray;

    
    GuluDishModel *dish;
    GuluHttpRequest *dishPhotoRequest;
}

- (void)getDishPhoto;

@property (nonatomic,retain)GuluDishModel *dish;;
@property (nonatomic,retain)NSMutableArray *dishPhotoArray;
@property (nonatomic,retain)GuluHttpRequest *dishPhotoRequest;



@end
