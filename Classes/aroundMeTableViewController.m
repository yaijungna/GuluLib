//
//  aroundMeTableViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/19.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "aroundMeTableViewController.h"
#import "ACTableMyPostCell.h"
#import "ACTableAroundMeCell.h"
#import "UserHeaderView.h"

#import "commentViewController.h"
#import "userProfileViewController.h"
#import "userFriendProfileViewController.h"

#import "reviewProfileViewController.h"
#import "TimeAgoFormat.h"

#import "UIImageView+WebCache.h"


@implementation aroundMeTableViewController

@synthesize postArray;

@synthesize navigationController;

- (void)viewDidLoad {
    [super viewDidLoad];
	[self customizeTableView:self.tableView];
	[self.tableView setFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 335)];
	
	[self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
	
	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.tableView addSubview:LoadingView];
	LoadingView.hidden=YES;
	

//	[self performSelector:@selector(getMyPost) withObject:nil afterDelay:2.0];	
//  [self getMyPost];
    
    if([ACCheckConnection isConnectedToNetwork])
    {
        [self performSelector:@selector(getMyPost) withObject:nil afterDelay:2.0];
    }


	
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	UserHeaderView *view1 = [[[UserHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];
    view1.tag=section;
	
	NSString *name=[[[postArray objectAtIndex:section] objectForKey:@"user"] objectForKey:@"username"];
    NSString *uid=[[[postArray objectAtIndex:section] objectForKey:@"user"] objectForKey:@"id"];
    NSString *time=[[postArray objectAtIndex:section] objectForKey:@"time_ago"] ;

    [view1.nameBtn setTitle:name forState:UIControlStateNormal];
     view1.rightLabel.text=[TimeAgoFormat TimeAgoString:time];
    
    if([appDelegate.userMe.uid isEqualToString:uid])
    {
        [view1.nameBtn addTarget:self action:@selector(gotoUserProfile) forControlEvents:UIControlEventTouchUpInside];
	}
    else
    {
        [view1.nameBtn addTarget:self action:@selector(gotoFriendProfile:) forControlEvents:UIControlEventTouchUpInside];
    }
//	[self customizeImageView_cell:view1.imageView];
    
 //   [GuluUtility addBackgroundFrame:view1.imageView backgroundImage:[UIImage imageNamed:@"big_photo_frame.png"] distance:8];
	
    NSString *url_key=[[[[postArray objectAtIndex:section] objectForKey:@"user" ]objectForKey:@"photo"] objectForKey:@"image_small"];
    [view1.imageView setImageWithURL:[NSURL URLWithString:url_key]];

	
	return view1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 340;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [postArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellIdentifier = @"ACTableAroundMeCell";
	static NSString *nibNamed = @"ACTableAroundMeCell";
	
	ACTableAroundMeCell *cell = (ACTableAroundMeCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil];
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell= (ACTableAroundMeCell*) currentObject;
				[cell initCell];
			//	[self customizeImageView:cell.bigPhotoImageView];
                 [GuluUtility addBackgroundFrame:cell.bigPhotoImageView backgroundImage:[UIImage imageNamed:@"big_photo_frame.png"] distance:8];
				[cell.likeBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
                
                //======
                
                [cell.moreBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.more.mapbtn.btn addTarget:self action:@selector(mapAction:) forControlEvents:UIControlEventTouchUpInside];
				[cell.more.favoritebtn.btn addTarget:self action:@selector(favoriteAction:) forControlEvents:UIControlEventTouchUpInside];
				[cell.more.todobtn.btn addTarget:self action:@selector(todoAction:) forControlEvents:UIControlEventTouchUpInside];
				[cell.more.invitebtn.btn addTarget:self action:@selector(inviteAction:) forControlEvents:UIControlEventTouchUpInside];
                
                //=====
                [cell.firstBtn addTarget:self action:@selector(gotoDishProfile:) forControlEvents:UIControlEventTouchUpInside];
                [cell.secondBtn addTarget:self action:@selector(gotoRestaurantProfile:) forControlEvents:UIControlEventTouchUpInside];
			}
		}
	}
	
    //==============================
	
	NSDictionary *restaurantDict=[[postArray objectAtIndex:indexPath.section] objectForKey:@"restaurant"];
	NSString *restaurantName=[restaurantDict objectForKey:@"name"];
    
    NSString *review=[[postArray objectAtIndex:indexPath.row] objectForKey:@"content"];
    
    cell.placeName=restaurantName;
    cell.review=review;
    
    NSInteger cellheight=0;
    cellheight=[cell sizeToFitTitle];
    
    
    //================================
    
    NSString *nLike=[[postArray objectAtIndex:indexPath.section] objectForKey:@"like_count"];
	NSString *ncomment=[[postArray objectAtIndex:indexPath.section] objectForKey:@"comment_count"];
    
    CGSize size=CGSizeZero;
    if(cell.likeBtn.textlabel.font)
        size =  [cell.likeBtn SizeTofit:[NSString stringWithFormat:@"%@ %@",nLike,MYGULU_LIKE_STRING] 
								  textFont:cell.likeBtn.textlabel.font];
	[cell.likeBtn setFrame:CGRectMake(5, cellheight, size.width, 45)];
	cell.likeBtn.tag=indexPath.section;
    
    CGSize size2=CGSizeZero;
    if(cell.commentBtn.textlabel.font)
        size2 = [cell.commentBtn SizeTofit:[NSString stringWithFormat:@"%@ %@",ncomment,MYGULU_COMMENT_STRING] 
                                     textFont:cell.commentBtn.textlabel.font];
    if(cell.likeBtn)
        [cell.commentBtn setFrame:CGRectMake(5+cell.likeBtn.frame.size.width+5, cellheight,size2.width, 45)];
	
    cell.commentBtn.tag=indexPath.section;

    
    //===============================    
    NSString *url_key=[[[postArray objectAtIndex:indexPath.section] objectForKey:@"photo"] objectForKey:@"image_large"];
    [cell.bigPhotoImageView setImageWithURL:[NSURL URLWithString:url_key]];


	return cell;
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *Dict=[postArray objectAtIndex:indexPath.section];
    
    if([[Dict objectForKey:@"target_type"] isEqualToString:[NSString stringWithFormat:@"1"]])  //review
    {
        NSMutableDictionary *userdict=[NSMutableDictionary dictionaryWithDictionary:[Dict objectForKey:@"user"]];
        
        NSMutableDictionary *dict=[[[NSMutableDictionary alloc] initWithDictionary:[[postArray objectAtIndex:indexPath.section] objectForKey:@"photo"]] autorelease];
        
        reviewProfileViewController *VC=[[reviewProfileViewController alloc] initWithNibName:@"reviewProfileViewController" bundle:nil];
         VC.targetID=[Dict objectForKey:@"target_id"];
 //       VC.targetType=[Dict objectForKey:@"target_type"];
        
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
    }
}


- (void)refresh {
    
    if([ACCheckConnection isConnectedToNetwork])
    {
        [self getMyPost];
    }
    else
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        [self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.1];
    }

	
}

- (void)viewDidUnload {
	
//	[network cancelAllRequestsInRequestsQueue];
	
    [super viewDidUnload];
	
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}


- (void)dealloc {
	
	[network cancelAllRequestsInRequestsQueue];
	
	[network release];
	[postArray release];
    
    [LoadingView release];
	
	network=nil;
	postArray=nil;
    
    LoadingView=nil;
	
    [super dealloc];
}

#pragma mark -
#pragma mark action Function Methods

-(void)gotoUserProfile
{
    userProfileViewController *VC=[[userProfileViewController alloc] initWithNibName:@"userProfileViewController" bundle:nil];	
    VC.userDict=[NSMutableDictionary dictionaryWithDictionary:appDelegate.userMe.userDictionary];
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];
}

-(void)gotoFriendProfile:(UIButton *)btn
{
    UserHeaderView *headerView = (UserHeaderView *)[btn superview];

    NSDictionary *dict=[[postArray objectAtIndex:headerView.tag] objectForKey:@"user"] ;
    
 //   NSLog(@"%d",headerView.tag);

    userFriendProfileViewController *VC=[[userFriendProfileViewController alloc] initWithNibName:@"userFriendProfileViewController" bundle:nil];	
	VC.userDict=[NSMutableDictionary dictionaryWithDictionary:dict];
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];
}

- (void)moreAction :(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)[[btn superview] superview];
    [((ACTableAroundMeCell *)cell) showMore];
}

- (void)mapAction :(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)[[[btn superview] superview] superview];
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    
	NSMutableDictionary *restaurantDict=[NSMutableDictionary dictionaryWithDictionary:[[postArray objectAtIndex:indexPath.section] objectForKey:@"restaurant"]];
    
    if(restaurantDict) //restaurant
    {
        [self gotoMap:restaurantDict] ;	
    }
}

- (void)favoriteAction :(UIButton *)btn
{
    
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }

    
    UITableViewCell *cell = (UITableViewCell *)[[[btn superview] superview] superview];
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    
	NSMutableDictionary *restaurantDict=[NSMutableDictionary dictionaryWithDictionary:[[postArray objectAtIndex:indexPath.section] objectForKey:@"restaurant"]];   
    
    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    [self favoriteRestaurantConnection:network  restaurant:restaurantDict];
}


- (void)todoAction :(UIButton *)btn
{
    
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }
    

    
    UITableViewCell *cell = (UITableViewCell *)[[[btn superview] superview] superview];
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    
	NSMutableDictionary *restaurantDict=[NSMutableDictionary dictionaryWithDictionary:[[postArray objectAtIndex:indexPath.section] objectForKey:@"restaurant"]];
    
    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    [self todoAddRestaurantConnection:network  restaurant:restaurantDict];
    
}


- (void)inviteAction :(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)[[[btn superview] superview] superview];
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    
	NSMutableDictionary *restaurantDict=[NSMutableDictionary dictionaryWithDictionary:[[postArray objectAtIndex:indexPath.section] objectForKey:@"restaurant"]];
    
    appDelegate.temp.inviteObj=[[[inviteModel alloc] init] autorelease];
	appDelegate.temp.inviteObj.contactDict=[[[NSMutableDictionary alloc] init] autorelease];
    appDelegate.temp.inviteObj.restaurantDict=restaurantDict;		
    
    EventViewController *VC=[[EventViewController alloc] initWithNibName:@"EventViewController" bundle:nil];	
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];
}

-(void)gotoDishProfile:(UIButton *)btn
{
 /*   UITableViewCell *cell = (UITableViewCell *)[[btn superview] superview]  ;
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    
	NSMutableDictionary *restaurantDict=[NSMutableDictionary dictionaryWithDictionary:[[postArray objectAtIndex:indexPath.section] objectForKey:@"restaurant"]];
    
    dishProfileViewController *VC=[[dishProfileViewController alloc] initWithNibName:@"dishProfileViewController" bundle:nil];	
    //VC.dishDict=[[tableArray objectAtIndex:indexPath.row] objectForKey:@"restaurant"];
    VC.dishDict=[NSMutableDictionary dictionaryWithDictionary:dishDict];
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];
*/	
}

-(void)gotoRestaurantProfile:(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)[[btn superview] superview] ;
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    
	NSMutableDictionary *restaurantDict=[NSMutableDictionary dictionaryWithDictionary:[[postArray objectAtIndex:indexPath.section] objectForKey:@"restaurant"]];
    
    RestaurantProfileViewController *VC=[[RestaurantProfileViewController alloc] initWithNibName:@"RestaurantProfileViewController" bundle:nil];	
   // VC.restaurantDict=restaurantDict;
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];
    
}




#pragma mark -
#pragma mark request Delegate Function Methods


- (void)getMyPost 
{
//	self.tableView.userInteractionEnabled=NO; 
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
	[self aroundMeConnection:network];
	
	//NSLog(@"%@",appDelegate.userMe.uid);
	//NSLog(@"%@",appDelegate.userMe.myLocation);
	
}

- (void)likeAction:(ACButtonWithLeftImage *)button 
{
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }
    

    
	NSInteger index=button.tag;
    NSMutableDictionary *dict=[postArray objectAtIndex:index];
    NSNumber *number=[dict objectForKey:@"is_like"];
    
    
    if([number isEqualToNumber:[NSNumber numberWithInt:1]])
    {
        return;
    }

	
	//	self.tableView.userInteractionEnabled=NO; 
	//[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
	
	NSString *target_id	= [[postArray objectAtIndex:index] objectForKey:@"target_id"];
	NSString *target_type	= [[postArray objectAtIndex:index] objectForKey:@"target_type"];
	
	[self likeConnection:network target_id:target_id target_type:target_type ];
    
    NSString *nLike=[[postArray objectAtIndex:index] objectForKey:@"like_count"];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]];
    
    CGSize size =  [  ((ACTableAroundMeCell *)cell).likeBtn 
                    SizeTofit:[NSString stringWithFormat:@"%d %@",[nLike intValue]+1,MYGULU_LIKE_STRING] 
                    textFont: ((ACTableAroundMeCell *)cell).likeBtn.textlabel.font];
    [ ((ACTableAroundMeCell *)cell).likeBtn setFrame:CGRectMake(5, ((ACTableAroundMeCell *)cell).likeBtn.frame.origin.y, size.width, 45)];
    
    [dict setObject:[NSString stringWithFormat:@"%d",[nLike intValue]+1] forKey:@"like_count"];
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"is_like"];


    
}

- (void)commentAction:(ACButtonWithLeftImage *)button 
{
	NSInteger index=button.tag;
    
    NSDictionary *Dict=[postArray objectAtIndex:index];
    
    if([[Dict objectForKey:@"target_type"] isEqualToString:[NSString stringWithFormat:@"1"]])  //review
    {
        NSMutableDictionary *userdict=[NSMutableDictionary dictionaryWithDictionary:[Dict objectForKey:@"user"]];
        
        reviewProfileViewController *VC=[[reviewProfileViewController alloc] initWithNibName:@"reviewProfileViewController" bundle:nil];
    
        VC.targetID=[Dict objectForKey:@"target_id"];
 //       VC.targetType=[Dict objectForKey:@"target_type"];
        
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
    }

    
}

#pragma mark -

-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
	self.view.userInteractionEnabled=YES; 
	[self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.1];
	
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		ACLog(@"No Data");
	}
	
//	ACLog(@"temp %@",temp);
    ACLog(@"request ok");

    
    
    if([temp  isKindOfClass:[NSDictionary class]])
    {
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
        {
          //  NSString *errorString =CONNECTION_ERROR_STRING;
           // [self showErrorAlert:errorString];
            
              ACLog(@"request error %@",temp);
            return;
        }
    }


	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"aroundme"])
	{
		
		self.postArray=[[[NSMutableArray  alloc] initWithArray:temp] autorelease];
		
        
        NSMutableArray *arr=[[[NSMutableArray alloc] init] autorelease];
        
        for(NSDictionary *dict in postArray)
        {
            NSMutableDictionary *DICT=[NSMutableDictionary dictionaryWithDictionary:dict];
            [arr addObject:DICT];
        }
        
        self.postArray=arr;

		[self.tableView reloadData];
		
	}
	else if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"like"])
	{
		
		NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:temp];
		
		if([dict count]==0)
			return;
		
		if (![[dict objectForKey:@"errorMessage"] isEqual:[NSNull null]] ) 
		{
			if([[dict objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
			{
			//[self showErrorAlert:[dict objectForKey:@"errorMessage"]];
				return;
			}
			else if ([[dict objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]] ) 
			{
			//	[self showOKAlert:GLOBAL_OK_STRING];
			//	[self getMyPost];
				return;
			}
		}
	}
    else if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"addFavoriteRestaurant"])
	{
		NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:temp];
		
		if([dict count]==0)
			return;
		
		if ([[dict objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]] ) {
			[self showOKAlert:[NSString stringWithFormat:@"%@ %@",GLOBAL_ADDTO_FAVORITE_STRING,GLOBAL_OK_STRING]];
		}
		
	}
    else if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"addTodoRestaurant"])
	{
		NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:temp];
		
		if([dict count]==0)
			return;
		
		if (![[dict objectForKey:@"errorMessage"] isEqual:[NSNull null]] ) 
		{
			if([[dict objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
			{
				[self showErrorAlert:[dict objectForKey:@"errorMessage"]];
				return;
			}
			else if ([[dict objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]] ) 
			{
				[self showOKAlert:[NSString stringWithFormat:@"%@ %@",GLOBAL_ADDTO_TODO_STRING,GLOBAL_OK_STRING]];
				return;
			}
		}
	}
	
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	
    ACLog(@"request failed");
    
	[self hideSpinnerView:LoadingView];
	self.tableView.userInteractionEnabled=YES; 
	[self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.1];
	
//	NSString *errorString =CONNECTION_ERROR_STRING;
//	[self showErrorAlert:errorString];
}


#pragma mark -
#pragma mark ACImageDidLoad Delegate and Function Methods

- (void)ACImageDidLoad:(ACImageLoader *)imageloader
{
	
	if(imageloader.tag==0)  //photo
	{
		if (imageloader.image != nil)
		{
			UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:imageloader.indexPath];
			((ACTableAroundMeCell *)cell).bigPhotoImageView.image=imageloader.image;
		}	
	}
	else if(imageloader.tag==1)  //user
	{
		if (imageloader.image != nil)
		{
			[self.tableView reloadData];
		}	
	}
}

- (void)loadImagesForOnscreenRows :(UITableView*)tableview  imageLoadersDict:(NSMutableDictionary *)dict
{
	NSArray *visiblePaths = [tableview indexPathsForVisibleRows];
	for (NSIndexPath *indexPath in visiblePaths)
	{
		ACImageLoader *iconDownloader=[dict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]];
		
		if(iconDownloader.image==nil)
		{
			iconDownloader.indexPath=indexPath;
			iconDownloader.delegate=self;
			[iconDownloader startDownload];
		}
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{	
	[super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
	
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{	

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
	for (NSIndexPath *indexPath in visiblePaths)
	{
		UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [((ACTableAroundMeCell *)cell) hideMore];
	}
}


@end

