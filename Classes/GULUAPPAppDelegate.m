//
//  GULUAPPAppDelegate.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "GULUAPPAppDelegate.h"
#include "SQLiteInstanceManager.h"

#import "API_URL_GENERAL.h"

#import "ACNetworkManager.h"

#import "TSAlertView.h"

#import <CrashReporter/CrashReporter.h>


@implementation GULUAPPAppDelegate

@synthesize window;
@synthesize rootVC;

@synthesize settings;
@synthesize userMe;
@synthesize temp;
@synthesize locationManager;

@synthesize DeviceToken;
@synthesize gotoLastPageFromPost;
@synthesize hungry;


@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;


////============new add=============
@synthesize  GuluUser; 
@synthesize myLoaction;


//===========


-(void)clearDB
{
	SQLiteInstanceManager *_manager = [SQLiteInstanceManager sharedManager];
	[_manager deleteDatabase];
	[SQLiteInstanceManager sharedManager] ;
}

-(void)sendDeviceToken
{
	NSString *URL= [NSString stringWithFormat:URL_REGISTER_DEVICE_ID];
	NSURL *reqURL = [NSURL URLWithString:URL];
    
    ACLog(@"%@,%@,%@",userMe.username,userMe.uid,DeviceToken);
    
    if(userMe.uid==nil || [userMe.deviceToken isEqualToString:@""] || DeviceToken==nil)
    {
        return;
    }
    
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:reqURL];
	[request setPostValue:userMe.username forKey:@"u"];	
	[request setPostValue:userMe.uid forKey:@"uid"];
    [request setPostValue:userMe.sessionKey forKey:@"session_key"];
	[request setPostValue:DeviceToken forKey:@"token"];
	[request setDidFinishSelector:@selector(registerDone:)];
    
	[request setTimeOutSeconds:30];
	[request setDelegate:self];
	[request startAsynchronous];
}

- (void)registerDone:(ASIFormDataRequest *)request
{
    NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id t = [djsonDeserializer deserialize:data1 error:&derror];
  
    if( t==nil || [t isEqual:[NSNull null]] || [t count]==0 )
	{
		ACLog(@"No Data");
	}

    if([[t objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
    {
        // NSString *errorString =CONNECTION_ERROR_STRING;
        ACLog(@"register device fail!");
        return;
    }
    
    
   if ([[t objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]] ) 
   {
       userMe.deviceToken=DeviceToken;
       [userMe save];
       ACLog(@"register device done!");
    }
    
}


#pragma mark -
#pragma mark load RootViewController

- (void)loadRootVC 
{
	rootVC = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
	rootVC.userMe=userMe;
	[rootVC.view setFrame:CGRectMake(0, 20, 320, 460)];
	[window addSubview:rootVC.view];	
}

- (void)reBoot 
{
	[rootVC.view removeFromSuperview];
	rootVC=nil;
	[self loadRootVC];
}

#pragma mark -
#pragma mark location

-(void)initLoaction
{
	//=================================
	//			Location
	//==================================
	
	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
	locationManager.delegate = self;
	locationManager.distanceFilter= 30;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	[locationManager startUpdatingLocation];
	
	//==================================
	
}

/* this is the same, but needs to be here for url calls to the app. */

-(void)showRootOKAlert:(NSString *)okString
{
    
    TSAlertView* av = [[[TSAlertView alloc] init] autorelease];
	av.title =GLOBAL_OK_STRING;
	av.message = okString;
    //   av.delegate=self;
    [av addButtonWithTitle: GLOBAL_OK_STRING];
	[av show];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager 
    didUpdateToLocation:(CLLocation *)newLocation 
           fromLocation:(CLLocation *)oldLocation 
{	
	if (abs([newLocation.timestamp timeIntervalSinceNow]) > 60.0)
	{
        ACLog(@"[GULUAPPAppDelegate.m] (return) timeInterval>60");
	}
	
	if(newLocation!=nil)
	{
		settings.myLocation=newLocation;
		userMe.myLocation=newLocation;
	}
	else
	{
		if(oldLocation!=nil)
		{
			settings.myLocation=oldLocation;
			userMe.myLocation=oldLocation;
		}
	}
	
	//NSLog(@"[GULUAPPAppDelegate.m] location=%@",userMe.myLocation);
    ACLog(@"location=%@",userMe.myLocation);

	
}

- (void)locationManager:(CLLocationManager *)manager 
       didFailWithError:(NSError *)error 
{
	//NSLog(@"[GULUAPPAppDelegate.m] loaction error=%@",error);
    ACLog(@"loaction error=%@",error);
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ACLog(@"adidFinishLaunchingWithOptions");
    
    NSError *error;
    PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
    ACLog(@"crashReporter object=%@ , hasPendingCrashReport=%d",crashReporter,[crashReporter hasPendingCrashReport]);
    
    
    // Enable the Crash Reporter
    if (![crashReporter enableCrashReporterAndReturnError: &error])
        NSLog(@"Warning: Could not enable crash reporter: %@", error);

    
    //=======================
    //[[SQLiteInstanceManager sharedManager] setDatabaseFilepath:@"database.sqlite"];
	//[self clearDB];
	//NSLog(@"launchOptions = %@", launchOptions) ;

    //=====================
    
	settings=[settingsModel sharedManager];
	userMe=[userMeModel  sharedManager];
	temp=[TempModel sharedManager];
    
	[self initLoaction];	
    [self loadRootVC];
    [self.window makeKeyAndVisible];
      
    if(userMe.deviceToken==nil || [userMe.deviceToken isEqualToString:@""])
    {
        ACLog(@"Registering for remote notifications"); 
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert ];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	ACLog(@"System DeviceToken: %@", deviceToken);
    
    self.DeviceToken = [NSString stringWithFormat:@"%@",deviceToken];
    self.DeviceToken= [[[DeviceToken stringByReplacingOccurrencesOfString:@"<" withString:@""] 
                        stringByReplacingOccurrencesOfString:@">" withString:@""] 
                       stringByReplacingOccurrencesOfString:@" " withString:@""] ;
    
    ACLog(@"get device token OK: %@",DeviceToken);
    
    [ self sendDeviceToken];
    
} 

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	NSLog(@"Error in registration. Error: %@", error); 
 
}

- (void)applicationWillResignActive:(UIApplication *)application {
    ACLog(@"applicationWillResignActive");
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    ACLog(@"EnterBackground");
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
    
    ACLog(@"EnterForeground");
    //[hungry connectToChatServerAgain];   // 8/5 i think i don't need to reconnect again //alan
   
    if(hungry)
    {
        [hungry amihungry];
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    ACLog(@"BecomeActive");
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    ACLog(@"applicationWillTerminate");
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
    
    
    
}




#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
     ACLog(@"applicationDidReceiveMemoryWarning");
    
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if (!url) {  return NO; }
	
    NSString *URLString = [url absoluteString];
	
	// the URL will lok like this http://demo.gd/|activate|4e0403b4794d4019fb0000056550a9fc8e6608a71ae91494a3b81= 5e2f6625b2e016568d8ca2a|
	
	NSArray *url_array = [URLString componentsSeparatedByString:@","];
	ACLog(@"[%@]", url_array) ;
	
	// check for fail condition
	if(url_array.count == 2)	// make sure we have three. the guluapp part, the command and the activation key
	{
		NSString *command = [url_array objectAtIndex:1];
		if ([ command isEqualToString:@"fail"])
		{
			
			[self showRootOKAlert:NSLocalizedString(@"already_activated",@"")];

		}
	}
	if(url_array.count == 9)	// make sure we have three. the guluapp part, the command and the activation key
	{
		/***
		 "guluapp://",
		 session,
		 8301d47310d057c7c71747297f777f6a,
		 username,
		 redbugredbug,
		 uid,
		 4e083b71794d4014cb000000
		 *******/
		NSString *session = [url_array objectAtIndex:1];
		NSString *session_string = [url_array objectAtIndex:2];
		
		// NSString *username = [url_array objectAtIndex:3];
		NSString *username_string = [url_array objectAtIndex:4];
		
		// NSString *uid = [url_array objectAtIndex:5];
		NSString *uid_string = [url_array objectAtIndex:6];
		NSString *user_photo_url = [url_array objectAtIndex:8];
		

		if ([ session isEqualToString:@"session"])
		{
			userMe = [userMeModel sharedManager] ;
			userMe.uid = uid_string ;
			userMe.sessionKey = session_string ;
			userMe.username = username_string ;
			userMe.userPhotoUrl = user_photo_url ;
			[userMe save] ;
            [self sendDeviceToken];
			[self showRootOKAlert:NSLocalizedString(@"welcome_to_gulu",@"")];
			[self reBoot] ;

			return YES;
		}
	}
	
	
    return NO ;
}

#pragma mark - Core Data stack

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    
    __managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return __managedObjectModel;
    
/*    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"coredatatest" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
 */
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"coredatatest.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



- (void)dealloc {
	[settings release];
	[userMe release];
	[temp release];
	[locationManager release];
	[rootVC release];
    [window release];
    [DeviceToken release];
    
    [hungry release];

    
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    
    
    ////============new add=============
    
    [GuluUser release];
    [myLoaction release];
    
    
    [super dealloc];
}



@end
