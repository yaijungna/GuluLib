//
//  GuluMapViewController.h
//  GULUAPP
//
//  Created by alan on 11/9/27.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "GuluPlaceModel.h"
#import "GuluAnnotation.h"


@interface GuluMapViewController : UIViewController<MKMapViewDelegate> {

    GuluPlaceModel *place;
    MKMapView *mapView;
}

@property (nonatomic , retain)  GuluPlaceModel *place;

@end
