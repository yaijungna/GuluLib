//
//  GuluPlaceListTableView.h
//  GULUAPP
//
//  Created by alan on 11/9/22.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "GuluTableViewCell_Image_Twoline.h"
#import "UIImageView+WebCache.h"
#import "GuluTableView.h"
#import "GuluPlaceModel.h"
#import "UILabel+Custom.h"
#import "GuluUtility.h"

@interface GuluPlaceListTableView  : GuluTableView <UITableViewDelegate , UITableViewDataSource>
{
    CLLocation *userLocation;
    
}

@property(nonatomic,retain)CLLocation *userLocation;

@end
