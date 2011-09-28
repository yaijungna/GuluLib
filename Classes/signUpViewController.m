//
//  signUpViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/13.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "signUpViewController.h"


@implementation signUpViewController


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
	
	welcomeLabel.numberOfLines=1;
	welcomeLabel.textColor=TEXT_COLOR;
	welcomeLabel.font=[UIFont fontWithName:FONT_BOLD size:20];
	welcomeLabel.text=SIGNUP_WELCOME_STRING;
	
	
	firstItem=[[numberAndImageView alloc] initWithFrame:CGRectMake(30, 50, 200, 50)];
	firstItem.numberLabel.text=@"1.";
	[firstItem.btn setBackgroundImage:[UIImage imageNamed:@"fb-connect-button.png"] forState:UIControlStateNormal];
	[myView addSubview:firstItem];
	[firstItem release];
	[firstItem.btn addTarget:self action:@selector(facebookConnectionAction) forControlEvents:UIControlEventTouchUpInside];
	
	/*
	secondItem=[[numberAndImageView alloc] initWithFrame:CGRectMake(30, 110, 200, 50)];
	secondItem.numberLabel.text=@"2.";
	[secondItem.btn setBackgroundImage:[UIImage imageNamed:@"mixi-connect-button.png"] forState:UIControlStateNormal];
	[myView addSubview:secondItem];
	[secondItem release];
	*/
	
	thirdItem=[[numberAndImageView alloc] initWithFrame:CGRectMake(30, 110, 200, 50)];
	thirdItem.numberLabel.text=@"2.";
	thirdItem.btn.hidden=YES;
	[myView addSubview:thirdItem];
	[thirdItem release];
	
	inputbg=[[inputBackGroundView alloc] initWithFrame:CGRectMake(70, 110, 245, 170)];
	[myView addSubview:inputbg];
	[inputbg release];
	
	usernametextField=[[UITextField alloc] initWithFrame:CGRectMake(80, 120, 200, 30)];
	[self customizeTextField:usernametextField];
	[myView addSubview:usernametextField];
	[usernametextField release];
	usernametextField.delegate=self;
	usernametextField.placeholder=SIGNIN_USERNAME_STRING;
	usernametextField.autocapitalizationType= UITextAutocapitalizationTypeNone;
	usernametextField.autocorrectionType=UITextAutocorrectionTypeDefault;
	
	emailtextField=[[UITextField alloc] initWithFrame:CGRectMake(80, 160, 200, 30)];
	[self customizeTextField:emailtextField];
	[myView addSubview:emailtextField];
	[emailtextField release];
	emailtextField.delegate=self;
	emailtextField.placeholder=SIGNUP_EMAIL_ADDRESS_STRING;
	emailtextField.autocapitalizationType= UITextAutocapitalizationTypeNone;
	emailtextField.autocorrectionType=UITextAutocorrectionTypeDefault;
	
	passwordtextField=[[UITextField alloc] initWithFrame:CGRectMake(80, 200, 200, 30)];
	[self customizeTextField:passwordtextField];
	[myView addSubview:passwordtextField];
	[passwordtextField release];
	passwordtextField.delegate=self;
	passwordtextField.placeholder=SIGNIN_PASSWORD_STRING;
	passwordtextField.secureTextEntry=YES;
	
	passwordconfirmtextField=[[UITextField alloc] initWithFrame:CGRectMake(80, 240, 200, 30)];
	[self customizeTextField:passwordconfirmtextField];
	[myView addSubview:passwordconfirmtextField];
	[passwordconfirmtextField release];
	passwordconfirmtextField.delegate=self;
	passwordconfirmtextField.placeholder=SIGNUP_PASSWORDCONFIRM_STRING;
	passwordconfirmtextField.secureTextEntry=YES;
	
	[passwordtextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
	[passwordconfirmtextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
	
	
	confirmBtn=[[UIButton alloc] initWithFrame:CGRectMake(280, 240, 30, 30)];
	[confirmBtn setBackgroundImage:[UIImage imageNamed:@"SIGN_UP_CHECK.png"] forState:UIControlStateSelected];
	[confirmBtn setBackgroundImage:[UIImage imageNamed:@"SIGN_UP_X.png"] forState:UIControlStateNormal];
	confirmBtn.selected=NO;
	confirmBtn.userInteractionEnabled=NO;
	[myView addSubview:confirmBtn];
	[confirmBtn release];
	
	
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
	[emailtextField resignFirstResponder];
	[passwordtextField resignFirstResponder];
	[passwordconfirmtextField resignFirstResponder];
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
	   emailtextField.text==nil		|| [emailtextField.text isEqualToString:@""] ||
	   passwordtextField.text==nil || [passwordtextField.text isEqualToString:@""] ||
	   passwordconfirmtextField.text==nil || [passwordconfirmtextField.text isEqualToString:@""] )
	{
		return YES;
	}
	else 
	{
		if(confirmBtn.selected!=YES)
			return YES;

		[self signUpRequest];
		[textField resignFirstResponder];
		[self moveTheView:myView movwToPosition:CGPointMake(0, 50)];
		
	}
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	[self moveTheView:myView movwToPosition:CGPointMake(0, -40)];
	
	return YES;
}

- (void) textFieldChange :(UITextField *)textField
{
	if([passwordtextField.text isEqualToString:passwordconfirmtextField.text])
	{
		confirmBtn.selected=YES;
	}
	else
	{
		confirmBtn.selected=NO;
	}
}


#pragma mark -
#pragma mark request Function Methods

- (void)signUpRequest
{
    if([ACCheckConnection isConnectedToNetwork])
    {
        [self showSpinnerView:checkingView mesage:SIGNIN_CHECKING_STRING];
        myView.userInteractionEnabled=NO;
        
        [self sigupConnection:network username:usernametextField.text password:passwordtextField.text email:emailtextField.text];    }
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
	NSDictionary *tempDict = [djsonDeserializer deserializeAsDictionary:data1 error:&derror];
	
	
	NSLog(@"%@",tempDict);
	
	if(tempDict==nil || [tempDict isEqual:[NSNull null]] || [tempDict count]==0 )
	{
		NSString *errorStr = [[[NSString alloc] initWithData:data1 encoding:NSASCIIStringEncoding] autorelease];
		[self showErrorAlert:errorStr];
		return;
	}
	//else if(![[tempDict objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]])
	else if([tempDict objectForKey:@"errorMessage"])
	{
		if([[tempDict objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
		{
			[self showErrorAlert:[NSString stringWithFormat:@"%@",[tempDict objectForKey:@"errorMessage"]]];
			return;
		}
		else if([[tempDict objectForKey:@"errorMessage"] isKindOfClass:[NSNumber class]])
		{
			if([[tempDict objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]])
			{
                [self showOKAlert:NSLocalizedString(@"You have signed up, please check your email",@"Check Email")];
				
				//[self showOKAlert:NSLocalizedString(@"You have signed up, please check your email",@"Check Email")];
				
				/***** we no longer auto sign up.
				 **[self shareGULUAPP];
				 **NSString *session =[tempDict objectForKey:@"session_key"];
				 **NSDictionary *user=[tempDict objectForKey:@"user"];
				 
				 **appDelegate.userMe.userDictionary=[NSMutableDictionary dictionaryWithDictionary:user];
				 **appDelegate.userMe.uid=[appDelegate.userMe.userDictionary objectForKey:@"id"];
				 **appDelegate.userMe.username=[appDelegate.userMe.userDictionary objectForKey:@"username"];
				 **appDelegate.userMe.sessionKey=session;
				 **[appDelegate.userMe loadUserImage];
				 
				 **[appDelegate.userMe save];
				 **[SQLitePersistentObject clearCache];
				 
				 **[self dismissModalViewControllerAnimated:YES];
				 ******/

			}
			
		}

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