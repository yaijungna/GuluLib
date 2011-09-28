//
//  GuluBasicViewController.m
//  GULUAPP
//
//  Created by alan on 11/9/22.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluBasicViewController.h"

@implementation GuluBasicViewController

@synthesize loadingSpinner;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = (GULUAPPAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    loadingSpinner=[[UIActivityIndicatorView alloc] init];
    [loadingSpinner setHidesWhenStopped:YES];
    [loadingSpinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loadingSpinner.frame=CGRectMake(self.view.center.x-18,self.view.center.y-18,36,36);
    [self.view insertSubview:loadingSpinner atIndex:99];
    [loadingSpinner stopAnimating];
    
    APIManager=[GuluAPIAccessManager sharedManager];
    guluUserInfo=appDelegate.GuluUser;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.loadingSpinner=nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
	[loadingSpinner release];
    [super dealloc];
}




@end
