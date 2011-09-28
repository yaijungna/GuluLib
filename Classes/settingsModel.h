//
//  settingsModel.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/27.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface settingsModel : NSObject {
	CLLocation *myLocation;
}

@property (nonatomic,retain)CLLocation *myLocation;

+ (id)sharedManager;

@end
