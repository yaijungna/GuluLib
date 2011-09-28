//
//  mapAnnotation.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/15.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <MapKit/MapKit.h>


@interface mapAnnotation : NSObject<MKAnnotation> {
	
	CLLocationCoordinate2D theCoordinate;
	NSString *title;
	NSString *subtitle;
}

@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
