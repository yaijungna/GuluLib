//
//  userProfileViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/20.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "userProfileViewController.h"
#import "ACTableOneLineWithImageCell.h"
#import "oneLineTableHeaderView.h"

#import "userProfileView.h"
#import "userFriendProfileViewController.h"


@implementation userProfileViewController


@synthesize userDict;
@synthesize favoriteArray;

@synthesize imageLoaderDictionary_post;

-(void)showData
{
	//NSLog(@"%@",userDict);
	
	userView.namelabel.text=[userDict objectForKey:@"username"];
	
	userView.Nfanlabel.text=@"0";
	userView.Nmissionlabel.text=@"0";
	userView.NApluslabel.text=@"0";
    
	
    [self shareGULUAPP];
    
     NSLog(@"%@",appDelegate.userMe.userDictionary);
	
	if([appDelegate.userMe.userDictionary count]==0)
	{
		userView.imageLoader.URLStr=appDelegate.userMe.userPhotoUrl;
		[userView.imageLoader  startDownload];	
	}
	else
	{
		userView.imageLoader.URLStr=[[appDelegate.userMe.userDictionary objectForKey:@"photo"] objectForKey:@"image_medium"];
		[userView.imageLoader startDownload];	
	}
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
	[self.view addSubview:topView];
	[topView release];
	
	[topView.topLeftButton	addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topMiddleButton addTarget:self action:@selector(landingAction) forControlEvents:UIControlEventTouchUpInside];
	
	/*
	bottomView=[[[BottomMenuBarView alloc] initWithFrame:CGRectMake(0, 410, 320, 50)] initTwoBtnsBottomBarView:ButtonTypeMissions  second:ButtonTypeSearch];
	[bottomView setUpMainBtnAction];
	[self.view addSubview:bottomView];
	[bottomView release];
	*/
	
	userView=[[userProfileView alloc] initWithFrame:CGRectMake(0, 45, 320, 150)];
	[self.view addSubview:userView];
	[userView release];
    
    [userView.chanegePhotoBtn addTarget:self action:@selector(gotoCamera) forControlEvents:UIControlEventTouchUpInside];
	
	[self customizeLabel_title:userView.namelabel];
	[self customizeLabel:userView.fanlabel];
	[self customizeLabel:userView.Nfanlabel];
	[self customizeLabel:userView.missionlabel];
	[self customizeLabel:userView.Nmissionlabel];
	[self customizeLabel:userView.Apluslabel];
	[self customizeLabel:userView.NApluslabel];
	[self customizeImageView:userView.userPhotoImageView];
	
	[self showData];
	
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
	
	//NSLog(@"%@",appDelegate.userMe.uid);
	
	
	
	table =[[UITableView alloc] initWithFrame:CGRectMake(0, 200, 320, 260)];
	[self customizeTableView:table];
	table.delegate=self;
	table.dataSource=self;
	[self.view addSubview:table];
	[table release];
	
	
	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	LoadingView.hidden=YES;
    
    
    
    if([ACCheckConnection isConnectedToNetwork])
    {
        [self getUserInfo];
        [self getMyFavorite];
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
    
    [self cancelImageLoaders:imageLoaderDictionary_post];
	self.imageLoaderDictionary_post=nil;
	
	[network cancelAllRequestsInRequestsQueue];
	[userView.imageLoader cancelDownload];

    
	[userDict release];
	[favoriteArray release];
	[imageLoaderDictionary_post release];
    
    [network release];
    
    [LoadingView release];

    [super dealloc];
}

#pragma mark -
#pragma mark action Function Methods

- (void)backAction 
{
	[self cancelImageLoaders:imageLoaderDictionary_post];
	self.imageLoaderDictionary_post=nil;
	
	[network cancelAllRequestsInRequestsQueue];
	[userView.imageLoader cancelDownload];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)landingAction 
{	
	[self cancelImageLoaders:imageLoaderDictionary_post];
	self.imageLoaderDictionary_post=nil;
	
	[network cancelAllRequestsInRequestsQueue];
	[userView.imageLoader cancelDownload];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)gotoCamera
{
	imagePicker =[ACCameraViewController sharedManager];
	imagePicker.ACDelegate=self;
	[self presentModalViewController:imagePicker animated:NO];
}


#pragma mark -
#pragma mark table Function Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	oneLineTableHeaderView *view1 = [[oneLineTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
	view1.label1.text=NSLocalizedString(@"Favorites",@"[title]");
	view1.rightBtn.hidden=YES;
	[self customizeLabel:view1.label1];
	
	return [view1 autorelease];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [favoriteArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellIdentifier = @"ACTableOneLineWithImageCell";
	static NSString *nibNamed = @"ACTableOneLineWithImageCell";
	
	ACTableOneLineWithImageCell *cell = (ACTableOneLineWithImageCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil];
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell= (ACTableOneLineWithImageCell*) currentObject;
				[cell initCell];
				cell.switcher.hidden=YES;
				cell.leftImageview.frame=CGRectMake(cell.leftImageview.frame.origin.x,
													cell.leftImageview.frame.origin.y-5, 
													cell.leftImageview.frame.size.width+10, 
													cell.leftImageview.frame.size.height+10);
				[self customizeImageView_cell:cell.leftImageview];
			
				//	[cell.rightBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
				//	[cell.more.mapbtn.btn addTarget:self action:@selector(mapAction:) forControlEvents:UIControlEventTouchUpInside];
				//	[cell.more.favoritebtn.btn addTarget:self action:@selector(favoriteAction:) forControlEvents:UIControlEventTouchUpInside];
			}
		}
	}
	NSString *type= [NSString stringWithFormat:@"%@",[[favoriteArray objectAtIndex:indexPath.row] objectForKey:@"type"]];
	
	
	if([type isEqualToString:@"0"] ) //dish
	{
		NSDictionary *dishDict=[[favoriteArray objectAtIndex:indexPath.row] objectForKey:@"object"];
		NSString *dishName=[[NSString alloc] initWithFormat:@"%@",[dishDict objectForKey:@"name"]];
		
		NSDictionary *restaurantDict=[dishDict objectForKey:@"restaurant"];
		NSString *restaurantName=[[NSString alloc] initWithFormat:@"%@",[restaurantDict objectForKey:@"name"]];
		
		cell.label1.text=[NSString stringWithFormat:@"%@ @ %@",dishName,restaurantName];
		[dishName release];
		[restaurantName release];
	}
	else if([type isEqualToString:@"1"] )	//restaurant
	{ 
		NSDictionary *restaurantDict=[[favoriteArray objectAtIndex:indexPath.row] objectForKey:@"object"];
		NSString *restaurantName=[[NSString alloc] initWithFormat:@"%@",[restaurantDict objectForKey:@"name"]];
	
		cell.label1.text=[NSString stringWithFormat:@"%@",restaurantName];
		[restaurantName release];
	}
	else if([type isEqualToString:@"3"] )	//friend
	{  
		NSDictionary *userDictionary=[[favoriteArray objectAtIndex:indexPath.row] objectForKey:@"object"];
		NSString *userName=[[NSString alloc] initWithFormat:@"%@",[userDictionary objectForKey:@"username"]];
		
		cell.label1.text=[NSString stringWithFormat:@"%@",userName];
		[userName release];
	}
    else if([type isEqualToString:@"4"] )	//mission
	{  
		NSDictionary *missionDictionary=[[favoriteArray objectAtIndex:indexPath.row] objectForKey:@"object"];
		NSString *missionName=[[NSString alloc] initWithFormat:@"%@",[missionDictionary objectForKey:@"title"]];
		
		cell.label1.text=[NSString stringWithFormat:@"%@",missionName];
		[missionName release];
	}
	
	
	
	ACImageLoader *iconDownloader=[imageLoaderDictionary_post objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
	if (!iconDownloader.image)
	{
		if (tableView.dragging == NO && tableView.decelerating == NO)
		{
			iconDownloader.delegate=self;
			iconDownloader.indexPath=indexPath;
			[iconDownloader startDownload];
		}
		
		cell.leftImageview.image=nil;               
	}
	else
	{
		cell.leftImageview.image=iconDownloader.image;
	}
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *type= [NSString stringWithFormat:@"%@",[[favoriteArray objectAtIndex:indexPath.row] objectForKey:@"type"]];
	
    
    if([type isEqualToString:@"0"] ) //dish
	{
        dishProfileViewController *VC=[[dishProfileViewController alloc] initWithNibName:@"dishProfileViewController" bundle:nil];	
	//	VC.dishDict=[[favoriteArray objectAtIndex:indexPath.row] objectForKey:@"object"];
		[self.navigationController pushViewController:VC animated:YES];
		[VC release];
		
	}
	
	else if([type isEqualToString:@"1"] ) //restaurant
	{
        RestaurantProfileViewController *VC=[[RestaurantProfileViewController alloc] initWithNibName:@"RestaurantProfileViewController" bundle:nil];	
	//	VC.restaurantDict=[[favoriteArray objectAtIndex:indexPath.row] objectForKey:@"object"];
		[self.navigationController pushViewController:VC animated:YES];
		[VC release];
		
	}
    
    else if([type isEqualToString:@"3"] ) //firend
	{
        
        userFriendProfileViewController *VC=[[userFriendProfileViewController alloc] initWithNibName:@"userFriendProfileViewController" bundle:nil];	
        VC.userDict=[NSMutableDictionary dictionaryWithDictionary:[[favoriteArray objectAtIndex:indexPath.row] objectForKey:@"object"]];
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];

	}
    
    else if([type isEqualToString:@"4"] ) //mission
	{
        NSDictionary *missionDict=[[favoriteArray objectAtIndex:indexPath.row] objectForKey:@"object"];
        
        missionProfileviewcontroller *VC=[[missionProfileviewcontroller alloc] initWithNibName:@"missionProfileviewcontroller" bundle:nil];	
        VC.missionDict=missionDict;
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
		
	}

	
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableview 
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	
	NSString *type= [NSString stringWithFormat:@"%@",[[favoriteArray objectAtIndex:indexPath.row] objectForKey:@"type"]];
	
	
	if([type isEqualToString:@"0"] ) //dish
	{
		return UITableViewCellEditingStyleDelete;
	}
	
	else if([type isEqualToString:@"1"] ) //restaurant
	{
		return UITableViewCellEditingStyleDelete;
	}
    
    else if([type isEqualToString:@"3"] ) //friend
	{
		return UITableViewCellEditingStyleDelete;
	}
    
    else if([type isEqualToString:@"4"] ) //mission
	{
		return UITableViewCellEditingStyleDelete;
	}
		
	return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableview commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (editingStyle == UITableViewCellEditingStyleDelete) 
	{
		
		NSString *type= [NSString stringWithFormat:@"%@",[[favoriteArray objectAtIndex:indexPath.row] objectForKey:@"type"]];
		
		if([type isEqualToString:@"0"] ) //dish
		{
			[self unFavoriteDsih:[[favoriteArray objectAtIndex:indexPath.row]  objectForKey:@"object"] ];
		}
		
		else if([type isEqualToString:@"1"] ) //restaurant
		{
			[self unFavoriteRestaurant:[[favoriteArray objectAtIndex:indexPath.row]  objectForKey:@"object"] ];
		}
        
        else if([type isEqualToString:@"3"] ) //friend
		{
            [self unFavoriteUser:[[favoriteArray objectAtIndex:indexPath.row] objectForKey:@"object"]];
		}
        
        else if([type isEqualToString:@"4"] ) //mission
		{
			[self unFavoriteMission:[[favoriteArray objectAtIndex:indexPath.row]  objectForKey:@"object"] ];
		}
	}     
}




#pragma mark -
#pragma mark request Delegate Function Methods

- (void)getUserInfo
{
	
	NSLog(@"%@",appDelegate.userMe.uid);
	
	table.userInteractionEnabled=NO; 
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
	[self userInfoConnection:network ID:appDelegate.userMe.uid];
	
	
}

- (void)updateUserInfo:(UIImage *)img
{
    [self shareGULUAPP];
	table.userInteractionEnabled=NO; 
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    NSData *data= UIImageJPEGRepresentation(img, 1);
	[self updateUserInfoConnection:network imageData:data ];

}

- (void)getMyFavorite
{
	table.userInteractionEnabled=NO; 
	self.imageLoaderDictionary_post=[[[NSMutableDictionary alloc] init] autorelease];
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
	[self favoriteListConnection:network userID:appDelegate.userMe.uid];
	
//	NSLog(@"%@",appDelegate.userMe.uid);
//	NSLog(@"%@",appDelegate.userMe.sessionKey);
	
}

- (void)unFavoriteDsih:(NSDictionary *)dict
{
	table.userInteractionEnabled=NO; 
	self.imageLoaderDictionary_post=[[[NSMutableDictionary alloc] init] autorelease];
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
	[self unFavoriteDishConnection:network dish:[NSMutableDictionary dictionaryWithDictionary:dict]];
}

- (void)unFavoriteRestaurant:(NSDictionary *)dict
{
	table.userInteractionEnabled=NO; 
	self.imageLoaderDictionary_post=[[[NSMutableDictionary alloc] init] autorelease];
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
	[self unFavoriteRestaurantConnection:network restaurant:[NSMutableDictionary dictionaryWithDictionary:dict]];
}

- (void)unFavoriteMission:(NSDictionary *)dict
{
	table.userInteractionEnabled=NO; 
	self.imageLoaderDictionary_post=[[[NSMutableDictionary alloc] init] autorelease];
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
	[self unFavoriteMissionConnection:network mission:[NSMutableDictionary dictionaryWithDictionary:dict]];
}

- (void)unFavoriteUser:(NSDictionary *)dict
{
	table.userInteractionEnabled=NO; 
	self.imageLoaderDictionary_post=[[[NSMutableDictionary alloc] init] autorelease];
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    
    [self unFavoriteFriendConnection:network user:[dict objectForKey:@"id"]];
}



#pragma mark -

-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
	table.userInteractionEnabled=YES; 
	
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		NSLog(@"No Data");
	}
	
	//[self showDebugErrorString:data1];
	
	NSLog(@"temp %@",temp);
    
    if([temp  isKindOfClass:[NSDictionary class]])
    {
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
        {
        //    NSString *errorString =CONNECTION_ERROR_STRING;
         //   [self showErrorAlert:errorString];
            
            ACLog(@"request error: %@", temp);
            return;
        }
    }

	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"FavoriteList"])
	{
		
		self.favoriteArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
		
		self.imageLoaderDictionary_post=[[[NSMutableDictionary alloc] init] autorelease];
		int i=0;
        
		for(NSDictionary *dict1 in favoriteArray )
		{
        
            NSString *type= [NSString stringWithFormat:@"%@",[dict1 objectForKey:@"type"]];
            
            if([type isEqualToString:@"4"] ) //mission
            {
                NSDictionary *dict = [dict1 objectForKey:@"object"];
                
                NSString *url_key=[[dict  objectForKey:@"badge_pic"] objectForKey:@"image_small"];
                ACImageLoader *iconDownloader= [[ACImageLoader alloc] init];
                iconDownloader.URLStr=url_key;
                [imageLoaderDictionary_post setObject:iconDownloader forKey:[NSString stringWithFormat:@"%d",i]];	
                [iconDownloader release]; 
                i++;
            }
            else
            {
                NSDictionary *dict = [dict1 objectForKey:@"object"];
                
                NSString *url_key=[[dict  objectForKey:@"photo"] objectForKey:@"image_small"];
                ACImageLoader *iconDownloader= [[ACImageLoader alloc] init];
                iconDownloader.URLStr=url_key;
                [imageLoaderDictionary_post setObject:iconDownloader forKey:[NSString stringWithFormat:@"%d",i]];	
                [iconDownloader release]; 
                i++;
            }
		}
		
		[table reloadData];
	}
	else if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"removeFavoriteRestaurant"])
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
				[self getMyFavorite];
				return;
			}
		}
	}
	else if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"removeFavoriteDish"])
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
				[self getMyFavorite];
				return;
			}
		}
	}
    else if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"removeFavoriteMission"])
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
				[self getMyFavorite];
				return;
			}
		}
	}
    
    else if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"removeFavoriteUser"])
	{
        NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:temp];
        
        if([dict count]==0)
            return;
        
        if([[dict objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
        {
            [self showErrorAlert:[dict objectForKey:@"errorMessage"]];
            return;
        }
        else if ([[dict objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]] ) 
        {
            [self getMyFavorite];
            return;
        }
	}

	else if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"userinfo"])
	{
		if([temp count]==0)
			return;
		
		if ([temp objectForKey:@"errorMessage"] !=nil ) 
		{
			return;
		}
		
		
		userView.Nfanlabel.text=[NSString stringWithFormat:@"%@",[temp objectForKey:@"fans_num"]];
		userView.Nmissionlabel.text=[NSString stringWithFormat:@"%@",[temp objectForKey:@"missions_num"]];
		userView.NApluslabel.text=[NSString stringWithFormat:@"%@",[temp objectForKey:@"a_plus_num"]];
		
		userView.imageLoader.URLStr=[[temp objectForKey:@"photo"] objectForKey:@"image_medium"];
		[userView.imageLoader startDownload];
	}
    
    else if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"updateuserinfo"])
    {
        
        if([temp objectForKey:@"id"])
        {
            appDelegate.userMe.userDictionary=temp;
            appDelegate.userMe.userPhotoUrl=[[temp objectForKey:@"photo"] objectForKey:@"image_medium"];
            [appDelegate.userMe save];
            [self showOKAlert:NSLocalizedString(@"Change Photo OK", @"[user profile]")];
        
        }
        else
        {
            [self showErrorAlert:GLOBAL_ERROR_STRING];
        }
    
    }
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
	table.userInteractionEnabled=YES;
//	NSString *errorString =CONNECTION_ERROR_STRING;
//	[self showErrorAlert:errorString];
}

#pragma mark -
#pragma mark ACImageDidLoad Delegate and Function Methods

- (void)ACImageDidLoad:(ACImageLoader *)imageloader
{
	if (imageloader.image != nil)
	{
		UITableViewCell *cell = [table cellForRowAtIndexPath:imageloader.indexPath];
		((ACTableOneLineWithImageCell *)cell).leftImageview.image=imageloader.image;
	}	 
}

- (void)loadImagesForOnscreenRows :(UITableView*)tableview  imageLoadersDict:(NSMutableDictionary *)dict
{
	NSArray *visiblePaths = [tableview indexPathsForVisibleRows];
	for (NSIndexPath *indexPath in visiblePaths)
	{
		ACImageLoader *iconDownloader=[dict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
		
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
	//[super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
	
    if (!decelerate)
	{
		[self loadImagesForOnscreenRows:table imageLoadersDict:imageLoaderDictionary_post];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{	
	[self loadImagesForOnscreenRows:table imageLoadersDict:imageLoaderDictionary_post ];
}

#pragma mark -

- (void)ACCameraViewControllerDelegateDidFinishPickingImage:(UIImage *)image
{
	[self dismissModalViewControllerAnimated:NO];
    
    [self updateUserInfo:image];
     userView.userPhotoImageView.image=image;
}

- (void)ACCameraViewControllerDelegateCancelImagePicker
{
	[self dismissModalViewControllerAnimated:NO];
}






@end
