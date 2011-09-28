//
//  mapViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/15.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "mapViewController.h"


@implementation mapViewController

@synthesize place;

- (void)setCurrentLocation:(CLLocation *)location 
{
	MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
	region.center = location.coordinate;
	region.span.longitudeDelta = 0.002f;
	region.span.latitudeDelta = 0.002f;
	[mapView setRegion:region animated:YES];
}


- (void) initMapView
{	
	
	mapView.mapType = MKMapTypeStandard;   
	mapView.delegate=self;
	mapView.showsUserLocation=YES;
	
	mapAnnotation *anno=[[mapAnnotation alloc] init];
	anno.title=place.name;
	anno.subtitle=@"";
	
	CLLocation *Location = [[[CLLocation alloc] initWithLatitude:place.latitude 
													  longitude:place.longitude] autorelease]; 
	
	anno.theCoordinate=Location.coordinate;
	[self setCurrentLocation:Location];
	[mapView addAnnotation:anno];
	[anno release];
	
	[mapView selectAnnotation:anno animated:YES];
	
}


- (void)viewDidLoad {
    [super viewDidLoad];
	[self shareGULUAPP];
	
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
	[self.view addSubview:topView];
	[topView release];
	
	bottomView=[[[BottomMenuBarView alloc] initWithFrame:CGRectMake(0, 410, 320, 50)] initOneBtnsBottomBarView:ButtonTypeCurrentLoaction];
	[self.view addSubview:bottomView];
	[bottomView release];
	
	
	[topView.topLeftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topMiddleButton addTarget:self action:@selector(landingAction) forControlEvents:UIControlEventTouchUpInside];
	
	[bottomView.bottomButton1 addTarget:self action:@selector(currentLocationAction) forControlEvents:UIControlEventTouchUpInside];
	
	[self initMapView];
	
}

- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
}

- (void)dealloc {
	[place release];
    [super dealloc];
}

#pragma mark -
#pragma mark  Function Methods

- (void)backAction 
{
	mapView.delegate=nil;
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)landingAction
{
	mapView.delegate=nil;
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)currentLocationAction 
{
	[self setCurrentLocation:mapView.userLocation.location];
}


#pragma mark -
#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[MKUserLocation class]])
		return nil;
	
	static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
	MKPinAnnotationView* pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
	if (!pinView)
	{
		MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
											   initWithAnnotation:annotation 
											   reuseIdentifier:AnnotationIdentifier] autorelease];
		
		customPinView.pinColor = MKPinAnnotationColorRed;
		customPinView.animatesDrop = YES;
		customPinView.canShowCallout = YES;;
	
		UIButton *btn=[UIButton buttonWithType:UIButtonTypeDetailDisclosure ];
		customPinView.rightCalloutAccessoryView=btn;
		
		return customPinView;
	}
	else
	{
		pinView.annotation = annotation;
        
	}
	
	return pinView;

}




@end
