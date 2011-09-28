//
//  UVWelcomeViewController.m
//  UserVoice
//
//  Created by UserVoice on 12/15/09.
//  Copyright 2009 UserVoice Inc. All rights reserved.
//

#import "UVRootViewController.h"
#import "UVClientConfig.h"
#import "UVToken.h"
#import "UVSession.h"
#import "UVUser.h"
#import "UVWelcomeViewController.h"
#import "UVSuggestionListViewController.h"
#import "UVNetworkUtils.h"
#import "NSError+UVExtras.h"

@implementation UVRootViewController

@synthesize ssoToken;
@synthesize email, displayName, guid;

- (void)setupErrorAlertViewDelegate
{
	errorAlertView.delegate = self;
}

- (id)initWithSsoToken:(NSString *)aToken {
	if (self = [super init]) {
		self.ssoToken = aToken;
	}
	return self;
}

- (id)initWithEmail:(NSString *)anEmail andGUID:(NSString *)aGUID andName:(NSString *)aDisplayName {
	if (self = [super init]) {
		self.email = anEmail;
		self.guid = aGUID;
		self.displayName = aDisplayName;
	}
	return self;	
}

- (void)didReceiveError:(NSError *)error {
	if ([error isAuthError]) {
		if ([UVToken exists]) {
			[[UVSession currentSession].currentToken remove];
			[UVToken getRequestTokenWithDelegate:self];
			
		} else {
			[self showErrorAlertViewWithMessage:@"This application didn't configure UserVoice properly"];
		}
	} else {
		[super didReceiveError:error];
	}
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	[self dismissUserVoice];
}

- (void)pushWelcomeView {
	// Note: We used to bring the user straight to the suggestions list view, while
	//       allowing them to pop back up to the forum list. Commenting this code
	//       out but leaving it around in case we decide to revert back to this approach.
	// We're swapping the current view controller out for two new ones:
	// A forum list and a suggestion list for the default forum. This way,
	// the user will first see the suggestion list, but will be able to use
	// the Back button to go up to the forum list.
	UVWelcomeViewController *forumsView = [[UVWelcomeViewController alloc] init];
	//UVSuggestionListViewController *suggestionsView = [[UVSuggestionListViewController alloc]
	//												   initWithForum:[UVSession currentSession].clientConfig.defaultForum];
	//NSArray *viewControllers = [NSArray arrayWithObjects:forumsView, suggestionsView, nil];
	//[self.navigationController setViewControllers:viewControllers animated:YES];
	
	[self.navigationController pushViewController:forumsView animated:YES];
	[forumsView release];
}


- (void)didRetrieveRequestToken:(UVToken *)token {
	// should be storing all tokens and checking on type
	//	token.type = @"request";
	//	[token persist];
	[UVSession currentSession].currentToken = token;
	
	// check if we have a sso token and if so exchange it for an access token and user
	if (self.ssoToken != nil) {
		[UVUser findOrCreateWithSsoToken:self.ssoToken delegate:self];
		
	} else if (self.email != nil) {
		[UVUser findOrCreateWithGUID:self.guid andEmail:self.email andName:self.displayName andDelegate:self];
		
	} else {
		[UVClientConfig getWithDelegate:self];
	}
}

- (void)didCreateUser:(UVUser *)theUser {
	// set the current user
	[UVSession currentSession].user = theUser;
	
	// token should have been loaded by ResponseDelegate
	[[UVSession currentSession].currentToken persist];
	
	[UVClientConfig getWithDelegate:self];
}

- (void)didRetrieveClientConfig:(UVClientConfig *)clientConfig {
	// if no token aren't waiting on user so push main view
	// if we have a token, then we are waiting on the user model
	if (![UVToken exists] || [UVSession currentSession].user) {
		[self hideActivityIndicator];
		[self pushWelcomeView];
	}
}

- (void)didRetrieveCurrentUser:(UVUser *)theUser {
	[UVSession currentSession].user = theUser;
	if ([UVSession currentSession].clientConfig) {
		[self hideActivityIndicator];
		[self pushWelcomeView];
	}
}

#pragma mark ===== Basic View Methods =====

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	// Hide the nav bar
	self.navigationController.navigationBarHidden = YES;

	[super loadView];
	
	CGRect frame = [self contentFrameWithNavBar:NO];
	UIView *contentView = [[UIView alloc] initWithFrame:frame];
	
	UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uv_splash.png"]];
	[contentView addSubview:image];
	[image release];
	
	UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activity.center = CGPointMake(frame.size.width / 2, (frame.size.height / 2) - 20);
	[contentView addSubview:activity];
	[activity startAnimating];
	[activity release];
	
	self.view = contentView;
	[contentView release];
}

- (void)viewWillAppear:(BOOL)animated {
	NSLog(@"View will appear (RootView)");
	[super viewWillAppear:animated];
	
	if (![UVNetworkUtils hasInternetAccess]) {
		UIImageView *serverErrorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uv_error_connection.png"]];
		self.navigationController.navigationBarHidden = NO;
		serverErrorImage.frame = self.view.frame;
		[self.view addSubview:serverErrorImage];
		[serverErrorImage release];
		
	} else if (![UVToken exists]) {
		// no access token
		NSLog(@"No access token");
		[UVToken getRequestTokenWithDelegate:self];
		
	} else if (![[UVSession currentSession] clientConfig]) {
		// no client config
		NSLog(@"No client");
		[UVSession currentSession].currentToken = [[UVToken alloc]initWithExisting];
		// get config and current user
		[UVClientConfig getWithDelegate:self];
		[UVUser retrieveCurrentUser:self];

	} else if (![UVSession currentSession].user) {
		NSLog(@"No user");
		// just get user
		[UVSession currentSession].currentToken = [[UVToken alloc]initWithExisting];
		[UVUser retrieveCurrentUser:self];
		
	} else {
		NSLog(@"Pushing welcome");
		// Re-enable the navigation bar
		self.navigationController.navigationBarHidden = NO;

		// We already have a client config, because the user already logged in before during
		// this session. Skip straight to the welcome view.
		[self pushWelcomeView];
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	// Re-enable the navigation bar
	self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
