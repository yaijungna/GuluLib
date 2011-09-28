//
//  PostAddNewRestaurantViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/10.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "PostAddNewRestaurantViewController.h"

@implementation PostAddNewRestaurantViewController

@synthesize name,numberOfpageToGoBack;

- (void)setCurrentLocation:(CLLocation *)location 
{
	MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
	region.center = location.coordinate;
	region.span.longitudeDelta = 0.001f;
	region.span.latitudeDelta = 0.001f;
	[mapView setRegion:region animated:YES];
}

- (void) initMapView
{	
	
	mapView.mapType = MKMapTypeStandard;   
	mapView.delegate=self;
	
	anno=[[addPhoneAnnotation alloc] initWithCoordinate:appDelegate.userMe.myLocation.coordinate addressDictionary:nil] ;
	anno.title=@" ";
	anno.subtitle=@"";
	[self setCurrentLocation:appDelegate.userMe.myLocation];
	[mapView addAnnotation:anno];
	
	[mapView selectAnnotation:anno animated:YES];

}

- (void) initViewController
{
	mapView=[[MKMapView alloc] initWithFrame:CGRectMake(0, -70, 320, 530)];
	[self.view addSubview:mapView];
	[self initMapView];
	
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
	[self.view addSubview:topView];
	[topView release];
	
	
	[topView.topLeftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topMiddleButton addTarget:self action:@selector(landingAction) forControlEvents:UIControlEventTouchUpInside];

	spinView=[[loadingSpinnerAndMessageView alloc] init] ;
	[self.view addSubview:spinView];
	spinView.hidden=YES;
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initViewController];
    
    if(![ACCheckConnection isConnectedToNetwork])
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
    
    ACNetworkManager *net=[ACNetworkManager sharedManager];
	[net cancelAllRequestsInRequestsQueue];
    
	[mapView release];
	[name release];
    [anno release];
    [spinView release];
    [super dealloc];
}

#pragma mark -
#pragma mark  Function Methods

- (void)backAction 
{
	ACNetworkManager *net=[ACNetworkManager sharedManager];
	[net cancelAllRequestsInRequestsQueue];
	
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)landingAction
{
	ACNetworkManager *net=[ACNetworkManager sharedManager];
	[net cancelAllRequestsInRequestsQueue];
	
	[self.navigationController popToRootViewControllerAnimated:YES];
}

/***** UNUSED ****

- (NSString *) getIPAddress 
{
	NSString *ip;
	NSURL *ipURL= [NSURL URLWithString:@"http://www.whatismyip.com/automation/n09230945.asp"];
	ASIHTTPRequest *ipRequest = [[[ASIHTTPRequest alloc] initWithURL:ipURL] autorelease];
	[ipRequest startSynchronous];
	if ([ipRequest error]) {
		ip=[[NSString alloc] initWithFormat:@"127.0.0.1" ];}
	else {
		ip=[[NSString alloc] initWithFormat:@"%@",[ipRequest responseString]];}
	
	[ip autorelease];
	return ip;
}
**************/

- (void)addAction
{
    
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }
    
	[self showSpinnerView:spinView mesage:GLOBAL_LOADING_STRING];
//	[mapView setUserInteractionEnabled:NO];
	
	NSString *preferLanguage;
	NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
	NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
	if([[languages objectAtIndex:0] isEqualToString:@"zh-Hant"]){
		preferLanguage=@"zh-tw,en-us";}
	else {
		preferLanguage=@"en-us,zh-tw";}
	/*
	NSString *tempURL= [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?latlng=%f,%f&sensor=true",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude];
	NSURL *searchURL = [NSURL URLWithString:tempURL];
	ASIHTTPRequest *googleRequest = [[ASIHTTPRequest alloc] initWithURL:searchURL];
	//[googleRequest addRequestHeader:@"Referer" value:[self getIPAddress]]; 
	[googleRequest addRequestHeader:@"accept-language" value:preferLanguage];
	googleRequest.delegate= self;
	[googleRequest startAsynchronous];
	*/
	
	ACNetworkManager *net=[ACNetworkManager sharedManager];
	
	NSMutableDictionary *ADDdict=[[[NSMutableDictionary alloc] init] autorelease];
	[ADDdict setObject:@"google" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:[NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?latlng=%f,%f&sensor=true", anno.coordinate.latitude,anno.coordinate.longitude]
                                    keyValueDictionary:nil 
									 addtionDictionary:ADDdict];
	request.delegate=self;
	[request setDidFinishSelector:@selector(requestFinished:)];
	[request setDidFailSelector:@selector(requestFailed:)];
	[request addRequestHeader:@"accept-language" value:preferLanguage];
	[net addRequestToRequestsQueue:request];

}


#pragma mark -
#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
	
	if (oldState == MKAnnotationViewDragStateDragging) {
		anno = (addPhoneAnnotation *)annotationView.annotation;
        ACLog(@"%f,%f",anno.coordinate.latitude,anno.coordinate.longitude);
	}
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]){
		return nil;}
   
	static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
	MKPinAnnotationView* pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    
	if (!pinView)
	{
		MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
											   initWithAnnotation:annotation 
											   reuseIdentifier:AnnotationIdentifier] autorelease];
		
		customPinView.pinColor = MKPinAnnotationColorRed;
		customPinView.animatesDrop = YES;
		customPinView.canShowCallout = YES;
        customPinView.draggable=YES;
        [customPinView setSelected:YES animated:YES];
		
		addRestaurantAnnotaionView *text=[[[addRestaurantAnnotaionView alloc] initWithFrame:CGRectMake(0, 0, 230, 30)] autorelease];
		[self customizeTextField:text.phoneTextField];
		text.phoneTextField.delegate=self;
		[text.phoneTextField becomeFirstResponder];
		[text.phoneTextField setFont:[UIFont fontWithName:FONT_NORMAL size:12]];
		[text.phoneTextField setKeyboardType: UIKeyboardTypePhonePad];
		customPinView.leftCalloutAccessoryView =text;
		text.phoneTextField.placeholder=NSLocalizedString(@"Add phone number",@"add phone number placeholder in post");
		text.nameLabel.text=name;
		
		tempTextField=text.phoneTextField;
		
		UIButton *btn=[[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30) ] autorelease];
		[btn setBackgroundImage:[UIImage imageNamed:@"button-1.png"] forState:UIControlStateNormal];
		[btn setTitle:NSLocalizedString(@"Add",@"add new place in post") forState:UIControlStateNormal];
		[btn.titleLabel setTextColor:[UIColor whiteColor]];
		[btn.titleLabel setFont:[UIFont fontWithName:FONT_NORMAL size:12]];
		[btn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
		
		customPinView.rightCalloutAccessoryView=btn;
		
		return customPinView;
	}
	else
	{
		pinView.annotation = annotation;
	}
	
	return pinView;
    

}

#pragma mark -
#pragma mark TextField Delegate Function Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	[self setCurrentLocation:[[[CLLocation alloc] initWithLatitude:anno.coordinate.latitude longitude:anno.coordinate.longitude] autorelease] ];
	return YES;	
}

#pragma mark -
#pragma mark google API Function Methods

- (NSString *)findCity :(NSArray *)address_components
{
    
    NSLog(@"%@",address_components);
    
    NSString *cityStr;
    
    for(NSDictionary *compenetDict in address_components)
    {
        NSArray *typesArr=[compenetDict objectForKey:@"types"];
        NSLog(@"%@",typesArr);
    
        for(NSString *typeStr in typesArr)
        {
            if([typeStr isEqualToString:@"locality"])
            {
                cityStr=[compenetDict objectForKey:@"long_name"];
                NSLog(@"%@",cityStr);
                return cityStr;
            }
        
        }
    }
    
    cityStr=@"unkown";
    return cityStr;


}

- (void)setupData :(NSDictionary *)resultsDictionary
{
    NSArray *resultArray=[resultsDictionary objectForKey:@"results"];

    NSString *city=[self findCity:[[resultArray objectAtIndex:0] objectForKey:@"address_components"]];
    NSString *region=@"";
	
    NSString *address=[[resultArray objectAtIndex:0] objectForKey:@"formatted_address"];
	
	NSString *phone =[NSString stringWithFormat:@"%@",tempTextField.text];
	
	
	NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];

	[dict setObject:[NSString stringWithFormat:@"%f",anno.coordinate.latitude] forKey:@"latitude"];
	[dict setObject:[NSString stringWithFormat:@"%f",anno.coordinate.longitude] forKey:@"longitude"];

	[dict setObject:city forKey:@"city"];
	[dict setObject:region forKey:@"region"];
	[dict setObject:address forKey:@"address"];
	[dict setObject:phone forKey:@"phone"];
	[dict setObject:name forKey:@"name"];
//	appDelegate.temp.postObj.restaurantDict=dict;
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangePostRestaurantDictionary" object:dict];
}

- (void)requestFinished:(ASIFormDataRequest *)googleRequest
{	
	[self hideSpinnerView:spinView];
	[mapView setUserInteractionEnabled:YES];
	[tempTextField resignFirstResponder];
	
	NSData *response= [googleRequest responseData];
	CJSONDeserializer *jsonDeserializer= [CJSONDeserializer deserializer];
	NSError *error;
	NSDictionary *resultsDictionary= [jsonDeserializer deserializeAsDictionary:response error:&error];
    
    
 //   ACLog(@"%@",resultsDictionary);
	
	if ([[resultsDictionary objectForKey:@"status"] isEqualToString:@"OK"])
	{
		[self setupData:resultsDictionary];
		[self backAction];
	} 
	else
	{
		NSLog(@"[PostAddNewRestaurantViewController.m] google status failed");
	}
}

- (void)requestFailed:(ASIFormDataRequest *)googleRequest
{
	[self hideSpinnerView:spinView];
	[mapView setUserInteractionEnabled:YES];
	[tempTextField resignFirstResponder];
}

@end
