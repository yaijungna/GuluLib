//
//  ACPagableScrollView.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACPagableScrollView.h"

@implementation ACPagableScrollView
@synthesize ACDelegate;
@synthesize viewLeft;
@synthesize viewMiddle;
@synthesize viewRight;


-(void)initScrollView
{
	self.delegate=self;
	self.pagingEnabled=YES;
	self.autoresizesSubviews=NO;
	self.showsVerticalScrollIndicator = NO;
	self.showsHorizontalScrollIndicator = NO;
	
	CGSize pageSize = CGSizeMake(self.frame.size.width*[ACDelegate ACPagableScrollViewNumberOfPage], self.frame.size.height);
	[self setContentSize:pageSize];
	
	//self.viewLeft=[[UIView alloc] init];
	//self.viewMiddle=[[UIView alloc] init];
	//self.viewRight=[[UIView alloc] init];

	self.viewLeft=[[[NSClassFromString([ACDelegate ACPagableScrollViewClassOfView]) alloc] init] autorelease];
	self.viewMiddle=[[[NSClassFromString([ACDelegate ACPagableScrollViewClassOfView]) alloc] init] autorelease];
	self.viewRight=[[[NSClassFromString([ACDelegate ACPagableScrollViewClassOfView]) alloc] init] autorelease];
	
	if([ACDelegate ACPagableScrollViewNumberOfPage]==1)
	{
		[self addSubview:viewLeft];
	}
	else if([ACDelegate ACPagableScrollViewNumberOfPage]==2) 
	{
		[self addSubview:viewLeft];
		[self addSubview:viewMiddle];
	}
	else {
		[self addSubview:viewLeft];
		[self addSubview:viewMiddle];
		[self addSubview:viewRight];
	}
	
//	[viewLeft release];
//	[viewMiddle release];
//	[viewRight release];
	
	//=======================================================================
	
	Array=[[NSMutableArray alloc] init];
	
	for( int i=0;i<[ACDelegate ACPagableScrollViewNumberOfPage];i++){
		[Array addObject:[NSNull null]];}
	
	//=======================================================================
	
	currentIndex = [ACDelegate ACPagableScrollViewStartAtIndex];
	lastIndex=currentIndex;
	
	if([Array count]==1)
	{
		[Array replaceObjectAtIndex:currentIndex withObject:viewLeft];
	}
	else if([Array count]==2) 
	{
		[Array replaceObjectAtIndex:0 withObject:viewLeft];
		[Array replaceObjectAtIndex:1 withObject:viewMiddle];
	}
	else {
		if(currentIndex==0)  //first
		{
			[Array replaceObjectAtIndex:0 withObject:viewLeft];
			[Array replaceObjectAtIndex:1 withObject:viewMiddle];
			[Array replaceObjectAtIndex:2 withObject:viewRight];
		}
		else if(currentIndex==[Array count]-1)  //last
		{
			[Array replaceObjectAtIndex:[Array count]-3 withObject:viewLeft];
			[Array replaceObjectAtIndex:[Array count]-2 withObject:viewMiddle];
			[Array replaceObjectAtIndex:[Array count]-1 withObject:viewRight];
		}
		else 
		{
			[Array replaceObjectAtIndex:currentIndex-1 withObject:viewLeft];
			[Array replaceObjectAtIndex:currentIndex withObject:viewMiddle];
			[Array replaceObjectAtIndex:currentIndex+1 withObject:viewRight];
		}
	}
	
	//=======================================================================
	[self resetFrame:currentIndex];
	
	CGPoint position=CGPointMake(self.frame.size.width*currentIndex, 0);
	[self setContentOffset:position]; 
	
//	[viewLeft setBackgroundColor:[UIColor blueColor]];
//	[viewMiddle setBackgroundColor:[UIColor redColor]];
//	[viewRight setBackgroundColor:[UIColor greenColor]];
}

- (void)dealloc {
	[Array release];
	[viewLeft release];
	[viewMiddle release];
	[viewRight release];
    [super dealloc];
}

#pragma mark -
#pragma mark  Function Methods

-(void)resetFrame :(NSInteger)page
{
	CGRect frame=self.frame;
	
	if(page-1>=0 && page-1 <[Array count])
	{
		id temp_1	=[Array objectAtIndex:page-1];
		
		if(temp_1==nil || [temp_1 isEqual:[NSNull null]]){
			[Array replaceObjectAtIndex:page-1 withObject:[Array objectAtIndex: (page+2)] ];
			temp_1=[Array objectAtIndex:page-1];}
		[temp_1 setFrame:CGRectMake((page-1)*frame.size.width, 0, frame.size.width,frame.size.height)];
		
	/*	NSArray *temparray=[temp_1 subviews];
		for(id tempObj in temparray)
			[tempObj removeFromSuperview]; */
		
		[ACDelegate ACPagableScrollViewAtIndexOfScrollView:temp_1 currentIndex:page-1];
	}
	if(page+1<[Array count] && page+1>=0)
	{
		id temp1	=[Array objectAtIndex:page+1];
		
		if(temp1==nil || [temp1 isEqual:[NSNull null]]){
			[Array replaceObjectAtIndex:page+1 withObject:[Array objectAtIndex: (page-2)] ];
			temp1=[Array objectAtIndex:page+1];}
		[temp1 setFrame:CGRectMake((page+1)*frame.size.width, 0, frame.size.width,frame.size.height)];
		
	/*	NSArray *temparray=[temp1 subviews];
		for(id tempObj in temparray)
			[tempObj removeFromSuperview]; */
		
		[ACDelegate ACPagableScrollViewAtIndexOfScrollView:temp1 currentIndex:page+1];
	}
	if( 0<=page && page<[Array count])
	{
		id temp	= [Array objectAtIndex:page];
		[temp setFrame:CGRectMake(page*frame.size.width, 0, frame.size.width,frame.size.height)];	
		
	/*	NSArray *temparray=[temp subviews];
		for(id tempObj in temparray)
			[tempObj removeFromSuperview]; */
		
		[ACDelegate ACPagableScrollViewAtIndexOfScrollView:temp currentIndex:page];
	}
}

-(int)getCurrentPage
{
	int page = round(self.contentOffset.x / self.frame.size.width);
	
	if(page<0){
		page=0;}
	if(page>=[Array count]){
		page=[Array count]-1;}
	
	return page;
}


-(void)gotoCurrentPage : (NSInteger) index
{
	
	if(index >=[Array count] || index<0)
		return;
	
	currentIndex=index;
	lastIndex=currentIndex;
	
	if([Array count]==1)
	{
		[Array replaceObjectAtIndex:currentIndex withObject:viewLeft];
	}
	else if([Array count]==2) 
	{
		[Array replaceObjectAtIndex:0 withObject:viewLeft];
		[Array replaceObjectAtIndex:1 withObject:viewMiddle];
	}
	else 
	{
		if(currentIndex==0)  //first
		{
			[Array replaceObjectAtIndex:0 withObject:viewLeft];
			[Array replaceObjectAtIndex:1 withObject:viewMiddle];
			[Array replaceObjectAtIndex:2 withObject:viewRight];
		}
		else if(currentIndex==[Array count]-1)  //last
		{
			[Array replaceObjectAtIndex:[Array count]-3 withObject:viewLeft];
			[Array replaceObjectAtIndex:[Array count]-2 withObject:viewMiddle];
			[Array replaceObjectAtIndex:[Array count]-1 withObject:viewRight];
		}
		else 
		{
			[Array replaceObjectAtIndex:currentIndex-1 withObject:viewLeft];
			[Array replaceObjectAtIndex:currentIndex withObject:viewMiddle];
			[Array replaceObjectAtIndex:currentIndex+1 withObject:viewRight];
		}
	}
	
	//=======================================================================
	[self resetFrame:currentIndex];
	
	CGPoint position=CGPointMake(self.frame.size.width*currentIndex, 0);
	[self setContentOffset:position]; 
}


#pragma mark -
#pragma mark scroll delgate Function Methods

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
	currentIndex = [self getCurrentPage];
	//NSLog(@"%d",currentIndex);
	
	if(lastIndex==currentIndex)
	{
		return;  //do nothing
	}
	else 
	{
		[self resetFrame:currentIndex];	
		lastIndex=currentIndex;
	}
	
}



@end
