//
//  signInViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/13.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "signInViewController.h"


@implementation signInViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	
	network=[[ACNetworkManager alloc] init];
	checkingView=[[[loadingSpinnerAndMessageView alloc] init] autorelease];
	[self.view addSubview:checkingView];
	checkingView.hidden=YES;
    
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
	[self.view addSubview:topView];
	[topView release];
	
	[topView.topLeftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
	welcomeLabel.numberOfLines=2;
	welcomeLabel.textColor=TEXT_COLOR;
	welcomeLabel.font=[UIFont fontWithName:FONT_BOLD size:20];
	welcomeLabel.text=SIGNIN_WELCOME_STRING;
	
	
	firstItem=[[numberAndImageView alloc] initWithFrame:CGRectMake(30, 60, 200, 50)];
	firstItem.numberLabel.text=@"1.";
	[firstItem.btn setBackgroundImage:[UIImage imageNamed:@"fb-connect-button.png"] forState:UIControlStateNormal];
	[myView addSubview:firstItem];
	[firstItem release];
	[firstItem.btn addTarget:self action:@selector(facebookConnectionAction) forControlEvents:UIControlEventTouchUpInside];
	
	/*
     secondItem=[[numberAndImageView alloc] initWithFrame:CGRectMake(30, 180, 200, 50)];
     secondItem.numberLabel.text=@"2.";
     [secondItem.btn setBackgroundImage:[UIImage imageNamed:@"mixi-connect-button.png"] forState:UIControlStateNormal];
     [myView addSubview:secondItem];
     [secondItem release];
     */
	thirdItem=[[numberAndImageView alloc] initWithFrame:CGRectMake(30, 120, 200, 50)];
	thirdItem.numberLabel.text=@"2";
	thirdItem.btn.hidden=YES;
	[myView addSubview:thirdItem];
	[thirdItem release];
	
	inputbg=[[inputBackGroundView alloc] initWithFrame:CGRectMake(70, 120, 220, 90)];
	[myView addSubview:inputbg];
	[inputbg release];
	
	usernametextField=[[UITextField alloc] initWithFrame:CGRectMake(80, 130, 200, 30)];
	[self customizeTextField:usernametextField];
	[myView addSubview:usernametextField];
	[usernametextField release];
	usernametextField.delegate=self;
	usernametextField.placeholder=SIGNIN_USERNAME_STRING;
	usernametextField.autocapitalizationType= UITextAutocapitalizationTypeNone;
	usernametextField.autocorrectionType=UITextAutocorrectionTypeDefault;
    
	
	passwordtextField=[[UITextField alloc] initWithFrame:CGRectMake(80, 170, 200, 30)];
	[self customizeTextField:passwordtextField];
	[myView addSubview:passwordtextField];
	[passwordtextField release];
	passwordtextField.delegate=self;
	passwordtextField.placeholder=SIGNIN_PASSWORD_STRING;
	passwordtextField.secureTextEntry=YES;
	
}
- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
	[network release];
    [super dealloc];
}

#pragma mark -

- (void)facebookConnectionAction
{
	SocialNetworkConnectViewController *VC=[[SocialNetworkConnectViewController alloc] initWithNibName:@"SocialNetworkConnectViewController" bundle:nil];	
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];	
}


- (IBAction)tapBackGround 
{
	[usernametextField resignFirstResponder];
	[passwordtextField resignFirstResponder];
	[self moveTheView:myView movwToPosition:CGPointMake(0, 50)];
}

- (void)backAction 
{
	[self.navigationController popViewControllerAnimated:YES];
	[network cancelAllRequestsInRequestsQueue];
}


#pragma mark -
#pragma mark TextField Delegate Function Methods


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{	
	if(usernametextField.text==nil || [usernametextField.text isEqualToString:@""] || 
	   passwordtextField.text==nil || [passwordtextField.text isEqualToString:@""])
	{
		
	}
	else 
	{
		[self signinRequest];
		[textField resignFirstResponder];
		[self moveTheView:myView movwToPosition:CGPointMake(0, 50)];
		
	}
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	[self moveTheView:myView movwToPosition:CGPointMake(0, 30)];
	
	return YES;
}

#pragma mark -
#pragma mark request Function Methods

- (void)signinRequest
{
    if([ACCheckConnection isConnectedToNetwork])
    {
        [self showSpinnerView:checkingView mesage:SIGNIN_CHECKING_STRING];
        myView.userInteractionEnabled=NO;
        
        [self siginConnection:network username:usernametextField.text password:passwordtextField.text];	
    }
    else
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
    }
}

#pragma mark -

-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:checkingView];
	myView.userInteractionEnabled=YES;
	
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	NSDictionary *tempDict = [djsonDeserializer deserialize:data1 error:&derror];
	
	if(tempDict==nil || [tempDict isEqual:[NSNull null]] || [tempDict count]==0 )
	{
		ACLog(@"%@", tempDict ) ;
		//NSString *errorStr = [[NSString alloc] initWithData:data1 encoding:NSASCIIStringEncoding];
		//[self showErrorAlert:errorStr];
		return;
	}
	else if([tempDict objectForKey:@"errorMessage"])
	{
        ACLog(@"%@",[tempDict objectForKey:@"errorMessage"]);
		// if we have an error string, return a localized string string
		if([tempDict objectForKey:@"error"])
		{
			// Default is a generic error message
			NSString * alert_string = NSLocalizedString(@"Sorry An Error Occurred", @"Unknown error") ;
			NSString * error_string = [tempDict objectForKey:@"error"] ;
            
			if ([error_string isEqualToString:@"email_not_avail"] )			{ alert_string = NSLocalizedString(@"email_not_avail", @"Email address in use") ;}
			if ([error_string isEqualToString:@"email_not_valid"] )			{ alert_string = NSLocalizedString(@"email_not_valid", @"Email Not Valid") ;}
			if ([error_string isEqualToString:@"please_check_your_email"] )	{ alert_string = NSLocalizedString(@"please_check_your_email", @"Please Enter Your Email") ;}
			if ([error_string isEqualToString:@"username_not_avail"] )		{ alert_string = NSLocalizedString(@"username_not_avail", @"Username is in use") ;}
			if ([error_string isEqualToString:@"username_not_valid"] )		{ alert_string = NSLocalizedString(@"username_not_valid", @"Bad user name") ;}
			if ([error_string isEqualToString:@"bad_username_password"] )	{ alert_string = NSLocalizedString(@"bad_username_password", @"Bad User Name Or Password") ;}
			if ([error_string isEqualToString:@"email_not_found"] )			{ alert_string = NSLocalizedString(@"email_not_found", @"Email Not Found") ;}
			if ([error_string isEqualToString:@"no_email_entered"] )		{ alert_string = NSLocalizedString(@"no_email_entered", @"Please Enter Your Email") ;}
			if ([error_string isEqualToString:@"not_activate"] )			{ alert_string = NSLocalizedString(@"not_activate", @"Please Enter Your Email") ;}
			
			[self showErrorAlert:[NSString stringWithFormat:@"%@",alert_string]];	// show our localized string
            return;
            
		} else{
			[self showErrorAlert:[NSString stringWithFormat:@"%@",[tempDict objectForKey:@"errorMessage"]]];
            return;
            
		}
		return;
	}
	else
	{
        ACLog(@"Login OK");
        
		[self shareGULUAPP];
		NSString *session =[tempDict objectForKey:@"session_key"];
		NSDictionary *user=[tempDict objectForKey:@"user"];
        
		appDelegate.userMe.userDictionary=[NSMutableDictionary dictionaryWithDictionary:user];
		appDelegate.userMe.uid=[appDelegate.userMe.userDictionary objectForKey:@"id"];
		appDelegate.userMe.username=[appDelegate.userMe.userDictionary objectForKey:@"username"];
		appDelegate.userMe.sessionKey=session;
		[appDelegate.userMe loadUserImage];
		
		[appDelegate.userMe save];
		
		[self dismissModalViewControllerAnimated:YES];
	}
    
}
-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{
	[self hideSpinnerView:checkingView];
	myView.userInteractionEnabled=YES;
    //	NSString *errorString = CONNECTION_ERROR_STRING;	
    //	[self showErrorAlert:errorString];
}

@end