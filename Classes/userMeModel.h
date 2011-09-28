//
//  userMeModel.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/1.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
//#import "SQLitePersistentObject.h"
#import "ACImageLoader.h"

// @interface userMeModel : SQLitePersistentObject<ACImageDownloaderDelegate>  {
// no longer a persistant object, reads from setting ( userDefaults )

@interface userMeModel : NSObject<ACImageDownloaderDelegate> {
	CLLocation *myLocation;
	NSString *username;
	NSString *email;
	NSString *password;
	NSString *uid;
	UIImage  *userPicture;
	NSDictionary *userDictionary;
	NSString *sessionKey;
	NSString *userPhotoUrl;
    NSString *UUID;
    NSString *deviceToken;
	
	ACImageLoader *imageLoader;
}

@property(nonatomic,retain) CLLocation *myLocation;
@property(nonatomic,retain) NSString *username;
@property(nonatomic,retain) NSString *email;
@property(nonatomic,retain) NSString *password;
@property(nonatomic,retain) NSString *uid;
@property(nonatomic,retain) UIImage  *userPicture;
@property(nonatomic,retain) NSDictionary *userDictionary;
@property(nonatomic,retain) NSString *sessionKey;
@property(nonatomic,retain) NSString *userPhotoUrl;
@property(nonatomic,retain) NSString *UUID;
@property(nonatomic,retain) NSString *deviceToken;

- (void) logout;
- (void) save;
- (void) loadUserImage;

+ (id) sharedManager;


@end
