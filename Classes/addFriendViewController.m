    //
//  addFriendViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "addFriendViewController.h"
#import "CheckEmailFormat.h"

@implementation addFriendViewController

@synthesize photoDict;


- (void)viewDidLoad {
    [super viewDidLoad];
	
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
	[self.view addSubview:topView];
	[topView release];
	
	[topView.topLeftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	
	
	[self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
	
	[self customizeLabel_title:titlelabel];
	titlelabel.text=NSLocalizedString(@"Add Friends",@"add friend");
	[titlelabel setFont:[UIFont fontWithName:FONT_BOLD size:16]];
	[self customizeLabel_title:favoriteLabel];
	
	[self customizeTextField:nameTextField];
	nameTextField.delegate=self;
	nameTextField.placeholder=NSLocalizedString(@"Nickname",@"[friend] nickname");
	[nameTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
	

	
	[self customizeTextField:emailTextField];
	emailTextField.delegate=self;
	emailTextField.placeholder=NSLocalizedString(@"E-mail Address",@"[friend] email address");
	[emailTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
	
	[self customizeTextField:phoneTextField];
	phoneTextField.delegate=self;
	phoneTextField.placeholder=NSLocalizedString(@"Phone Number",@"[friend] phone number");
	
	[self customizeImageView:photoImageView];
	
	bgView.backgroundColor=lightBrownColor;
	bgView.layer.cornerRadius=10.0;
	bgView.alpha=0.5;
	
	[addButton setBackgroundImage:[UIImage imageNamed:@"button-0.png"] forState:UIControlStateNormal];
	[addButton setTitle:NSLocalizedString(@"Add Friend",@"add friend") forState:UIControlStateNormal];
	[addButton.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
	[addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
	[addButton addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
	addButton.enabled=NO;
	
	[startButton setImage:[UIImage imageNamed:@"inactive-like-star-1.png"] forState:UIControlStateNormal];
	[startButton setImage:[UIImage imageNamed:@"active-like-star-1.png"] forState:UIControlStateSelected];
	[startButton addTarget:self action:@selector(favoriteAction) forControlEvents:UIControlEventTouchUpInside];
	
	//=====
	
	imagePicker =[ACCameraViewController sharedManager];
	imagePicker.ACDelegate=self;
	[photoButton addTarget:self action:@selector(photoButtonAction) forControlEvents:UIControlEventTouchUpInside];
	//=====
    
    favoriteLabel.text=NSLocalizedString(@"Star", @"[add friend]");
	
	
	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	LoadingView.hidden=YES;
	

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
   
}

- (void)viewDidUnload {
    [super viewDidUnload];

}


- (void)dealloc {
	[photoDict release];
    [LoadingView release];
    [super dealloc];
}


#pragma mark -
#pragma mark action Function Methods



-(void)backAction
{
	[network cancelAllRequestsInRequestsQueue];
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)favoriteAction
{
	if(startButton.selected==YES)
	{
		startButton.selected=NO;
	}
	else
	{
		startButton.selected=YES;
	}
}

- (void) photoButtonAction
{
	[self presentModalViewController:imagePicker animated:NO];
}


#pragma mark -
#pragma mark TextField Delegate Function Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	return YES;
}

- (void)textFieldChange :(UITextField *)textField
{
	if( [nameTextField.text isEqualToString:@""] ||
	   nameTextField.text==nil ||
	   [emailTextField.text isEqualToString:@""] ||
	   emailTextField.text==nil )
	{
		addButton.enabled=NO;
	}
	else 
	{
		addButton.enabled=YES;
	}
	
	
	
}


#pragma mark -
#pragma mark request Delegate Function Methods

- (void)addFriend
{
	self.view.userInteractionEnabled=NO;
	
	if(phoneTextField.text==nil)
		phoneTextField.text=@"";
	
	NSString *pid=[photoDict objectForKey:@"id"] ;
	
	if(pid==nil)
	{
		pid=@"";
	}
	
	
	CheckEmailFormat *obj=[[[CheckEmailFormat alloc] init] autorelease];
	if(![obj check:emailTextField.text])
	{
		[self showErrorAlert:NSLocalizedString(@"Wrong email format.",@"")];
		self.view.userInteractionEnabled=YES;
		return;
	}
	
	if(isUplaodingphoto)
	{
		[self performSelector:@selector(addFriend) withObject:nil afterDelay:3.0];
	
		return;
	}
	
	
	
	addButton.enabled=NO;
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
	[self addFriendConnection:network 
					  photoID:pid
						phone:phoneTextField.text 
						email:emailTextField.text 
					 favorite:[NSString stringWithFormat:@"%d",startButton.selected] 
					 nickname:nameTextField.text];
}

#pragma mark -

-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
	self.view.userInteractionEnabled=YES; 

	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
	
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		ACLog(@"No Data");
	}
	
	//ACLog(@"temp %@",temp);
    ACLog(@"request ok");
    
    if([temp  isKindOfClass:[NSDictionary class]])
    {
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
        {
            //    NSString *errorString =CONNECTION_ERROR_STRING;
            //   [self showErrorAlert:errorString];
            ACLog(@"request error %@",temp);
            return;
        }
    }

	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"uploadPhoto"])
	{
		self.photoDict=temp;
		isUplaodingphoto=NO;
	}
	else if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"addFriend"])
	{
		addButton.enabled=YES;
		
		if(temp==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
		{
			NSString *errorStr = [[[NSString alloc] initWithData:data1 encoding:NSASCIIStringEncoding] autorelease];
			[self showErrorAlert:errorStr];
			return;
		}
		else if(![temp objectForKey:@"errorMessage"] )
		{
			[self showErrorAlert:[NSString stringWithFormat:@"%@",[temp objectForKey:@"errorMessage"]]];
			return;
		}
		else
		{
			[self shareGULUAPP];
			
			[self showOKAlert:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Add Friends",@"[button] add friend"),GLOBAL_OK_STRING]];
			return;
		}
	
	}
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	    
    ACLog(@"request fail");
	[self hideSpinnerView:LoadingView];
	self.view.userInteractionEnabled=YES; 
	
	
//	NSString *errorString =CONNECTION_ERROR_STRING;
//	[self showErrorAlert:errorString];
	
	isUplaodingphoto=NO;
}

#pragma mark -
#pragma mark ACCameraViewController Delegate Function Methods

- (void)ACCameraViewControllerDelegateDidFinishPickingImage:(UIImage *)image
{
	photoImageView.image=image;
	[self dismissModalViewControllerAnimated:NO];
	
	NSData *data= UIImageJPEGRepresentation(photoImageView.image, 1);
	[self uploadPhotoConnection:network imageData:data];
	isUplaodingphoto=YES;
	
}

- (void)ACCameraViewControllerDelegateCancelImagePicker
{
	[self dismissModalViewControllerAnimated:NO];
}



@end
