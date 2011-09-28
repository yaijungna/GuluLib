//
//  addPhoneAnnotation.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/10.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface addPhoneAnnotation : MKPlacemark<MKAnnotation>
{
	CLLocationCoordinate2D coordinate_;
	NSString *title_;
	NSString *subtitle_;
}

// Re-declare MKAnnotation's readonly property 'coordinate' to readwrite. 
@property (nonatomic, readwrite, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end


