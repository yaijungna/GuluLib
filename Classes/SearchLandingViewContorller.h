//
//  SearchLandingViewContorller.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/7.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "ACSegmentController.h"
#import "AppStrings_search.h"
#import "EventViewController.h"

#import "GuluAPIManager.h"
#import "GuluUtility.h"
#import "GuluBasicViewController.h"
#import "UITextField+Custom.h"

#import "searchPlaceTableView.h"
#import "searchDishTableView.h"
#import "searchMissionTable.h"




typedef enum {
	RestaurantTableType,
	DishTableType,
	MissionType
} TableType;


@interface SearchLandingViewContorller : GuluBasicViewController<GuluTableViewRefreshDelegate,ACSegmentControllerDelegate,UITextFieldDelegate,GuluAPIAccessManagerDelegate> {
	
	ACSegmentController *segment;
	UITextField *searchTextField;
	UIButton *searchBtn;
    
    searchPlaceTableView *placeTable;
    searchDishTableView  *dishTable;
    searchMissionTable *missionTable;

	NSMutableArray *restaurantArray;
	NSMutableArray *dishArray;
	NSMutableArray *missionArray;
	

    GuluHttpRequest *placeSearchRequest;
    GuluHttpRequest *dishSearchRequest;
    GuluHttpRequest *missionSearchRequest;
    GuluHttpRequest *todoRequest;
    GuluHttpRequest *favoriteRequest;
}

@property (nonatomic ,retain) NSMutableArray *restaurantArray;
@property (nonatomic ,retain) NSMutableArray *dishArray;
@property (nonatomic ,retain) NSMutableArray *missionArray;

@property (nonatomic ,retain) GuluHttpRequest *placeSearchRequest;
@property (nonatomic ,retain) GuluHttpRequest *dishSearchRequest;
@property (nonatomic ,retain) GuluHttpRequest *missionSearchRequest;
@property (nonatomic ,retain) GuluHttpRequest *todoRequest;
@property (nonatomic ,retain) GuluHttpRequest *favoriteRequest;

- (void)search;
- (void)searchPlace ;
- (void)searchDish ;
- (void)searchMission ;





@end
