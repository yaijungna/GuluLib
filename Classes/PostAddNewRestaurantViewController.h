//
//  PostAddNewRestaurantViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/10.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "UIViewControllerAddtion.h"

#import "addPhoneAnnotation.h"
#import "addRestaurantAnnotaionView.h"

#import "postModel.h"



@interface PostAddNewRestaurantViewController : UIViewController <MKMapViewDelegate,UITextFieldDelegate>{
	MKMapView *mapView;
	NSString  *name;
	UITextField *tempTextField;
    addPhoneAnnotation *anno;
	
	TopMenuBarView *topView;
	BottomMenuBarView *bottomView;
	loadingSpinnerAndMessageView *spinView;
    
    NSInteger numberOfpageToGoBack;

}

@property (nonatomic ,retain) NSString  *name;
@property (nonatomic)  NSInteger numberOfpageToGoBack;

@end
