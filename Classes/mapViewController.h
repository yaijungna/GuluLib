//
//  mapViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/15.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UIViewControllerAddtion.h"
#import "mapAnnotation.h"
#import "GuluPlaceModel.h"

@interface mapViewController : UIViewController<MKMapViewDelegate> {
	GuluPlaceModel *place;
	
	IBOutlet MKMapView *mapView;
	
	TopMenuBarView *topView;
	BottomMenuBarView *bottomView;

}
@property (nonatomic,retain) GuluPlaceModel *place;

@end
