//
//  userMeModel.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/1.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "userMeModel.h"
#import "debugDefined.h"

@implementation userMeModel


static id sharedMyManager_userme = nil;

@synthesize myLocation,username,email,password,userPicture,userDictionary,uid;
@synthesize sessionKey;
@synthesize userPhotoUrl;
@synthesize UUID;
@synthesize deviceToken;

NSString *kUseridKey        = @"useridKey";
NSString *kUsernameKey      = @"usernameKey";
NSString *kEmailKey         = @"emailKey";
NSString *kSessionKey       = @"userSessionKey";
NSString *kUserDictKey      = @"userDictionary";
NSString *kUserPhotoURL     = @"userPhotoURL";
NSString *kUserUUIDKey      = @"UserUUIDKey";
NSString *kUserDeviceTokenKey      = @"UserDeviceTokenKey";

+ (id)sharedManager {
	@synchronized(self){
        if(sharedMyManager_userme == nil){
            sharedMyManager_userme = [[super alloc] init];
		}
    }
    return sharedMyManager_userme;
}

/**
 @brief init the object to all nil. If everthing is nil, then you are logged out.
 */
- (id)init {
	
    self=[super init];
	if(self)
	{
		imageLoader=[[ACImageLoader alloc] init];
		imageLoader.delegate=self;
	}
	self.username=nil;
	self.password=nil;
	self.email=nil;
	self.uid=nil;
	self.userPicture=nil;
	self.userDictionary=nil;
	self.sessionKey=nil;
    //self.UUID=@"98027c33-431a-4632-a5bb-f7502d1e3676";
    self.UUID=nil;
    self.deviceToken=nil;
	
	// load user prefs
	// we get the settigns and set them up if not there
	NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
	NSString *user_id = [userPreferences stringForKey:kUseridKey];
	
	// previously logged in
	if (user_id != nil ) {
		NSString *user_email	= [userPreferences stringForKey:kEmailKey];
		NSString *session_id	= [userPreferences stringForKey:kSessionKey];
		NSString *user_name		= [userPreferences stringForKey:kUsernameKey];
		NSData *user_data       = [userPreferences objectForKey:kUserDictKey];
		NSString *user_photo_url = [userPreferences stringForKey:kUserPhotoURL];
        NSString *user_UUID = [userPreferences stringForKey:kUserUUIDKey];
        NSString *user_DeviceToken = [userPreferences stringForKey:kUserDeviceTokenKey];
		
        self.username=user_name;
		self.email=user_email;
		self.uid=user_id;
		self.sessionKey=session_id;	
        self.UUID=user_UUID;
        self.deviceToken=user_DeviceToken;
        
        if([user_data isKindOfClass:[NSData class]])
        {
            self.userDictionary= [NSKeyedUnarchiver unarchiveObjectWithData:user_data];
        }
        
        if([user_data isKindOfClass:[NSDictionary class]])
        {
            
        }
		
        self.userPhotoUrl=user_photo_url;
        
    }
    
    //  NSLog(@"uid=%@",self.uid);
    // NSLog(@"dict=%@",self.userDictionary);
    
    ACLog(@"uid=%@",self.uid);
    ACLog(@"session=%@",self.sessionKey);
    ACLog(@"deviceToken=%@",self.deviceToken);
    ACLog(@"dict=%@",self.userDictionary);
	
	return self;
}

- (void) dealloc
{
	[myLocation release];myLocation=nil;
	[username release];username=nil;
	[password release];password=nil;
	[email release];email=nil;
	[uid release];uid=nil;
	[userPicture release];userPicture=nil;
	[userDictionary release];userDictionary=nil;
	[sessionKey release];sessionKey=nil;
	
	[imageLoader release];imageLoader=nil;
    [UUID release];UUID=nil;
    [deviceToken release];deviceToken=nil;
	[super dealloc];
}

#pragma mark -

-(void) save
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.userDictionary];
    
    
	NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
	[userPreferences setObject:self.username forKey:kUsernameKey];
	[userPreferences setObject:self.email	 forKey:kEmailKey];
	[userPreferences setObject:self.sessionKey forKey:kSessionKey];
	[userPreferences setObject:self.uid  forKey:kUseridKey];
    [userPreferences setObject:self.UUID  forKey:kUserUUIDKey];
	[userPreferences setObject:data  forKey:kUserDictKey];
	[userPreferences setObject:self.userPhotoUrl  forKey:kUserPhotoURL];
    [userPreferences setObject:self.deviceToken  forKey:kUserDeviceTokenKey];
   	
	[userPreferences synchronize] ;
    
    //NSLog(@"uid=%@",self.uid);
    //NSLog(@"dict=%@",self.userDictionary);
    
    ACLog(@"uid=%@",self.uid);
    ACLog(@"dict=%@",self.userDictionary);
    
}

- (void) logout
{
    //	self.myLocation=nil;
	self.username=nil;
	self.password=nil;
	self.email=nil;
	self.uid=nil;
	self.userPicture=nil;
	self.userDictionary=nil;
	self.sessionKey=nil;
	self.userPhotoUrl=nil;
    self.UUID=nil;
    self.deviceToken=nil;
    
	[self save];		// save back to db
	//[SQLitePersistentObject clearCache];
	
	// [userMeModel removeObjectForLogOut];
}

- (void) loadUserImage
{
	
	NSString *url=[[userDictionary objectForKey:@"photo"] objectForKey:@"image_medium"];
	if(url)
	{
		imageLoader.URLStr=url;
		[imageLoader startDownload];
	}
}

#pragma mark -

/*  Good try, but not stable.
 
 /// @todo arghhh !!! you are setting the pointer to nil resulting in a memory leak.
 + (id) islogIn
 {
 NSArray *array=[userMeModel allObjects];
 
 // this should not be compared to 0, it can come back as a random number if not defined. 
 // for now compare to one, but should be re-written for stability.
 // as you use the app, the user objects keep growings even though you are setting them to nil.
 // if([array count]!=0)	
 NSLog(@"[array count] %d", [array count]) ;
 if([array count] >= 1)	
 {
 userMeModel *temp=[array objectAtIndex:0];
 userMeModel *temp2=[array objectAtIndex:0];
 
 // this thing is returning nothing as being logged in. Inly return if something
 if ( [temp.uid length] > 0) {	// 0x0
 return temp;
 }
 
 }
 return nil;
 }
 
 + (void) removeObjectForLogOut 
 {
 NSArray *array=[userMeModel allObjects];
 
 for (userMeModel *temp in array) 
 {
 [temp deleteObject];
 }
 }
 
 *************************************/


/*****
 How to use log out
 
 appDelegate.userMe=nil;
 [userMeModel removeObjectForLogOut];
 
 *******/


#pragma mark ACImageDidLoad Delegate and Function Methods

- (void)ACImageDidLoad:(ACImageLoader *)imageloader
{
	if (imageloader.image != nil)
	{
		self.userPicture=imageloader.image;
		[self save];
	}	 
}




@end
