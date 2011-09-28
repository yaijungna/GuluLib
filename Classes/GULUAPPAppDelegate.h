//
//  GULUAPPAppDelegate.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import "SQLiteInstanceManager.h"
#import "RootViewController.h"
#import "settingsModel.h"
#import "userMeModel.h"
#import "TempModel.h"
#import "ASIFormDataRequest.h"
#import "ACNetworkManager.h"
#import "API_URL_USER.h"
#import "ACSocket.h"
#import "hungryModel.h"
#import "debugDefined.h"

#import "GuluUserModel.h"  //ACC

#import <CoreData/CoreData.h>


@interface GULUAPPAppDelegate : NSObject <UIApplicationDelegate,CLLocationManagerDelegate> {
    UIWindow *window;
	RootViewController *rootVC;
	
	CLLocationManager *locationManager;
	settingsModel *settings;
	userMeModel *userMe;
	TempModel *temp;
	
	BOOL gotoLastPageFromPost;  //  let user can go back to last  page from post
    
    NSString *DeviceToken;
    hungryModel *hungry;
    
    ////============new add=============
    
    GuluUserModel *GuluUser; 
    CLLocation *myLoaction; 
    
    //=============================================
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RootViewController *rootVC;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) settingsModel *settings;
@property (nonatomic, retain) userMeModel *userMe;
@property (nonatomic, retain) TempModel *temp;

@property (nonatomic, retain)  NSString *DeviceToken;

@property (nonatomic) BOOL gotoLastPageFromPost;

@property (nonatomic, retain)  hungryModel *hungry;



   ////============new add=============
@property (nonatomic, retain) GuluUserModel *GuluUser; 
@property (nonatomic, retain) CLLocation *myLoaction;
//=============================================


-(void)clearDB;
- (void)reBoot;
- (void)sendDeviceToken;

//==========================core data=============================

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end








