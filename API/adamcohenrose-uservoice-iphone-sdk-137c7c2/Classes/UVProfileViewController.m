//
//  UVProfileViewController.m
//  UserVoice
//
//  Created by UserVoice on 11/12/09.
//  Copyright 2009 UserVoice Inc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UVProfileViewController.h"
#import "UVUser.h"
#import "UVClientConfig.h"
#import "UVSession.h"
#import "UVSuggestionDetailsViewController.h"
#import "UVProfileEditViewController.h"
#import "UVProfileIdeaListViewController.h"
#import "UVStyleSheet.h"
#import "UVUserChickletView.h"

#define UV_PROFILE_TAG_NAME 1
#define UV_PROFILE_TAG_EMAIL 2
#define UV_PROFILE_TAG_CHICKLET 3
#define UV_PROFILE_TAG_MEMBER_SINCE 4

#define UV_PROFILE_ROW_SUPPORTING_IDEAS 0
#define UV_PROFILE_ROW_CREATED_IDEAS 1
#define UV_PROFILE_ROW_EDIT 2


@implementation UVProfileViewController

@synthesize userId;
@synthesize userName;
@synthesize user;
@synthesize avatarUrl;
@synthesize message;

- (id)initWithUserId:(NSInteger)theUserId name:(NSString *)theUserName {
	return [self initWithUserId:theUserId name:theUserName avatarUrl:nil];
}

- (id)initWithUserId:(NSInteger)theUserId name:(NSString *)theUserName avatarUrl:(NSString *)theAvatarUrl {
	if (self = [super init]) {
		self.userId = theUserId;
		self.userName = theUserName;
		self.avatarUrl = theAvatarUrl;
	}
	return self;
}

- (id)initWithUVUser:(UVUser *)theUser {
	if (self = [super init]) {
		self.user = theUser;
		self.userId = theUser.userId;
		self.userName = theUser.displayName;
		self.avatarUrl = theUser.avatarUrl;
	}
	return self;
}

// Determines whether we're viewing the logged-in user's profile
- (BOOL)isSelf {
	return self.userId == [UVSession currentSession].user.userId;
}

- (NSString *)backButtonTitle {
	return [self isSelf] ? @"My Profile" : self.userName;
}

- (NSString *)memberSince {
	static NSDateFormatter* dateFormatter = nil;
	if (!dateFormatter) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"'Member since 'MMM yyyy"];
	}
	return [dateFormatter stringFromDate:self.user.createdAt];
}

- (UIView *)createHeaderView {
	UIView *header = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 84)] autorelease];
	header.backgroundColor = [UIColor clearColor];
	
	// Name
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 240, 16)];
	label.tag = UV_PROFILE_TAG_NAME;
	label.text = self.userName ? self.userName : @"Anonymous";
	label.font = [UIFont boldSystemFontOfSize:16];
	label.textColor = [UVStyleSheet veryDarkGrayColor];
	label.backgroundColor = [UIColor clearColor];
	[header addSubview:label];
	[label release];
	
	CGFloat prevY = 26.0;
	
	if ([self isSelf]) {
		// Email
		label = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 240, 14)];
		label.tag = UV_PROFILE_TAG_EMAIL;
		label.text = self.user.email;
		label.font = [UIFont systemFontOfSize:14];
		label.textColor = [UVStyleSheet veryDarkGrayColor];
		label.backgroundColor = [UIColor clearColor];
		[header addSubview:label];
		[label release];
		
		prevY = 44.0;
	}

	// Date
	label = [[UILabel alloc] initWithFrame:CGRectMake(70, prevY + 4, 240, 11)];
	label.tag = UV_PROFILE_TAG_MEMBER_SINCE;
	label.text = self.user ? [self memberSince] : @"";
	label.font = [UIFont boldSystemFontOfSize:11];
	label.textColor = [UIColor darkGrayColor];
	label.backgroundColor = [UIColor clearColor];
	[header addSubview:label];
	[label release];

	// Avatar
	NSInteger karma = self.user ? self.user.karmaScore : 0;
	UVUserChickletView *chicklet = [UVUserChickletView userChickletViewWithOrigin:CGPointMake(10, 10)
																	   controller:self
																			style:UVUserChickletStyleDetail
																		   userId:self.userId
																			 name:self.userName
																		avatarUrl:self.avatarUrl
																			admin:NO
																	   karmaScore:karma];
	chicklet.tag = UV_PROFILE_TAG_CHICKLET;
	[chicklet enableButton:NO];
	[header addSubview:chicklet];

	return header;
}

- (void)updateHeaderView {
	UIView *header = self.tableView.tableHeaderView;

	// Name
	UILabel *label = (UILabel *)[header viewWithTag:UV_PROFILE_TAG_NAME];
	label.text = self.userName ? self.userName : @"Anonymous";

	// Email
	label = (UILabel *)[header viewWithTag:UV_PROFILE_TAG_EMAIL];
	label.text = self.user.email;
	
	// Date
	label = (UILabel *)[header viewWithTag:UV_PROFILE_TAG_MEMBER_SINCE];
	label.text = [self memberSince];

	// User Chicklet
	UVUserChickletView *chicklet = (UVUserChickletView *)[header viewWithTag:UV_PROFILE_TAG_CHICKLET];
	[chicklet updateWithAvatarUrl:self.avatarUrl karmaScore:self.user.karmaScore];
}

- (void)didRetrieveUser:(UVUser *)theUser {
	self.user = theUser;
	self.userName = theUser.displayName;
	self.userId = theUser.userId;
	self.avatarUrl = theUser.avatarUrl;
	
	[self updateHeaderView];
	[self.tableView reloadData];
	[self hideActivityIndicator];
}

- (void)editButtonTapped {
	UVProfileEditViewController *next = [[UVProfileEditViewController alloc] init];
	[self.navigationController pushViewController:next animated:YES];
	[next release];
}

#pragma mark ===== table cells =====

- (void)customizeCellForProfile:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	NSString *text = @"";
	switch (indexPath.row) {
		case UV_PROFILE_ROW_SUPPORTING_IDEAS: {
			NSInteger count = self.user.supportedSuggestionsCount;
			text = [NSString stringWithFormat:@"Supporting %d %@", count, count == 1 ? @"idea" : @"ideas"];
			if (count == 0) {
				cell.accessoryType = UITableViewCellAccessoryNone;
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
			}
			break;
		}
		case UV_PROFILE_ROW_CREATED_IDEAS: {
			NSInteger count = self.user.createdSuggestionsCount;
			text = [NSString stringWithFormat:@"Created %d %@", count, count == 1 ? @"idea" : @"ideas"];
			if (count == 0) {
				cell.accessoryType = UITableViewCellAccessoryNone;
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
			}
			break;
		}
		case UV_PROFILE_ROW_EDIT:
			text = @"Edit my profile";
			break;
		default:
			break;
	}
	cell.textLabel.text = text;
}

#pragma mark ===== UITableViewDataSource Methods =====

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [self createCellForIdentifier:@"Profile"
							   tableView:theTableView
							   indexPath:indexPath
								   style:UITableViewCellStyleDefault
							  selectable:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self isSelf] ? 3 : 2;
}

#pragma mark ===== UITableViewDelegate Methods =====

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[theTableView deselectRowAtIndexPath:indexPath animated:YES];

	UIViewController *next = nil;
	
	switch (indexPath.row) {
		case UV_PROFILE_ROW_SUPPORTING_IDEAS:
			if (self.user.supportedSuggestionsCount > 0) {
				next = [[UVProfileIdeaListViewController alloc] initWithUVUser:self.user 
																	  andTitle:@"Ideas Supported"
																showingCreated:NO];
			}
			break;
		case UV_PROFILE_ROW_CREATED_IDEAS:
			if (self.user.createdSuggestionsCount > 0) {
				next = [[UVProfileIdeaListViewController alloc] initWithUVUser:self.user 
																	  andTitle:@"Ideas Created"
																showingCreated:YES];
			}
			break;
		case UV_PROFILE_ROW_EDIT:
			next = [UVProfileEditViewController alloc];
			break;
		default:
			break;
	}
	
	if (next) {
		[self.navigationController pushViewController:next animated:YES];
		[next release];
	}
}

#pragma mark ===== Basic View Methods =====

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	
	self.navigationItem.title = [self isSelf] ? @"My Profile" : @"User Profile";

	CGRect frame = [self contentFrame];
	UIView *contentView = [[UIView alloc] initWithFrame:frame];

	UITableView *theTableView = [[UITableView alloc] initWithFrame:contentView.bounds style:UITableViewStyleGrouped];
	theTableView.dataSource = self;
	theTableView.delegate = self;
	theTableView.backgroundColor = [UIColor clearColor];
	
	theTableView.tableHeaderView = [self createHeaderView];
	
	[contentView addSubview:theTableView];
	self.tableView = theTableView;
	[theTableView release];
	
	self.view = contentView;
	[contentView release];
	
	[self addGradientBackground];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
		
	if (!self.user) {	
		if ([self isSelf]) {
			self.user = [UVSession currentSession].user;
			self.userName = self.user.displayName;
			self.avatarUrl = self.user.avatarUrl;
			[self updateHeaderView];
			
		} else {
			[self showActivityIndicator];
			[UVUser getWithUserId:self.userId delegate:self];
		}		
	} else {
		[self.tableView reloadData];
		[self updateHeaderView];
	}
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.tableView = nil;
}


- (void)dealloc {
	self.user = nil;
	self.userName = nil;
	self.avatarUrl = nil;
	self.tableView = nil;
	
    [super dealloc];
}

@end