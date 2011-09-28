//
//  userModel.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
//#import "SQLitePersistentObject.h"

@interface userModel : NSObject
{
	CLLocation *myLocation;
	NSString *username;
	NSString *email;
	NSString *uid;
	UIImage  *userPicture;
	NSDictionary *userDictionary;
}

@property(nonatomic,retain) CLLocation *myLocation;
@property(nonatomic,retain) NSString *username;
@property(nonatomic,retain) NSString *email;
@property(nonatomic,retain) NSString *uid;
@property(nonatomic,retain) UIImage  *userPicture;
@property(nonatomic,retain) NSDictionary *userDictionary;



@end
