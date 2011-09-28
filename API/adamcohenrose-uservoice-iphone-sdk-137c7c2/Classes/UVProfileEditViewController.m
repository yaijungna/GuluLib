//
//  UVProfileEditViewController.m
//  UserVoice
//
//  Created by Scott Rutherford on 13/05/2010.
//  Copyright 2010 UserVoice Inc. All rights reserved.
//

#import "UVProfileEditViewController.h"
#import "UVStyleSheet.h"
#import "UVSession.h"
#import "UVToken.h"
#import "UVUser.h"
#import "UVClientConfig.h"
#import "UVUserAvatarView.h"

#define UV_PROFILE_SECTION_ICON 0
#define UV_PROFILE_SECTION_DETAILS 1
#define UV_PROFILE_SECTION_UPDATE 2
#define UV_PROFILE_SECTION_LOGOUT 3

#define UV_PROFILE_TAG_NAME 0
#define UV_PROFILE_TAG_AVATAR 1

@implementation UVProfileEditViewController

@synthesize name;
@synthesize email;
@synthesize nameField;
@synthesize emailField;
@synthesize user;

- (void)updateProfile {
	[self showActivityIndicator];
	[[UVSession currentSession].user updateName:self.name email:self.email delegate:self];
}

- (void)dismissKeyboard {
	[nameField resignFirstResponder];
	[emailField resignFirstResponder];
}

- (void)updateFromControls {
	self.name = nameField.text;
	self.email = emailField.text;
	
	[self dismissKeyboard];
}

- (void)didUpdateUser:(UVUser *)theUser {
	[self hideActivityIndicator];
	[UVSession currentSession].user = theUser;
}

- (void)logoutButtonTapped {
//	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Sure?" 
//													 message:@"Are you sure?" 
//													delegate:self 
//										   cancelButtonTitle:@"OK" 
//										   otherButtonTitles:nil] autorelease];
//	alert.show;
	[self showActivityIndicator];
	
	[[UVSession currentSession].currentToken revoke:self];
}

- (void)updateButtonTapped {
	[self updateFromControls];
	[self showActivityIndicator];
	[self.user updateName:self.name email:self.email delegate:self];
}

- (void)didRevokeToken:(UVUser *)aUser {
	[self hideActivityIndicator];
	[[UVSession currentSession].currentToken remove];
	[UVSession currentSession].user = nil;
	
	[self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark ===== table cells =====

- (UITextField *)customizeTextFieldCell:(UITableViewCell *)cell label:(NSString *)label placeholder:(NSString *)placeholder {
	cell.textLabel.text = label;
	UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(65, 12, 230, 20)];
	textField.placeholder = placeholder;
	textField.returnKeyType = UIReturnKeyDone;
	textField.borderStyle = UITextBorderStyleNone;
	textField.delegate = self;
	[cell.contentView addSubview:textField];
	return [textField autorelease];
}

- (void)initCellForName:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
	self.nameField = [self customizeTextFieldCell:cell label:@"Name" placeholder:@"Anonymous"];
	self.nameField.text = self.user.displayName;
}

- (void)initCellForEmail:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
	self.emailField = [self customizeTextFieldCell:cell label:@"Email" placeholder:@"Required"];
	self.emailField.keyboardType = UIKeyboardTypeEmailAddress;
	self.emailField.autocorrectionType = UITextAutocorrectionTypeNo;
	self.emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	self.emailField.text = self.user.email;
}

- (void)initCellForUpdate:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
	[self removeBackgroundFromCell:cell];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0, 0, 300, 42);
	button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
	button.titleLabel.textColor = [UIColor whiteColor];
	[button setTitle:@"Update" forState:UIControlStateNormal];
	[button setBackgroundImage:[UIImage imageNamed:@"uv_primary_button_green.png"] forState:UIControlStateNormal];
	[button setBackgroundImage:[UIImage imageNamed:@"uv_primary_button_green_active.png"] forState:UIControlStateHighlighted];
	[button addTarget:self action:@selector(updateButtonTapped) forControlEvents:UIControlEventTouchUpInside];
	[cell.contentView addSubview:button];
}

- (void)initCellForLogout:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
	[self removeBackgroundFromCell:cell];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0, 0, 300, 42);
	button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
	button.titleLabel.textColor = [UIColor whiteColor];
	[button setTitle:@"Logout from UserVoice" forState:UIControlStateNormal];
	[button setBackgroundImage:[UIImage imageNamed:@"uv_primary_button_red.png"] forState:UIControlStateNormal];
	[button setBackgroundImage:[UIImage imageNamed:@"uv_primary_button_red_active.png"] forState:UIControlStateHighlighted];
	[button addTarget:self action:@selector(logoutButtonTapped) forControlEvents:UIControlEventTouchUpInside];
	[cell.contentView addSubview:button];
}

- (void)initCellForIcon:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {	
	UVUserAvatarView *avatar = [[UVUserAvatarView alloc] initWithOrigin:CGPointMake(5, 5) avatarUrl:self.user.avatarUrl];
	avatar.tag = UV_PROFILE_TAG_AVATAR;
	[cell.contentView addSubview:avatar];
	[avatar release];
}

#pragma mark ===== UITableViewDataSource Methods =====

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = @"";
	UITableViewCellStyle style = UITableViewCellStyleDefault;
	BOOL selectable = NO;
	
	switch (indexPath.section) {
		case UV_PROFILE_SECTION_ICON:
			identifier = @"Icon";
			break;
		case UV_PROFILE_SECTION_DETAILS:
			identifier = indexPath.row == 0 ? @"Email" : @"Name";
			break;
		case UV_PROFILE_SECTION_UPDATE:
			identifier = @"Update";
			break;
		case UV_PROFILE_SECTION_LOGOUT:
			identifier = @"Logout";
			break;
	}
	
	return [self createCellForIdentifier:identifier
							   tableView:theTableView
							   indexPath:indexPath
								   style:style
							  selectable:selectable];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
	return 4;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section {
	if (section == UV_PROFILE_SECTION_DETAILS) {
		return 2;
	} else {
		return 1;
	}
}

#pragma mark ===== UITextFieldDelegate Methods =====

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	// Scroll to the active text field
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:UV_PROFILE_SECTION_DETAILS];
	[self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

#pragma mark ===== UITableViewDelegate Methods =====

- (CGFloat)tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.section) {
		case UV_PROFILE_SECTION_ICON:
			return 60;
		default:
			return 44;
	}
}

- (CGFloat)tableView:(UITableView *)theTableView heightForHeaderInSection:(NSInteger)section {
	return 0.0;
}

- (CGFloat)tableView:(UITableView *)theTableView heightForFooterInSection:(NSInteger)section {
	switch (section) {
		case UV_PROFILE_SECTION_DETAILS:
			return 50.0;
			break;
		case UV_PROFILE_SECTION_LOGOUT:
			return 40.0;
			break;
		default:
			return 0.0;
	}
}

- (UIView *)tableView:(UITableView *)theTableView viewForFooterInSection:(NSInteger)section {
	if (section == UV_PROFILE_SECTION_DETAILS) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(18, 7, 284, 30)];
		
		label.text = @"Changing your email address will require it to be confirmed again.";
		label.textColor = [UVStyleSheet dimBlueColor];
		label.backgroundColor = [UIColor clearColor];
		label.font = [UIFont boldSystemFontOfSize:13];
		label.textAlignment = UITextAlignmentCenter;
		label.numberOfLines = 2;
		[view addSubview:label];
		[label release];
		
		return [view autorelease];

	} else if (section == UV_PROFILE_SECTION_LOGOUT) {
		if ([self.user hasUnconfirmedEmail]) {
			UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
			UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(38, 0, 300, 40)];
			
			UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uv_alert.png"]];
			icon.frame = CGRectMake(18, 10, 18, 18);
			[view addSubview:icon];
			[icon release];
			
			label.text = @"Your email has not yet been confirmed";
			label.textColor = [UVStyleSheet darkRedColor];
			label.backgroundColor = [UIColor clearColor];
			label.font = [UIFont boldSystemFontOfSize:14];
			label.textAlignment = UITextAlignmentLeft;		
			[view addSubview:label];
			[label release];
			
			return [view autorelease];
		}
	}
	return nil;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark ===== Basic View Methods =====

- (void)loadView {
	[super loadView];
	
	self.user = [UVSession currentSession].user;
	
	self.navigationItem.title = @"Edit Profile";
	
	CGRect frame = [self contentFrame];
	UIView *contentView = [[UIView alloc] initWithFrame:frame];
	
	UITableView *theTableView = [[UITableView alloc] initWithFrame:contentView.bounds style:UITableViewStyleGrouped];
	theTableView.dataSource = self;
	theTableView.delegate = self;
	theTableView.backgroundColor = [UIColor clearColor];
	
	self.tableView = theTableView;
	[contentView addSubview:theTableView];
	[theTableView release];
	
	self.view = contentView;
	[contentView release];
	
	[self addGradientBackground];
}

- (void)viewWillAppear:(BOOL)animated {
	// Listen for keyboard hide/show notifications
	[super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
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
	self.nameField = nil;
	self.emailField = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
