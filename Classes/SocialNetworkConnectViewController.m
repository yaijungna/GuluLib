//
//  SocialNetworkConnectViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/14.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "SocialNetworkConnectViewController.h"


@implementation SocialNetworkConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//	[ACUtility cleanCookie];
	
	
	network=[[ACNetworkManager alloc] init];
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
	[self.view addSubview:topView];
	[topView release];
	[topView.topLeftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	
	checkingView=[[[loadingSpinnerAndMessageView alloc] init] autorelease];
	[self.view addSubview:checkingView];
	checkingView.hidden=YES;

	//=======
    
    
	fbObject=[[facebookConnectionModel alloc] init];
	fbObject.delegate=self;
    
    if([ACCheckConnection isConnectedToNetwork])
    {
        [self showSpinnerView:checkingView mesage:SIGNIN_CHECKING_STRING];
        [fbObject getFBRandomToken];
    }
    else
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
    }

}
- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
}

- (void)dealloc {
	[fbObject release];
	[network release];
    [super dealloc];
}

#pragma mark -


- (void)backAction 
{
	webview.delegate=nil;
	[network cancelAllRequestsInRequestsQueue];
	[fbObject cancelGetFBRandomToken];
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark request Function Methods

- (void) getUserObjByFBRandomToken
{	
	[self showSpinnerView:checkingView mesage:SIGNIN_CHECKING_STRING];
	self.view.userInteractionEnabled=NO;
	
	[self getUserObjByFBRandomTokenConnection:network facebook:fbObject.fbToken];
}


- (void) ACConnectionSuccess:(ASIFormDataRequest *)request
{
	[self hideSpinnerView:checkingView];
	self.view.userInteractionEnabled=YES;

	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	NSDictionary *tempDict = [djsonDeserializer deserializeAsDictionary:data1 error:&derror];
	
	if(tempDict==nil || [tempDict isEqual:[NSNull null]] || [tempDict count]==0 )
	{
	//	NSString *errorStr = [[NSString alloc] initWithData:data1 encoding:NSASCIIStringEncoding];
	//	[self showErrorAlert:errorStr];
		return;
	}
	else if([tempDict objectForKey:@"errorMessage"])
	{
		[self showErrorAlert:[NSString stringWithFormat:@"%@",[tempDict objectForKey:@"errorMessage"]]];
		return;
	}
	else
	{
		[self shareGULUAPP];
		NSString *session =[tempDict objectForKey:@"session_key"];
		NSDictionary *user=[tempDict objectForKey:@"user"];
		
		appDelegate.userMe.userDictionary=[NSMutableDictionary dictionaryWithDictionary:user];
		appDelegate.userMe.uid=[appDelegate.userMe.userDictionary objectForKey:@"id"];
		appDelegate.userMe.username=[appDelegate.userMe.userDictionary objectForKey:@"username"];
		appDelegate.userMe.sessionKey=session;
		[appDelegate.userMe loadUserImage];
		
		[appDelegate.userMe save];
	//	[SQLitePersistentObject clearCache];
		
		NSLog(@"%@",appDelegate.userMe);
		
		[self dismissModalViewControllerAnimated:YES];
	}
	
}

-(void) ACConnectionFailed:(ASIFormDataRequest *)request
{
	[self hideSpinnerView:checkingView];
	self.view.userInteractionEnabled=YES;
	
//	NSString *errorString = CONNECTION_ERROR_STRING;	
//	[self showErrorAlert:errorString];
    
    [self backAction];
}


#pragma mark -
#pragma mark facebook delegate Function Methods

-(void)facebookGetTokenSuccess
{
	NSString *str= [NSString stringWithFormat:@"%@?fb_token=%@",URL_USER_FACEBOOK_CONNECT_WEB,fbObject.fbToken];
	NSURL *url = [NSURL URLWithString:str];
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc]initWithURL: url] autorelease];
	webview.delegate=self;
    [webview loadRequest:request];	
	
	NSLog(@"%@",fbObject.fbToken);
}

-(void)facebookGetTokenFail
{
	//NSString *errorString = CONNECTION_ERROR_STRING;
	//[self showErrorAlert:errorString];
    
    
     [self backAction];
}

#pragma mark -
#pragma mark delegate Function Methods

- (void)webViewDidStartLoad:(UIWebView *)webVieww
{
	[self showSpinnerView:checkingView mesage:SIGNIN_CHECKING_STRING];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	NSString *url=[NSString stringWithFormat:@"%@",webView.request];
	NSString *fburl_success=URL_USER_FACEBOOK_CONNECT_OK;
    //NSString *fburl_success=@"http://www.gulu.com/api/facebook_connect_success";
	NSString *fburl_fail=URL_USER_FACEBOOK_CONNECT_FAILED;
    //NSString *fburl_fail=@"http://www.gulu.com/api/facebook_connect_fail";

	[self hideSpinnerView:checkingView];
	
	BOOL match = ([url rangeOfString:fburl_success options:NSCaseInsensitiveSearch].location != NSNotFound);
	
    
    NSLog(@"%@",url);
    NSLog(@"%@",fburl_success);
    NSLog(@"%@",fburl_fail);
    
	if(match)
	{
		[self getUserObjByFBRandomToken];
	}

	match = ([url rangeOfString:fburl_fail options:NSCaseInsensitiveSearch].location != NSNotFound);
	
	if(match)
	{
		[self backAction];
	}
	
	
}




@end
