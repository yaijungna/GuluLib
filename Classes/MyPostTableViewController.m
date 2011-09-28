

#import "MyPostTableViewController.h"

#import "ACTableMyPostCell.h"
#import "commentViewController.h"

#import "reviewProfileViewController.h"
#import "userProfileViewController.h"

#import "PostLandingViewController.h"


#import "ACTableTwoLinesWithImageCell.h"
#import "ACTablePostQueueCell.h"

#import "UIImageView+WebCache.h"


#import "UITableViewCell+Sliderview.h"

#import "GuluUtility.h"

#import "GuluChatManager.h"


#import "GuluTableViewCell_BigPhoto.h"


@implementation MyPostTableViewController

@synthesize postArray;
@synthesize queueArray;
@synthesize navigationController;
@synthesize tableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, -19, 320, 325)];
    [self.view addSubview:tableView];
    [self customizeTableView:tableView];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.dataSource=self;
    tableView.delegate=self;
    
	[self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
	
	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
	[self.view addSubview:LoadingView];
	LoadingView.hidden=YES;
	
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(callBackRefreshMyPostFunction)
	 name: @"refreshMyPost"
	 object:nil];
    
    [[GuluAPIAccessManager sharedManager] initUserIDandSeesionKey:appDelegate.userMe.uid sessionKey:appDelegate.userMe.sessionKey 
                                                              lat:appDelegate.myLoaction.coordinate.latitude 
                                                              lng:appDelegate.myLoaction.coordinate.longitude];
    

    if([ACCheckConnection isConnectedToNetwork])
    {
     //   [self getMyPost];
    }
    
    //================
  
    postManager=[PostManager sharedManager];
    postManager.delegate=self;
    self.queueArray=postManager.dataQueueArray;
    
}

- (void)GuluAPIAccessManagerSuccessed:(GuluHttpRequest*)httpRequest info:(id)info
{


}
- (void)GuluAPIAccessManagerFailed:(GuluHttpRequest*)httpRequest info:(id)info
{

}


- (void)GuluHttpRequestSuccessed:(GuluHttpRequest*)httpRequest info:(id)info
{
 /*   if([[NSString stringWithFormat:@"%@",httpRequest.url] isEqualToString:URL_POST_UPLOAD_PHOTO])
    {
    
        GuluPhotoModel *photoModel=info;
        
        GuluReviewModel *reviewModel=[[GuluReviewModel alloc] init];
        GuluDishModel *dishModel=[[GuluDishModel alloc] init];
        GuluPlaceModel *placeModel=[[GuluPlaceModel alloc] init];
        
        placeModel.ID=@"4e0956d0794d405dae000002";
        
        reviewModel.restaurant=placeModel;
        reviewModel.dish=dishModel;
        reviewModel.photo=photoModel;
        reviewModel.content=@"tteesstt";
        
        
        
        
        [[GuluAPIAccessManager sharedManager] createNewReview:self reviewObject:reviewModel];
    
    }
*/
    /*
    if([[NSString stringWithFormat:@"%@",httpRequest.url] isEqualToString:URL_MYGULU_MYPOST])
    {
    
    self.postArray=info;
    [self.tableView reloadData];
        
    }
     */
   /*
    for(  GuluModel *obj in info)
    {
    
        [obj showMyInfo:NO];
     //   NSLog(@"%@",[obj handleNotificatioMessageString]);
    }*/
    
    
    for(  GuluModel *obj in info)
    {
        
        [obj showMyInfo:NO];
      //  NSLog(@"%@",[obj handleNotificatioMessageString]);
    }
     
    
     
    
 //   NSLog(@"%@",info);
    
 //  [info showMyInfo:NO];
 //   NSLog(@"%@",info);
    
    
}



- (void)refresh {
    
    if([ACCheckConnection isConnectedToNetwork]){
        [self getMyPost];}
    else{
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        [self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.1];}
}

- (void)viewDidUnload {
    [super viewDidUnload];	
}

- (void)dealloc {
    
	[network cancelAllRequestsInRequestsQueue];
	[network release];
	[postArray release];
    [queueArray release];
    
    [LoadingView release];
	
	network=nil;
	postArray=nil;
    
    [super dealloc];
}


-(void)callBackRefreshMyPostFunction
{
	[self getMyPost];	
}

#pragma mark -
#pragma mark post maneger delegate Function Methods

- (void)postManagerSubmitAtIndex:(NSInteger)index
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [(ACTablePostQueueCell *)cell progresReadyToStart];
}

- (void)postManagerRemoveObjectAtIndex:(NSInteger)index
{
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:index inSection:0];
    NSArray *paths =[NSArray arrayWithObject:indexpath];
    [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationBottom];
    
    if([queueArray count]==0)
    {
        [tableView reloadData];
    }
}

- (void)postManagerAddObjectAtIndex:(NSInteger)index
{
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:index inSection:0];
    NSArray *paths =[NSArray arrayWithObject:indexpath];
    [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationBottom];
}

- (void)postManagerSuccessed:(NSInteger)index info:(id)info
{
    
   postModel *post= [postManager.postQueueArray objectAtIndex:index];
    
    if(post.todoid)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTodoList" object:nil];
    }
    
    if(post.taskid)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyMission" object:nil];
    }
    
    [self refresh];
}

- (void)postManagerFailed:(NSInteger)index error:(NSError *)error
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [cell performSelector:@selector(progresFinish) withObject:nil afterDelay:0.2];
}


#pragma mark -
#pragma mark table Function Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    

    UserHeaderView *view1 = [[[UserHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];    
    
    if(section ==0)
    {
        [view1.nameBtn setTitle:@"Pending Queue" forState:UIControlStateNormal];
        view1.imageView.hidden=YES;
        
        if([queueArray count]==0)
        {
            return nil;
        }
    }
    else if(section==1)
    {
        [view1.nameBtn setTitle:appDelegate.userMe.username forState:UIControlStateNormal];
        [view1.nameBtn addTarget:self action:@selector(gotoUserProfile) forControlEvents:UIControlEventTouchUpInside];
        
        [self customizeImageView_cell:view1.imageView];
        
        if([appDelegate.userMe.userDictionary count]==0)
        {
             [view1.imageView setImageWithURL:[NSURL URLWithString:appDelegate.userMe.userPhotoUrl]];
        }
        else
        {
            [view1.imageView setImageWithURL:[NSURL URLWithString:[[appDelegate.userMe.userDictionary objectForKey:@"photo"] objectForKey:@"image_small"]]];	
        }
        
    }
    
    return view1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==0)
    {
        return  50;
    }
    else if(indexPath.section==1)
    {
      
        UILabel *contentLabel=[[[UILabel alloc] init] autorelease];
        [contentLabel customizeLabelToGuluStyle];
        contentLabel.text=@"content content content ";
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn customizeLabelToGuluStyle];
        [btn setTitle:@"btn1" forState:UIControlStateNormal];
        CGSize btn1Size=[btn dynamicSizeOfText:CGSizeMake(300, 20)];
        [btn setTitle:@"btn2" forState:UIControlStateNormal];
        CGSize btn2Size=[btn dynamicSizeOfText:CGSizeMake(300, 20)];

        
        if(btn1Size.width + btn2Size.width >200){
            return 10+260+20+20+[contentLabel dynamicSizeOfText:CGSizeMake(300, 10000)].height+20+5;}
        else{
            return 10+260+20+[contentLabel dynamicSizeOfText:CGSizeMake(300, 10000)].height+20+5;}
        
        
        NSString *review=((GuluReviewModel *)[postArray objectAtIndex:indexPath.row]).content ;

        
        CGSize TextSizeReview = [review  sizeWithFont:AROUNDME_REVIEW_FONT
                                    constrainedToSize:AROUNDME_REVIEW_MAX_SIZE
                                        lineBreakMode:UILineBreakModeWordWrap];
        
        if(isnan(TextSizeReview.width))
            TextSizeReview.width=0;
        if(isnan(TextSizeReview.height))
            TextSizeReview.height=0;
        
        
        if(TextSizeReview.height<0)
            TextSizeReview.height=0;
        
        if(TextSizeReview.height>1000)
            TextSizeReview.height=1000;
        
        
        
        return 340+TextSizeReview.height;
        
    }
    
    return  0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    if(section==0)
    {
        return [queueArray count];
    }
    else
    {
     //   return [postArray count];
        return 10;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section==0)
    {
        
        static NSString *cellIdentifier = @"ACTablePostQueueCell";
        static NSString *nibNamed = @"ACTablePostQueueCell";
        
        ACTablePostQueueCell *cell = (ACTablePostQueueCell*) [tableview dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil];
            for (id currentObject in topLevelObjects) {
                if ([currentObject isKindOfClass:[UITableViewCell class]]){
                    cell= (ACTablePostQueueCell*) currentObject;
                    [self customizeLabel_title:cell.label];
                    [cell.btn1 addTarget:self action:@selector(submitReviewAction:) forControlEvents:UIControlEventTouchUpInside];
                    [cell initCell];}
            }
        }
        PostDataModel *data=[queueArray objectAtIndex:indexPath.row];
        
        NSString *placeName=[data.restaurantDict objectForKey:@"name"];
        NSString *dishName=[data.dishDict objectForKey:@"name"];
        
        cell.leftImageview.image=data.photo;
        cell.label.text=[NSString stringWithFormat:@"%@ @ %@",dishName,placeName];
        
        postModel *post=[postManager.postQueueArray objectAtIndex:indexPath.row];
        if(post.isSubmitStart)
        {
            [cell progresReadyToStart];
        }
        else
        {
            [cell progresFinish];
        }
        
        
        return cell;
    }
    else if(indexPath.section==1)
    {
    
        
        
        static NSString *cellIdentifier = @"GuluTableViewCell_BigPhoto";
        GuluTableViewCell_BigPhoto *cell=[GuluTableViewCell_BigPhoto cellForIdentifierOfTable:cellIdentifier table:tableview];
        
        
        /*      [cell.Btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
         [cell.Btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
         */      
        [cell.Btn1 setTitle:@"btn1" forState:UIControlStateNormal];
        [cell.Btn2 setTitle:@"btn2" forState:UIControlStateNormal];
        cell.contentLabel.text=@"content content content ";
        
        
        cell.likeView.numOfLike=9;
        cell.commentView.numOfComment=0;
        return  cell;

        
      /*  
        static NSString *cellIdentifier2 = @"ACTableAroundMeCell";
        static NSString *nibNamed2 = @"ACTableAroundMeCell";
        
        ACTableAroundMeCell *cell = (ACTableAroundMeCell*) [tableview dequeueReusableCellWithIdentifier:cellIdentifier2];
        
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed2 owner:nil options:nil];
            for (id currentObject in topLevelObjects) {
                if ([currentObject isKindOfClass:[UITableViewCell class]]){
                    cell= (ACTableAroundMeCell*) currentObject;
                    [cell initCell];
                    [self customizeImageView:cell.bigPhotoImageView];
                    [cell.likeBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
                    
                    //====
                    
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
        
        //====
        
        NSString *restaurantName=((GuluReviewModel *)[postArray objectAtIndex:indexPath.row]).restaurant.name;
        NSString *dishName=((GuluReviewModel *)[postArray objectAtIndex:indexPath.row]).dish.name;
        NSString *review=((GuluReviewModel *)[postArray objectAtIndex:indexPath.row]).content;
        
        cell.placeName=restaurantName;
        cell.dishName=dishName;
        cell.review=review;
        
        NSInteger cellheight=0;
        cellheight=[cell sizeToFitTitle];
        
        //=======
        NSInteger nLike=((GuluReviewModel *)[postArray objectAtIndex:indexPath.row]).like_count;
        NSInteger ncomment=((GuluReviewModel *)[postArray objectAtIndex:indexPath.row]).comment_count;
        
        
        CGSize size=CGSizeZero;
        if(cell.likeBtn.textlabel.font)
        {
            size =  [cell.likeBtn SizeTofit:[NSString stringWithFormat:@"%d %@",nLike,MYGULU_LIKE_STRING] 
                                   textFont:cell.likeBtn.textlabel.font];
        }
        
        [cell.likeBtn setFrame:CGRectMake(5, cellheight, size.width, 45)];
        
        cell.likeBtn.tag=indexPath.row;
        
        CGSize size2=CGSizeZero;
        if(cell.commentBtn.textlabel.font)
        {
            size2 = [cell.commentBtn SizeTofit:[NSString stringWithFormat:@"%d %@",ncomment,MYGULU_COMMENT_STRING] 
                                      textFont:cell.commentBtn.textlabel.font];
        }
        if(cell.likeBtn)
        {
            [cell.commentBtn setFrame:CGRectMake(5+cell.likeBtn.frame.size.width+5, cellheight,size2.width, 45)];
        }
        cell.commentBtn.tag=indexPath.row;
        
        
        NSString *url_key=((GuluReviewModel *)[postArray objectAtIndex:indexPath.row]).photo.image_large;
        [cell.bigPhotoImageView setImageWithURL:[NSURL URLWithString:url_key]];

        /*
        NSDictionary *dishDict=[[postArray objectAtIndex:indexPath.row] objectForKey:@"dish"];
        NSDictionary *restaurantDict=[dishDict objectForKey:@"restaurant"];
        
        
        NSString *restaurantName=[restaurantDict objectForKey:@"name"];
        NSString *dishName=[dishDict objectForKey:@"name"];
        NSString *review=[[postArray objectAtIndex:indexPath.row] objectForKey:@"content"];
        
        cell.placeName=restaurantName;
        cell.dishName=dishName;
        cell.review=review;
        
        NSInteger cellheight=0;
        cellheight=[cell sizeToFitTitle];
        
        //=======
        NSString *nLike=[[postArray objectAtIndex:indexPath.row] objectForKey:@"like_count"];
        NSString *ncomment=[[postArray objectAtIndex:indexPath.row] objectForKey:@"comment_count"];
        
        CGSize size=CGSizeZero;
        if(cell.likeBtn.textlabel.font)
        {
            size =  [cell.likeBtn SizeTofit:[NSString stringWithFormat:@"%@ %@",nLike,MYGULU_LIKE_STRING] 
                                   textFont:cell.likeBtn.textlabel.font];
        }
        
        [cell.likeBtn setFrame:CGRectMake(5, cellheight, size.width, 45)];
        
        cell.likeBtn.tag=indexPath.row;
        
        CGSize size2=CGSizeZero;
        if(cell.commentBtn.textlabel.font)
        {
            size2 = [cell.commentBtn SizeTofit:[NSString stringWithFormat:@"%@ %@",ncomment,MYGULU_COMMENT_STRING] 
                                      textFont:cell.commentBtn.textlabel.font];
        }
        if(cell.likeBtn)
        {
            [cell.commentBtn setFrame:CGRectMake(5+cell.likeBtn.frame.size.width+5, cellheight,size2.width, 45)];
        }
        cell.commentBtn.tag=indexPath.row;
        
        
        NSString *url_key=[[[postArray objectAtIndex:indexPath.row]  objectForKey:@"photo"] objectForKey:@"image_large"];
        [cell.bigPhotoImageView setImageWithURL:[NSURL URLWithString:url_key]];
        */
        
    }
    
    return  nil;
    
    
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        
  /*      GULUAPPAppDelegate *delegate=(GULUAPPAppDelegate *) [[UIApplication sharedApplication] delegate];
        delegate.gotoLastPageFromPost=NO;
        delegate.rootVC.tabVCLastSelected=delegate.rootVC.tabVC.selectedIndex;
        delegate.rootVC.tabVC.selectedViewController=[[(UINavigationController *)delegate.rootVC.tabVC viewControllers] objectAtIndex: 2];
        
        postModel *post=[postManager.postQueueArray objectAtIndex:indexPath.row];
        delegate.temp.postObj=post;
        
        PostLandingViewController *VC=[[ ((UINavigationController *)delegate.rootVC.tabVC.selectedViewController) viewControllers] objectAtIndex:0];
        [VC gotoPostWithoutCamera];
*/
        
    }
    else  if(indexPath.section==1)
    {
        NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:[postArray objectAtIndex:indexPath.row]];
        
        reviewProfileViewController *VC=[[reviewProfileViewController alloc] initWithNibName:@"reviewProfileViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
    }
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

- (void)moreAction :(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)[[btn superview] superview];
   [((ACTableAroundMeCell *)cell) showMore];
    
}


- (void)mapAction :(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)[[[btn superview] superview] superview];
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    
    NSDictionary *dishDict=[[postArray objectAtIndex:indexPath.row] objectForKey:@"dish"];
	NSMutableDictionary *restaurantDict=[NSMutableDictionary dictionaryWithDictionary:[dishDict objectForKey:@"restaurant"]];

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
    
    
    GuluReviewModel *model=[postArray objectAtIndex:indexPath.row];

    [[GuluAPIAccessManager sharedManager] unfavoriteSomething:self target_id:model.ID target_type:GuluTargetType_review];
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
    
    NSDictionary *dishDict=[[postArray objectAtIndex:indexPath.row] objectForKey:@"dish"];
	NSMutableDictionary *restaurantDict=[NSMutableDictionary dictionaryWithDictionary:[dishDict objectForKey:@"restaurant"]];
    
    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    [self todoAddRestaurantConnection:network  restaurant:restaurantDict];
    
}
 

- (void)inviteAction :(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)[[[btn superview] superview] superview];
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    
    NSDictionary *dishDict=[[postArray objectAtIndex:indexPath.row] objectForKey:@"dish"];
	NSMutableDictionary *restaurantDict=[NSMutableDictionary dictionaryWithDictionary:[dishDict objectForKey:@"restaurant"]];
    
    appDelegate.temp.inviteObj=[[[inviteModel alloc] init] autorelease];
	appDelegate.temp.inviteObj.contactDict=[[[NSMutableDictionary alloc] init] autorelease];
    appDelegate.temp.inviteObj.restaurantDict=restaurantDict;		
    
    EventViewController *VC=[[EventViewController alloc] initWithNibName:@"EventViewController" bundle:nil];	
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];
}

-(void)gotoDishProfile:(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)[[btn superview] superview] ;
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    
    NSDictionary *dishDict=[[postArray objectAtIndex:indexPath.row] objectForKey:@"dish"];
	//NSMutableDictionary *restaurantDict=[NSMutableDictionary dictionaryWithDictionary:[dishDict objectForKey:@"restaurant"]];
    
    dishProfileViewController *VC=[[dishProfileViewController alloc] initWithNibName:@"dishProfileViewController" bundle:nil];	
    //VC.dishDict=[[tableArray objectAtIndex:indexPath.row] objectForKey:@"restaurant"];
//    VC.dishDict=[NSMutableDictionary dictionaryWithDictionary:dishDict];
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];
	
}

-(void)gotoRestaurantProfile:(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    
    NSDictionary *dishDict=[[postArray objectAtIndex:indexPath.row] objectForKey:@"dish"];
	NSMutableDictionary *restaurantDict=[NSMutableDictionary dictionaryWithDictionary:[dishDict objectForKey:@"restaurant"]];
    
    RestaurantProfileViewController *VC=[[RestaurantProfileViewController alloc] initWithNibName:@"RestaurantProfileViewController" bundle:nil];	
//    VC.restaurantDict=restaurantDict;
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];
    
}

-(void)submitReviewAction:(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    
    [(ACTablePostQueueCell *)cell progresReadyToStart];
    
    [postManager postRveview:indexPath.row];
}



#pragma mark -
#pragma mark request Delegate Function Methods




- (void)likeAction:(ACButtonWithLeftImage *)button 
{
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }
    
    
    NSInteger index=button.tag;
    
    GuluReviewModel *model=[postArray objectAtIndex:index];
    
    BOOL islike=model.is_like;
   
    if(islike)
    {
        [[GuluAPIAccessManager sharedManager] unlikeSomething:self target_id:model.ID target_type:GuluTargetType_review];
    
    }
    else
    {
        [[GuluAPIAccessManager sharedManager] likeSomething:self target_id:model.ID target_type:GuluTargetType_review];
    
    }
}

- (void)getMyPost 
{
//	self.tableView.userInteractionEnabled=NO; 
	[self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
    
    GuluUserModel *user=[[[GuluUserModel alloc] init] autorelease];
    user.ID=appDelegate.userMe.uid;
    [[GuluAPIAccessManager sharedManager] userWallPost:self user:user];
}

- (void)commentAction:(ACButtonWithLeftImage *)button 
{
	NSInteger index=button.tag;

    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:[postArray objectAtIndex:index]];
    
    reviewProfileViewController *VC=[[reviewProfileViewController alloc] initWithNibName:@"reviewProfileViewController" bundle:nil];
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];

    
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
		NSLog(@"No Data");
	}
    
    
	NSLog(@"temp %@",temp);
  
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
	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"mypost"])
	{
		
		self.postArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
        
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
				//[self getMyPost];
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
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.1];	
	
//	NSString *errorString =CONNECTION_ERROR_STRING;
//	[self showErrorAlert:errorString];
}



@end

