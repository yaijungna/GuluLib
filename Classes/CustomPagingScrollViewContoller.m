//
//  CustomPagingScrollViewContoller.m
//  guluapp
//
//  Created by chen alan on 2011/5/2.
//  Copyright 2011 Gulu.com. All rights reserved.
//

/*============================
 -----------------
 How to use:
 -----------------
 
 
 ================================= */

#import "CustomPagingScrollViewContoller.h"

@implementation CustomPagingScrollViewContoller


- (void)viewDidLoad {
    [super viewDidLoad];
	
	pageView=[[ACPagableScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
	pageView.ACDelegate=self;
	[pageView initScrollView];
	[self.view addSubview:pageView];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}


#pragma mark -
#pragma mark delegate Methods

-(NSInteger ) ACPagableScrollViewNumberOfPage{return 10;}

-(NSInteger ) ACPagableScrollViewStartAtIndex{return 1;}

-(void) ACPagableScrollViewAtIndexOfScrollView : (id)viewAtIndex currentIndex:(NSInteger)index;
{
	
	NSArray *temparray=[viewAtIndex subviews];
	for(id tempObj in temparray)
	{
		NSLog(@"%@",tempObj);
		[tempObj removeFromSuperview];
	}
	
	UILabel *ll=[[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
	ll.text=@"ff";
	[viewAtIndex addSubview:ll];
	[ll release];

}

-(NSString *) ACPagableScrollViewClassOfView
{
	return @"UIView";
}

-(void) gotonext:(UIButton *)btn
{
	[pageView gotoCurrentPage:8];
	
}



@end
