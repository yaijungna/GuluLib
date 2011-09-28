//
//  GuluAnnotation.h
//  GULUAPP
//
//  Created by alan on 11/9/27.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GuluAnnotation : NSObject<MKAnnotation> {
	
	CLLocationCoordinate2D theCoordinate;
	NSString *title;
	NSString *subtitle;
}

@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
