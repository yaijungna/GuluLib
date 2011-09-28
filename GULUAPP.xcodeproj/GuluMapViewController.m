//
//  GuluMapViewController.m
//  GULUAPP
//
//  Created by alan on 11/9/27.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluMapViewController.h"

@implementation GuluMapViewController

@synthesize place;


-(void)setLocationregion:(CLLocation *)location 
{
	MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
	region.center = location.coordinate;
	region.span.longitudeDelta = 0.002f;
	region.span.latitudeDelta = 0.002f;
	[mapView setRegion:region animated:YES];
}

- (void) initMapView
{	
    
    mapView=[[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320,460)];
    
    [self.view addSubview:mapView];
	mapView.mapType = MKMapTypeStandard;   
	mapView.delegate=self;
	mapView.showsUserLocation=YES;
    

    GuluAnnotation *anno=[[[GuluAnnotation alloc] init] autorelease];
    anno.title=place.name;
    anno.subtitle=@"";
    
    CLLocation *Location = [[[CLLocation alloc] initWithLatitude:place.latitude 
                                                       longitude:place.longitude] autorelease]; 
    
    [self setLocationregion:Location];
    
    anno.theCoordinate=Location.coordinate;
    [mapView addAnnotation:anno];
    [mapView selectAnnotation:anno animated:YES];
    
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
		customPinView.canShowCallout = YES;

        
	//	UIButton *btn=[UIButton buttonWithType:UIButtonTypeDetailDisclosure ];
	//	customPinView.rightCalloutAccessoryView=btn;
		
		return customPinView;
	}
	else
	{
		pinView.annotation = annotation;
	}
	
	return pinView;
    
}


@end
