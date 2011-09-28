//
//  UVSignInViewController.m
//  UserVoice
//
//  Created by Scott Rutherford on 13/05/2010.
//  Copyright 2010 UserVoice Inc. All rights reserved.
//

#import "UVSignInViewController.h"
#import "UVStyleSheet.h"
#import "UVSession.h"
#import "UVUser.h"
#import "UVToken.h"
#import "UVClientConfig.h"
#import "UVProfileViewController.h"
#import "UVClientConfig.h"
#import "NSError+UVExtras.h"

#define UV_SIGNIN_SECTION_DETAILS 0
#define UV_SIGNIN_SECTION_ACTIONS 1

#define UV_USER_UNKNOWN 0
#define UV_USER_NEW 1
#define UV_USER_PASSWORD 2

@implementation UVSignInViewController

@synthesize name;
@synthesize email;
@synthesize nameField;
@synthesize emailField;
@synthesize passwordField;
@synthesize user;
@synthesize userType;

- (id)init {
	if (self = [super init]) {
		self.userType = UV_USER_UNKNOWN;
	}
	return self;
}

- (id)initWithUVUser:(UVUser *)aUser {
	if (self = [super init]) {
		self.user = aUser;
		self.email = aUser.email;
		self.name = aUser.displayName;
		self.userType = UV_USER_PASSWORD;
	}
	return self;
}

- (void)dismissKeyboard {
	[nameField resignFirstResponder];
	[emailField resignFirstResponder];
}

- (void)updateFromUser {
	self.emailField.text = self.user.email;
	self.nameField.text = self.user.displayName;
}

- (void)updateFromControls {
	self.name = nameField.text;
	self.email = emailField.text;
	
	[self dismissKeyboard];
}

- (void)checkEmail {		
	if (self.emailField.text && self.emailField.text.length > 0 && ![self.email isEqualToString:self.emailField.text]) {
		self.email = self.emailField.text;
		[self showActivityIndicatorWithText:@"Checking..."];
		[UVUser discoverWithEmail:emailField.text delegate:self];
	}
}

- (void)checkPassword {
	if (self.passwordField.text && self.passwordField.text.length > 0) {
		[self showActivityIndicatorWithText:@"Checking..."];
		[UVToken getAccessTokenWithDelegate:self andEmail:emailField.text andPassword:passwordField.text];
	}
}

- (void)addForgotPasswordFooter {
	UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0, 10, 320, 15);
	NSString *buttonTitle = @"Forgot your password?";
	[button setTitle:buttonTitle forState:UIControlStateNormal];
	[button setTitleColor:[UVStyleSheet dimBlueColor] forState:UIControlStateNormal];
	button.backgroundColor = [UIColor clearColor];
	button.showsTouchWhenHighlighted = YES;
	button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
	[button addTarget:self action:@selector(forgotPasswordButtonTapped) forControlEvents:UIControlEventTouchUpInside];
	[footer addSubview:button];	
	
	self.tableView.tableFooterView = footer;
	[footer release];
}

- (void)didDiscoverUser:(UVUser *)theUser {
	[self hideActivityIndicator];
	self.user = theUser;
	self.userType = UV_USER_PASSWORD;

	[self hideActivityIndicator];
	[self addForgotPasswordFooter];
	[self.tableView reloadData];	
}

- (void)didReceiveError:(NSError *)error {
	[self hideActivityIndicator];
	NSLog(@"SignIn Error");
	if ([error isNotFoundError]) {
		self.userType = UV_USER_NEW;				
		[self hideActivityIndicator];
		[self.tableView reloadData];
		
	} else if ([error isAuthError]) {
		[self hideActivityIndicator];
		NSString *msg = @"There was a problem logging you in, please check your password and try again.";
		[self showErrorAlertViewWithMessage:msg];
		
	} else {
		[super didReceiveError:error];
	}
}

- (void)didRetrieveAccessToken:(UVToken *)token {	
	[token persist];
	[UVSession currentSession].currentToken = token;	

	// reload config to get any answers to questions
	[UVClientConfig getWithDelegate:self];
}

- (void)didRetrieveClientConfig:(UVClientConfig *)config {
	// grab the actual user profile with email status
	[UVUser retrieveCurrentUser:self];
}

- (void)didRetrieveCurrentUser:(UVUser *)theUser {
	// head back to whichever view launched the login section
	[self hideActivityIndicator];
	[UVSession currentSession].user = theUser;
	
	NSArray *viewControllers = [self.navigationController viewControllers];
	UVBaseViewController *prev = (UVBaseViewController *)[viewControllers objectAtIndex:[viewControllers count] - 2];
	prev.needsReload = YES;
	[self.navigationController popViewControllerAnimated:YES];	
}

- (void)saveButtonTapped {
	[self updateFromControls];
	
	if (self.email && [self.email length] > 1) {
		[self showActivityIndicator];
		// create the user, access token and return
		[UVUser findOrCreateWithEmail:self.email andName:self.name andDelegate:self];
		
	} else {
		NSString *msg = @"Please enter your email address.";
		[self showErrorAlertViewWithMessage:msg];
	}
}

- (void) didCreateUser:(UVUser *)theUser {
	[self hideActivityIndicator];
	[UVSession currentSession].user = theUser;	
	
	// token should have been loaded by ResponseDelegate
	[[UVSession currentSession].currentToken persist];
	
	NSArray *viewControllers = [self.navigationController viewControllers];
	UVBaseViewController *prev = (UVBaseViewController *)[viewControllers objectAtIndex:[viewControllers count] - 2];
	prev.needsReload = YES;
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)forgotPasswordButtonTapped {
	[self showActivityIndicator];
	[self.user forgotPasswordForEmail:self.email andDelegate:self];
}

- (void)didSendForgotPassword {
	[self hideActivityIndicator];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
													message:@"We've sent an email telling you how to login and change your password."
												   delegate:nil
										  cancelButtonTitle:nil
										  otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

#pragma mark ===== table cells =====

- (UITextField *)customizeTextFieldCell:(UITableViewCell *)cell 
								  label:(NSString *)label 
							placeholder:(NSString *)placeholder 
								 offset:(NSInteger)offset{
	cell.textLabel.text = label;
	UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(offset, 12, 230, 20)];
	textField.placeholder = placeholder;
	textField.returnKeyType = UIReturnKeyDone;
	textField.borderStyle = UITextBorderStyleNone;
	textField.delegate = self;
	[cell.contentView addSubview:textField];
	return [textField autorelease];
}

- (void)initCellForName:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
	self.nameField = [self customizeTextFieldCell:cell label:@"Name" placeholder:@"Anonymous" offset:63];
	if (self.user) {
		self.nameField.text = self.user.displayName;
	}
}

- (void)initCellForEmail:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
	self.emailField = [self customizeTextFieldCell:cell label:@"Email" placeholder:@"Required" offset:63];
	self.emailField.keyboardType = UIKeyboardTypeEmailAddress;
	self.emailField.autocorrectionType = UITextAutocorrectionTypeNo;
	self.emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	if (self.user) {
		self.emailField.text = self.user.email;
	}
}

- (void)initCellForCreate:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
	[self removeBackgroundFromCell:cell];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0, 0, 300, 42);
	button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
	button.titleLabel.textColor = [UIColor whiteColor];
	[button setTitle:@"Create Account" forState:UIControlStateNormal];
	[button setBackgroundImage:[UIImage imageNamed:@"uv_primary_button_green.png"] forState:UIControlStateNormal];
	[button setBackgroundImage:[UIImage imageNamed:@"uv_primary_button_green_active.png"] forState:UIControlStateHighlighted];
	[button addTarget:self action:@selector(saveButtonTapped) forControlEvents:UIControlEventTouchUpInside];
	[cell.contentView addSubview:button];
}

- (void)initCellForPassword:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
	self.passwordField = [self customizeTextFieldCell:cell label:@"Password" placeholder:@"" offset: 95];
	[self.passwordField setSecureTextEntry:YES];
	[self.passwordField becomeFirstResponder];
}

- (void)initCellForActions:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
	//self.nameField = [self customizeTextFieldCell:cell label:@"Password"];
}

#pragma mark ===== UITableViewDataSource Methods =====

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = @"";
	UITableViewCellStyle style = UITableViewCellStyleDefault;
	BOOL selectable = NO;
	
	switch (indexPath.section) {
		case UV_SIGNIN_SECTION_DETAILS:
			identifier = indexPath.row == 0 ? @"Email" : @"Name";
			break;
		case UV_SIGNIN_SECTION_ACTIONS:
			if (self.userType == UV_USER_NEW) {
				identifier = @"Create";
			} else {
				identifier = @"Password";
			}			
			break;
	}
	
	return [self createCellForIdentifier:identifier
							   tableView:theTableView
							   indexPath:indexPath
								   style:style
							  selectable:selectable];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
	if (self.userType == UV_USER_NEW || self.userType == UV_USER_PASSWORD) {
		return 2;
	} else {
		return 1;
	}
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section {
	if (section == UV_SIGNIN_SECTION_DETAILS && 
		(self.userType == UV_USER_NEW || self.userType == UV_USER_UNKNOWN)) {
		return 2;
	} else {
		return 1;
	}
}

#pragma mark ===== UITextFieldDelegate Methods =====

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	// Reset didReturn flag. This allows us to distinguish later between the user dismissing the
	// keyboard (by tapping on the return key) or tapping on a different text field. In the
	// latter case we don't want to grow and re-shrink the table view.
	shouldResizeForKeyboard = NO;
	
	// Scroll to the active text field
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:UV_SIGNIN_SECTION_DETAILS];
	[self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	NSLog(@"textFieldShouldEndEditing %@", textField.text);
	if (textField==emailField) {
		NSLog(@"Check email");
		[self checkEmail];
		
	} else if (textField==passwordField) {
		NSLog(@"Check password");
		[self checkPassword];
	}
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	NSLog(@"textFieldShouldReturn %@", textField.text);		

	[textField resignFirstResponder];
	return YES;
}

#pragma mark ===== UITableViewDelegate Methods =====

- (CGFloat)heightForViewWithText:(NSString *)text{
	CGSize cgsize = [text sizeWithFont:[UIFont systemFontOfSize:14]
						   constrainedToSize:CGSizeMake(280, 9999)
							   lineBreakMode:UILineBreakModeWordWrap];
	return cgsize.height + 40; // (header + padding between/bottom)
}

- (UIView *)viewWithText:(NSString *)text {
	CGFloat height = [self heightForViewWithText:text];
	UIView *textView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, height)] autorelease];
	textView.backgroundColor = [UIColor clearColor];
	
	UILabel *msg = [[UILabel alloc] initWithFrame:CGRectMake(20, 23, 280, height - 40)];
	msg.text = text;
	msg.lineBreakMode = UILineBreakModeWordWrap;
	msg.numberOfLines = 0;
	msg.font = [UIFont systemFontOfSize:14];
	msg.backgroundColor = [UIColor clearColor];
	msg.textColor = [UVStyleSheet tableViewHeaderColor];
	[textView addSubview:msg];
	[msg release];
	
	return textView;
}

- (NSString *)headerTextForSection:(NSInteger)section {
	if (section == UV_SIGNIN_SECTION_ACTIONS) {
		switch (self.userType) {
			case UV_USER_NEW:
				return @"Looks like it's your first time here, welcome to UserVoice!";
				break;
			case UV_USER_PASSWORD:
				return @"Welcome back! We found your profile, but we need you to sign in to verify you are... you.";
				break;
			default:
				break;
		}
	}
	return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (section == UV_SIGNIN_SECTION_ACTIONS) {
		return [self heightForViewWithText:[self headerTextForSection:section]];
	} else {
		return 0.0;
	}
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	if (section == UV_SIGNIN_SECTION_ACTIONS) {
		return [self viewWithText:[self headerTextForSection:section]];
	} else {
		CGFloat height = [self tableView:self.tableView heightForHeaderInSection:section];
		return [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, height)] autorelease];
	}
}

- (CGFloat)tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.section) {
		case UV_SIGNIN_SECTION_ACTIONS:
			return 44;
		default:
			return 44;
	}
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark ===== Basic View Methods =====

- (void)loadView {
	[super loadView];
	
	self.navigationItem.title = @"Sign In";
	
	CGRect frame = [self contentFrame];
	UIView *contentView = [[UIView alloc] initWithFrame:frame];
	
	UITableView *theTableView = [[UITableView alloc] initWithFrame:contentView.bounds style:UITableViewStyleGrouped];
	theTableView.dataSource = self;
	theTableView.delegate = self;
	theTableView.sectionFooterHeight = 0.0;
	theTableView.backgroundColor = [UIColor clearColor];
		
	self.tableView = theTableView;

	[contentView addSubview:theTableView];
	[theTableView release];
	
	self.view = contentView;
	[contentView release];

	[self addGradientBackground];
}

- (void)viewDidAppear:(BOOL)animated {
	if (self.needsReload) {
		[self.tableView reloadData];
		self.needsReload = NO;
	}
	
	if (!self.emailField.text)
		[self.emailField becomeFirstResponder];
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
	self.passwordField = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
