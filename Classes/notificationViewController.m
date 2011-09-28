//
//  notificationViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "notificationViewController.h"
#import "oneLineTableHeaderView.h"
#import "ACTableTwoLinesWithImageCell.h"
#import "notifyCell.h"


#import "reviewProfileViewController.h"
#import "ChatViewController.h"
#import "missionChatViewController.h"

#import "RestaurantProfileViewController.h"
#import "dishProfileViewController.h"
#import "missionChatViewController.h"
#import "ChatViewController.h"

#import "UIImageView+WebCache.h"

typedef enum {
	NOTIFY_UNDEFINED = 0,
    NOTIFY_CHAT = 1,
    NOTIFY_SENTCHAT = 2,
    NOTIFY_EMAIL = 3,
    NOTIFY_MOBILE = 4,
    NOTIFY_WEB = 5,
    NOTIFY_SUGGEST = 6, //friend has suggested a website
    NOTIFY_EVENT = 7 , // an Event has been suggested
    NOTIFY_HUNGRY = 8, // user clicked on the I'm hungry button on the website
    NOTIFY_INVITE = 9 ,// you have been invited to an event.
    NOTIFY_FRIEND = 10,// +FRIEND
    NOTIFY_MISSION_RECRUIT = 11,
    NOTIFY_MISSION_CHALLENGER = 12,
    NOTIFY_MISSION_SPECTATOR = 13,
    NOTIFY_LIKES = 14,//Likes an content_object
    NOTIFY_COMMENTED = 15 ,// commented on your post
    NOTIFY_FOLLOWS = 16 ,// follows
    NOTIFY_FRIEND_ACCEPT=17,
    NOTIFY_TAG_IN_POST = 18,
    NOTIFY_TAG_IN_POST_EVENT = 19

} notifyType;


@implementation notificationViewController

@synthesize navigationController;
@synthesize notifyArray;


- (void)viewDidLoad {
    [super viewDidLoad];

	[self customizeTableView:table];
	table.delegate=self;
	table.dataSource=self;
    
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - table.bounds.size.height, self.view.frame.size.width,table.bounds.size.height)];
	_refreshHeaderView.delegate = self;
	[table addSubview:_refreshHeaderView];
	[_refreshHeaderView release];
	[_refreshHeaderView refreshLastUpdatedDate];
    
    
	[self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
	
	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	LoadingView.hidden=YES;

    
    if([ACCheckConnection isConnectedToNetwork])
    {
         [self getAllNotification];
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
	[network cancelAllRequestsInRequestsQueue];
    
	[notifyArray release];
    [network release];
    
    [LoadingView release];
    [super dealloc];
}

- (NSString *)handleString : (NSDictionary *)Dict 
{
    
    NSDictionary *userDict=[Dict objectForKey:@"from_user"];
    NSString *username=[userDict objectForKey:@"username"];
    
    NSInteger notify_type=[[Dict objectForKey:@"notify_type"] intValue];
    NSString *objectTitle=[Dict objectForKey:@"title"];
    NSString *object_type=[Dict objectForKey:@"object_type"];

    if(objectTitle==nil || [objectTitle isEqual:[NSNull null]])
        objectTitle=@"";
    
    
    ACLog(@"nt=%d,ot=%@,title=%@",notify_type,object_type,objectTitle);

    
	if(notify_type == NOTIFY_INVITE)
    {
        return [NSString stringWithFormat:@"%@ %@%@",username ,NSLocalizedString(@"invited you to the Event:", @"[notify]"),objectTitle]; 
    }
    if(notify_type == NOTIFY_SUGGEST)
    {
        return [NSString stringWithFormat:@"%@ %@ %@ %@",username ,NSLocalizedString(@"recommends", @"[notify]"),objectTitle,
                NSLocalizedString(@"to you.", @"[notify] suggest to you")]; 
    }
    if(notify_type == NOTIFY_FRIEND)
    {
        return [NSString stringWithFormat:@"%@ %@",username ,NSLocalizedString(@"wants to be your friend.",@"")]; 
    }
    
    if(notify_type == NOTIFY_MISSION_RECRUIT)
    {
        return [NSString stringWithFormat:@"%@ %@ %@ ",username ,NSLocalizedString(@"wants you to join", @"[notify]"),objectTitle]; 
    }
    
    if(notify_type == NOTIFY_MISSION_CHALLENGER)
    {
        return [NSString stringWithFormat:@"%@ %@ %@",username ,NSLocalizedString(@"is challenging you Dare Mission:%@", @"[notify]"),objectTitle]; 
    }
    
    if(notify_type == NOTIFY_MISSION_SPECTATOR)
    {
        return [NSString stringWithFormat:@"%@ %@ %@",username ,NSLocalizedString(@"added you as a spectator to the Mission", @"[notify]"),objectTitle]; 
    }

    if(notify_type == NOTIFY_LIKES)
    {
        return [NSString stringWithFormat:@"%@ %@ %@",username ,NSLocalizedString(@"likes", @"[notify]"),objectTitle]; 
    }
    
    if(notify_type == NOTIFY_COMMENTED)
    {
        return [NSString stringWithFormat:@"%@ %@ %@",username ,NSLocalizedString(@"commented on", @"[notify]"),objectTitle]; 
    }
    
    if(notify_type == NOTIFY_FOLLOWS)
    {
        return [NSString stringWithFormat:@"%@ %@",username ,NSLocalizedString(@"is now following you.", @"[notify]")]; 
    }
    
    if(notify_type == NOTIFY_FRIEND_ACCEPT)
    {
        return [NSString stringWithFormat:@"%@ %@",username ,NSLocalizedString(@"accepted your Friend Request.", @"[notify]")]; 
    }
    
    if(notify_type == NOTIFY_TAG_IN_POST)
    {
        return [NSString stringWithFormat:@"%@ %@",username ,NSLocalizedString(@"tagged you in a gulu post.", @"[notify]")]; 
    }

    if(notify_type == NOTIFY_TAG_IN_POST_EVENT )
    {
        return [NSString stringWithFormat:@"%@ %@",username ,NSLocalizedString(@"tagged an event that you joined in a gulu post.", @"[notify]")]; 
    }

    
    return nil;


}

#pragma mark -
#pragma mark action Function Methods

-(void)noAction:(UIButton *)btn
{
    
    NSDictionary *dict= [notifyArray objectAtIndex:btn.tag];
    NSInteger notify_type=[[dict objectForKey:@"notify_type"] intValue];
    NSInteger status=[[dict objectForKey:@"status"] intValue];
    
    NSDictionary *userDict=[dict objectForKey:@"from_user"];
    NSString *uid=[userDict objectForKey:@"id"];
    
    ACLog(@"%@",uid);
    
    if(notify_type==NOTIFY_FRIEND && status==0 )
    {
        [self sendRespondFriend:uid status:@"reject"];
    }

}

-(void)yesAction:(UIButton *)btn
{
    NSDictionary *dict= [notifyArray objectAtIndex:btn.tag];
    NSInteger notify_type=[[dict objectForKey:@"notify_type"] intValue];
    NSInteger status=[[dict objectForKey:@"status"] intValue];
    
    NSDictionary *userDict=[dict objectForKey:@"from_user"];
    NSString *uid=[userDict objectForKey:@"id"];
    
     ACLog(@"%@",uid);
    
    if(notify_type==NOTIFY_FRIEND && status==0 )
    {
        [self sendRespondFriend:uid status:@"accept"];
    }
}


#pragma mark -
#pragma mark table Function Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    oneLineTableHeaderView *view1 = [[[oneLineTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)]autorelease];
    
    view1.label1.text=NSLocalizedString(@"Notifications",@"[title]");
    view1.rightBtn.hidden=YES;
    [self customizeLabel:view1.label1];
    
	return view1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict= [notifyArray objectAtIndex:indexPath.row];
    NSInteger notify_type=[[dict objectForKey:@"notify_type"] intValue];
    NSInteger status=[[dict objectForKey:@"status"] intValue];
    
    NSString *str=[self handleString:dict];
    
    CGSize maxSize = CGSizeMake(225, 2000);
	
	CGSize TextSize = [str  sizeWithFont:notify_text_font
                               constrainedToSize:maxSize 
                                   lineBreakMode:UILineBreakModeWordWrap];
    
	if(TextSize.height<35)
		TextSize.height=35;
    
    if(notify_type==NOTIFY_FRIEND && status==0)
    {
        return 30+3+3+TextSize.height+25;
    }
	
	return TextSize.height+25;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [notifyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"notifyCell";
	static NSString *nibNamed = @"notifyCell";
	
	notifyCell *cell = (notifyCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil];
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell= (notifyCell*) currentObject;
				[cell initCell];
                
				[self customizeImageView_cell:cell.leftImageview];
                [cell.noBtn addTarget:self action:@selector(noAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.yesBtn addTarget:self action:@selector(yesAction:) forControlEvents:UIControlEventTouchUpInside];
			}
		}
	}
    cell.noBtn.tag=indexPath.row;
    cell.yesBtn.tag=indexPath.row;
    
    NSDictionary *dict= [notifyArray objectAtIndex:indexPath.row];
    NSInteger notify_type=[[dict objectForKey:@"notify_type"] intValue];
    NSString *createdTime=[dict objectForKey:@"created"];
    NSInteger status=[[dict objectForKey:@"status"] intValue];

    cell.label1.text=[self handleString:dict];
    cell.label2.text=[TimeAgoFormat TimeAgoString:[TimeAgoFormat getTimeAgoPeriod:createdTime]];
    
    [cell sizeToFitTitle];
    
    //===============
    
    
    if(notify_type==NOTIFY_FRIEND && status==0 )
    {
        [cell showYesNoBtn];
    }
    else
    {
        [cell hideYesNoBtn];
    }
    
   
    //=================
    
    if([[dict objectForKey:@"unseen"] isEqualToNumber:[NSNumber numberWithInt:0]])  //seen
    {
        cell.backgroundView.alpha=0.4;
       ( (UIImageView *)(cell.backgroundView)).image=[UIImage imageNamed:@"more-list-box-1.png"];
    }
    else  //unseen
    {
        cell.backgroundView.alpha=0.8;
        ( (UIImageView *)(cell.backgroundView)).image=[UIImage imageNamed:@"large-list-box-1.png"];
    }
    
    //================
    
    NSString *url_key=[[[dict objectForKey:@"from_user"] objectForKey:@"photo"] objectForKey:@"image_medium"];
    [cell.leftImageview setImageWithURL:[NSURL URLWithString:url_key]];


     return cell;
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *Dict= [notifyArray objectAtIndex:indexPath.row];
    
    //NSDictionary *userDict=[Dict objectForKey:@"from_user"];
    
//    NSInteger notify_type=[[Dict objectForKey:@"notify_type"] intValue];
//    NSString *objectTitle=[Dict objectForKey:@"title"];
    int object_type=[[Dict objectForKey:@"object_type"] intValue];
    NSDictionary *object=[Dict objectForKey:@"object"];
    NSMutableDictionary *objectDict=nil;
   
    if(![object isEqual:[NSNull null]])
    {
        objectDict= [NSMutableDictionary dictionaryWithDictionary:[Dict objectForKey:@"object"]];
    }
    
     ACLog(@"%d",object_type);
    
    if(object_type==0)  //photo
    {
        
    }
    if(object_type==1)  //review
    {
        NSMutableDictionary *userdict=[NSMutableDictionary dictionaryWithDictionary:[objectDict objectForKey:@"user"]];
        
        reviewProfileViewController *VC=[[reviewProfileViewController alloc] initWithNibName:@"reviewProfileViewController" bundle:nil];
       
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
    }
    
    
    if(object_type==2)  //dish
    {
        dishProfileViewController *VC=[[dishProfileViewController alloc] initWithNibName:@"dishProfileViewController" bundle:nil];
  //      VC.dishDict=objectDict;
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
        
    }
    if(object_type==3)  //restaurant
    {
        RestaurantProfileViewController *VC=[[RestaurantProfileViewController alloc] initWithNibName:@"RestaurantProfileViewController" bundle:nil];	
 //       VC.restaurantDict=objectDict;
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
        
    }
    if(object_type==4)  //mission
    {
        
    }
    if(object_type==5)  //user
    {
      /*  userProfileViewController *VC=[[userProfileViewController alloc] initWithNibName:@"userProfileViewController" bundle:nil];	
        VC.userDict=[NSMutableDictionary dictionaryWithDictionary:appDelegate.userMe.userDictionary];
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
       */
        
    }
    if(object_type==6)  //task
    {
        
    }
    if(object_type==7)  //missongroup
    {
        
    }
    if(object_type==8)  //event
    {  
        
    }
    if(object_type==9)  //chat
    {
        NSNumber *typenumber=[objectDict objectForKey:@"type"];
        
        if([typenumber isEqualToNumber:[NSNumber numberWithInt:0]])  //event
        {
            ChatViewController *VC=[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];	
            VC.chatDictionary=objectDict;
            VC.chatID=[objectDict objectForKey:@"chat_uuid"];
            [self.navigationController pushViewController:VC animated:YES];
            [VC release];
            
        }
        if([typenumber isEqualToNumber:[NSNumber numberWithInt:1]]) //mission
        {
            missionChatViewController *VC=[[missionChatViewController alloc] initWithNibName:@"chatRoomViewController" bundle:nil];	
            VC.chatDictionary=objectDict;
            VC.chatID=[objectDict objectForKey:@"chat_uuid"];
            [self.navigationController pushViewController:VC animated:YES];
            [VC release];
        }
    }
    if(object_type==10)  //post
    {
        ACLog(@"post");
    }

    if(object_type==99)  //unknow
    {
        
    }

}

#pragma mark -
#pragma mark scroll Methods

- (void)ACImageDidLoad:(ACImageLoader *)imageloader
{
	if (imageloader.image != nil)
	{
		UITableViewCell *cell = [table cellForRowAtIndexPath:imageloader.indexPath];
		((ACTableTwoLinesWithImageCell *)cell).leftImageview.image=imageloader.image;
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
 

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods


- (void)reloadTableViewDataSource{
    
    
    if([ACCheckConnection isConnectedToNetwork])
    {
        _reloading= YES;
        [self getAllNotification];
    }
    else
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.1];
    }
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:table];
	
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	//[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
    [self reloadTableViewDataSource];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
    
}

#pragma mark -
#pragma mark request Delegate Function Methods


- (void)getAllNotification
{
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    [self allNotificationConnection:network];
}

- (void)sendRespondFriend :(NSString *)uid  status:(NSString *)status
{
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    [self respondFriendNotificationConnection:network senderID:uid status:status];
}

#pragma mark -

-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
	self.view.userInteractionEnabled=YES; 
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.1];
	
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		ACLog(@"No Data");
	}
    
    ACLog(@"%@", temp);
    
    if([temp  isKindOfClass:[NSDictionary class]])
    {
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
        {
         //   NSString *errorString =CONNECTION_ERROR_STRING;
          //  [self showErrorAlert:errorString];
            
            ACLog(@"request error: %@",temp);
            return;
        }
    }

	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"allnotification"])
	{
        
        [self setAllToBeSeenNotificationConnection:network];
        
		self.notifyArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
		
		[table reloadData];
	}
    
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"respondfriendnotification"])
	{
		if([temp count]==0)
			return;
		
		if (![[temp objectForKey:@"errorMessage"] isEqual:[NSNull null]] ) 
		{
			if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
			{
				[self showErrorAlert:GLOBAL_ERROR_STRING];
				return;
			}
			else if ([[temp objectForKey:@"errorMessage"] isEqualToNumber:[NSNumber numberWithInt:0]] ) 
			{
			//	[self showOKAlert:[NSString stringWithFormat:@"%@",GLOBAL_OK_STRING]];
                [self getAllNotification];
				return;
			}
		}
	}

	
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.1];
	
	
//	NSString *errorString =CONNECTION_ERROR_STRING;
//	[self showErrorAlert:errorString];
}


@end
