//
//  RestaurantProfileViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/16.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "RestaurantProfileViewController.h"

@implementation RestaurantProfileViewController

@synthesize place;
@synthesize reviewRequest;
@synthesize dishRequest;

@synthesize photoArray,dishArray,reviewArray;


-(void)initViewController
{
	NSArray  *array=[NSArray arrayWithObjects:NSLocalizedString(@"All Reviews", @"[restaurant profile]"),NSLocalizedString(@"Dishes", @"[restaurant profile]"),nil];
	
	segment=[[ACSegmentController alloc] initWithFrame:CGRectMake(0, 40, 320, 40)];
	
	[segment initCustomSegment:array normalimage:[UIImage imageNamed:@"seg02-2.png"] selectedimage:[UIImage imageNamed:@"seg02-1.png"]  textfont:[UIFont fontWithName:FONT_BOLD size:12]];

	[segment setSelectedButtonAtIndex:0];
	segment.delegate=self;
	[myView addSubview:segment];
	[segment release];
	
	restaurantView=[[RestaurantProfileView alloc] initWithFrame:CGRectMake(0, 90, 320, 120)];
	[myView addSubview:restaurantView];
	[restaurantView release];
	
	[self customizeLabel_title:restaurantView.titleLabel];
	[self customizeLabel:restaurantView.addressLabel];
	[self customizeLabel:restaurantView.phoneLabel];
	[self customizeLabel_title:restaurantView.follwersLabel];
	[self customizeLabel_title:restaurantView.reviewsLabel];
	[self customizeLabel:restaurantView.follwersNumberLabel];
	[self customizeLabel:restaurantView.reviewsNumberLabel];
	[GuluUtility addBackgroundFrame:restaurantView.imageView backgroundImage:[UIImage imageNamed:@"big_photo_frame.png"] distance:3];
	
	
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
	[self.view addSubview:topView];
	[topView release];

	[topView.topLeftButton	addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topMiddleButton addTarget:self action:@selector(landingAction) forControlEvents:UIControlEventTouchUpInside];

     bottomView=[[[BottomMenuBarView alloc] initWithFrame:CGRectMake(0, 410, 320, 50)] initFourBottomsBarBottomView:ButtonTypeMap second:ButtonTypeInvite third:ButtonTypeAddTodo forth:ButtonTypeAddFavorite];
	[self.view addSubview:bottomView];
	[bottomView release];
	
    [((ACButtonWIthBottomTitle *)bottomView.bottomButton1).btn addTarget:self action:@selector(mapAction) forControlEvents:UIControlEventTouchUpInside];
	[((ACButtonWIthBottomTitle *)bottomView.bottomButton2).btn addTarget:self action:@selector(inviteAction) forControlEvents:UIControlEventTouchUpInside];
    [((ACButtonWIthBottomTitle *)bottomView.bottomButton3).btn addTarget:self action:@selector(todoAction) forControlEvents:UIControlEventTouchUpInside];
	[((ACButtonWIthBottomTitle *)bottomView.bottomButton4).btn addTarget:self action:@selector(favoriteAction) forControlEvents:UIControlEventTouchUpInside];
	
	table =[[GuluTableView alloc] initWithFrame:CGRectMake(0, 210, 320, 200) pullToRefresh:YES];
	table.delegate=self;
	table.dataSource=self;
    table.refreshDelegate=self;
    table.backgroundColor=[UIColor clearColor];
	[myView addSubview:table];
	[table release];
	
	spinView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:spinView];
	spinView.hidden=YES;
	
}

- (void)showData 
{
	restaurantView.titleLabel.text=place.name;
	restaurantView.addressLabel.text=place.address;	
	
	restaurantView.follwersNumberLabel.text=@"0";
	restaurantView.reviewsNumberLabel.text=@"0";
	
    [restaurantView.imageView setImageWithURL:[NSURL URLWithString:place.photo.image_medium]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initViewController];
	[self showData];
	
    table.userInteractionEnabled=NO;
    [self showSpinnerView:spinView mesage:GLOBAL_LOADING_STRING];
    [self getResturantDish];
    [self getResturantReview];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	
	[super viewDidUnload];
}


- (void)dealloc {
    
    [place release];
    
    [reviewRequest release];
    [dishRequest release];
    
	[photoArray release];
	[dishArray release];
	[reviewArray release];
    
    [spinView release];
	
    [super dealloc];
}

#pragma mark -
#pragma mark action Function Methods

- (void)backAction 
{	
    [reviewRequest cancel];
    [dishRequest cancel];
    
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)landingAction 
{
    [reviewRequest cancel];
    [dishRequest cancel];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)favoriteAction
{	
	[self showSpinnerView:spinView mesage:GLOBAL_LOADING_STRING];
	table.userInteractionEnabled=NO;
    [[GuluAPIAccessManager sharedManager] favoriteSomething:self target_id:place.ID target_type:GuluTargetType_place];
}

- (void)todoAction
{
	[self showSpinnerView:spinView mesage:GLOBAL_LOADING_STRING];
	table.userInteractionEnabled=NO;
    [[GuluAPIAccessManager sharedManager] addPlaceToToDoList:self place_id:place.ID];
}

- (void)gotoProfile:(UIButton *)btn
{
    int index=btn.tag;
    
    if(table.tag==0)  //review
    {
        if(index >= [tableArray count]){
            return;
        }
        
        GuluReviewModel *review=[tableArray objectAtIndex:index];

        reviewProfileViewController *VC=[[reviewProfileViewController alloc] initWithNibName:@"reviewProfileViewController" bundle:nil];
        VC.reviewModel=review;
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
    }
    
    if(table.tag==1) //dish
    {
        if(index >= [tableArray count]){
            return;
        }
        
        GuluDishModel *dish=[tableArray objectAtIndex:index];
        
        
        dishProfileViewController *VC=[[dishProfileViewController alloc] initWithNibName:@"dishProfileViewController" bundle:nil];	
        VC.dish=dish;
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
    }
}

#pragma mark -
#pragma mark action Function Methods

- (void)mapAction 
{
    [self gotoMap:place];	
}


- (void)inviteAction
{
	EventViewController *VC=[[EventViewController alloc] initWithNibName:@"EventViewController" bundle:nil];	
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];
}

#pragma mark -
#pragma mark segment Delegate Function Methods

- (void) touchSegmentAtIndex:(NSInteger)segmentIndex
{
	if(segmentIndex==0)  //review
	{
		tableArray=reviewArray;
		table.tag=0;
		[table reloadData];
	}
	else if(segmentIndex==1) //dish
	{
		tableArray=dishArray;
		table.tag=1;
		[table reloadData];
	}
}

#pragma mark -
#pragma mark Table Delegate Function Methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return ([tableArray count]+2)/3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 130;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    GuluTableViewCell_3Images *cell=[GuluTableViewCell cellForIdentifierOfTable:@"GuluTableViewCell_3Images" table:theTableView];
    
    NSInteger  number=[tableArray count];
	NSInteger  index1=indexPath.row*3;
	NSInteger  index2=indexPath.row*3+1;
	NSInteger  index3=indexPath.row*3+2;
    
    cell.btn1.tag=index1;
    cell.btn2.tag=index2;
    cell.btn3.tag=index3;
    
    [cell.btn1 addTarget:self action:@selector(gotoProfile:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn2 addTarget:self action:@selector(gotoProfile:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn3 addTarget:self action:@selector(gotoProfile:) forControlEvents:UIControlEventTouchUpInside];
    
    if(table.tag==0) //review
	{
        
        if(index1<number)
        {
            GuluReviewModel *review=[tableArray objectAtIndex:index1];
            [cell.btn1 setBackgroundImageWithURL:[NSURL URLWithString:review.photo.image_medium] forState:UIControlStateNormal];
        }
        if(index2<number)
        {
            GuluReviewModel *review=[tableArray objectAtIndex:index2];
            [cell.btn2 setBackgroundImageWithURL:[NSURL URLWithString:review.photo.image_medium] forState:UIControlStateNormal];
        }
        if(index3<number)
        {
            GuluReviewModel *review=[tableArray objectAtIndex:index3];
            [cell.btn3 setBackgroundImageWithURL:[NSURL URLWithString:review.photo.image_medium] forState:UIControlStateNormal];
        }
    }
    else if(table.tag==1) //dish
	{ 
        if(index1<number)
        {
            GuluDishModel *dish=[tableArray objectAtIndex:index1];
            [cell.btn1 setBackgroundImageWithURL:[NSURL URLWithString:dish.photo.image_medium] forState:UIControlStateNormal];

        }
        if(index2<number)
        {
            GuluDishModel *dish=[tableArray objectAtIndex:index2];
            [cell.btn2 setBackgroundImageWithURL:[NSURL URLWithString:dish.photo.image_medium] forState:UIControlStateNormal];
        }
        if(index3<number)
        {
            GuluDishModel *dish=[tableArray objectAtIndex:index3];
            [cell.btn3 setBackgroundImageWithURL:[NSURL URLWithString:dish.photo.image_medium] forState:UIControlStateNormal];
        }
    }    
    
    return  cell;
    
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark -
#pragma mark request Delegate Function Methods

- (void)getResturantDish
{	
    [dishRequest cancel];
    
    self.dishRequest=[[GuluAPIAccessManager sharedManager] dishesOfPlace:self placeID:place.ID];
}

- (void)getResturantReview
{	
    [reviewRequest cancel];
    
    self.reviewRequest=[[GuluAPIAccessManager sharedManager] reviewsOfPlace:self placeID:place.ID];
}


- (void)GuluAPIAccessManagerSuccessed:(GuluHttpRequest*)httpRequest info:(id)info
{
    [self hideSpinnerView:spinView];
	table.userInteractionEnabled=YES;
    
    if([info isKindOfClass:[GuluErrorMessageModel class]])
    {
        return;
    }
    
	if( httpRequest == dishRequest)
	{
		self.dishArray=[[[NSMutableArray alloc] initWithArray:info] autorelease];
    }
    
    if( httpRequest == reviewRequest )
	{
		self.reviewArray=[[[NSMutableArray alloc] initWithArray:info] autorelease];
		
		table.tag=0;
		tableArray=reviewArray;
		[table reloadData];
	}
}

- (void)GuluAPIAccessManagerFailed:(GuluHttpRequest*)httpRequest info:(id)info
{
    [self hideSpinnerView:spinView];
	table.userInteractionEnabled=YES;
}

#pragma mark Gulutable Delegate and Function Methods

-(void)GuluTableViewRefreshDelegateTrgger :(GuluTableView *)guluTable; // drag down and release will trigger this function  
{
    [table performSelector:@selector(doneLoadingGuluRefreshTableViewData) withObject:nil afterDelay:0.2];

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [table.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];	
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [table.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];	
}

@end
