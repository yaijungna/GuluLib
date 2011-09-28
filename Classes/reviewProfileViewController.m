//
//  reviewProfileViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/5.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "reviewProfileViewController.h"

#import "EventViewController.h"
#import "userProfileViewController.h"
#import "userFriendProfileViewController.h"

@implementation reviewProfileViewController

@synthesize targetID;
@synthesize targetType;
@synthesize reviewModel;

@synthesize objectRequest;
@synthesize commentRequest;

-(void) initViewController
{
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
	[self.view addSubview:topView];
	[topView release];
    [topView.topLeftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topMiddleButton addTarget:self action:@selector(landingAction) forControlEvents:UIControlEventTouchUpInside];
    
    bottomView=[[[BottomMenuBarView alloc] initWithFrame:CGRectMake(0, 410, 320, 50)] initFourBottomsBarBottomView:ButtonTypeMap second:ButtonTypeInvite third:ButtonTypeAddTodo forth:ButtonTypeAddFavorite];
	[self.view addSubview:bottomView];
	[bottomView release];
    
    [((ACButtonWIthBottomTitle *)bottomView.bottomButton1).btn addTarget:self action:@selector(mapAction) forControlEvents:UIControlEventTouchUpInside];
	[((ACButtonWIthBottomTitle *)bottomView.bottomButton2).btn addTarget:self action:@selector(inviteAction) forControlEvents:UIControlEventTouchUpInside];
    [((ACButtonWIthBottomTitle *)bottomView.bottomButton3).btn addTarget:self action:@selector(todoAction) forControlEvents:UIControlEventTouchUpInside];
	[((ACButtonWIthBottomTitle *)bottomView.bottomButton4).btn addTarget:self action:@selector(favoriteAction) forControlEvents:UIControlEventTouchUpInside];    
       
    //====================================
    
    chatView =[[ChatTextFieldView alloc] initWithFrame:CGRectMake(0, 320, 320, 50)];
	[myView addSubview:chatView];
	[self customizeTextField:chatView.chatTextField];
	chatView.chatTextField.placeholder=NSLocalizedString(@"", @"comment placeholder ");
	chatView.chatTextField.delegate=self;
    
    commentTable=[[ReviewAndCommentsListTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 320) pullToRefresh:YES];
	[myView addSubview:commentTable];
    commentTable.refreshDelegate=self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];
    
    commentTable.tableArray=[[[NSMutableArray alloc] init] autorelease];
    [commentTable.tableArray insertObject:reviewModel atIndex:0];
    [commentTable reloadData];
    
    if(reviewModel.ID==nil)
    {
        [self getGeneralObject];
    }
    else
    {
        [self getcommentList];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {

    [chatView release];
    [commentTable release];
    
    [targetID release];
    [reviewModel release];
    
    [objectRequest release];
    [commentRequest release];
    [super dealloc];
}

#pragma mark -
#pragma mark action Function Methods

-(void)backAction
{
	[self.navigationController popViewControllerAnimated:YES];    
}

-(void)landingAction
{

    [self.navigationController popToRootViewControllerAnimated:YES];	
}

-(void)textViewUp
{
    [self moveTheView:myView movwToPosition:CGPointMake(0, -120)];
}

-(void)textViewDown
{
  	[self moveTheView:myView movwToPosition:CGPointMake(0, 50)];
}

- (void)scrollToTableEnd
{
    NSInteger indexPathForRow = [commentTable.tableArray count]-1;
    
	[commentTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPathForRow inSection:0]
				 atScrollPosition:UITableViewScrollPositionBottom 
						 animated:YES];
}



#pragma mark -
#pragma mark TextField Delegate Function Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self textViewDown];
    [textField resignFirstResponder];
    
    if([textField.text isEqualToString:@""] || textField.text==nil)
    {
        return YES;
    }
    else
    {
        [self postComment];
        return YES;
    }
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self textViewUp];
	return YES;
}


#pragma mark -
#pragma mark request Methods


-(void)getGeneralObject
{
    [loadingSpinner startAnimating];
    self.objectRequest=[APIManager getObject:self target_id:targetID target_type:targetType];
}

-(void)getcommentList
{
    [loadingSpinner startAnimating];
    self.commentRequest=[APIManager commentsList:self target_id:reviewModel.ID];
}

-(void)postComment
{
 //   NSString *target_id=[reviewDict objectForKey:@"target_id"];
 //   NSString *target_type=[reviewDict objectForKey:@"target_type"];
  //  [self commentPostConnection:network target_id:target_id target_type:target_type text:chatView.chatTextField.text];
    chatView.chatTextField.text=@"";
}
/*
- (void)favoriteAction
{
    if([reviewDict objectForKey:@"dish"])
    {
        [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
   //     [self favoriteDishConnection:network dish:[reviewDict objectForKey:@"dish"]];
    }
}

-(void)todoAction
{
    
    if([reviewDict objectForKey:@"dish"])
    {
        [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
   //     [self todoAddDishConnection:network dish:[reviewDict objectForKey:@"dish"]];
    }
}
*/

- (void)GuluAPIAccessManagerSuccessed:(GuluHttpRequest*)httpRequest info:(id)info
{
    [loadingSpinner stopAnimating];
    
    if([info isKindOfClass:[GuluErrorMessageModel class]]){
        [info showMyInfo:YES];
        return;
    }
    
    if(httpRequest == commentRequest)
    {
        if([info isKindOfClass:[NSArray class]])
        {
            commentTable.tableArray=[[[NSMutableArray alloc] initWithArray:info] autorelease];
            [commentTable.tableArray insertObject:reviewModel atIndex:0];
            [commentTable reloadData];
            
            [self scrollToTableEnd];
        }
    }
    
    if(httpRequest == objectRequest)
    {
        if([info isKindOfClass:[GuluReviewModel class]])
        {
            self.reviewModel=info;
            [self getcommentList];
        }
    }
    

    
    
    /*
    if(httpRequest == targetObjectRequest)
    {
        if([info isKindOfClass:[GuluReviewModel class]])
        {
            reviewProfileViewController *VC=[[reviewProfileViewController alloc] initWithNibName:@"reviewProfileViewController" bundle:nil];
            VC.reviewModel=info;
            [self.navigationController pushViewController:VC animated:YES];
            [VC release];
        }
        
    }*/
}

- (void)GuluAPIAccessManagerFailed:(GuluHttpRequest*)httpRequest info:(id)info
{
     [loadingSpinner stopAnimating];
}




#pragma mark -
#pragma mark action Function Methods

- (void)mapAction 
{
  // [self gotoMap:[[reviewDict objectForKey:@"dish"] objectForKey:@"restaurant"]];	
}


- (void)inviteAction
{
	appDelegate.temp.inviteObj=[[[inviteModel alloc] init] autorelease];
	appDelegate.temp.inviteObj.contactDict=[[[NSMutableDictionary alloc] init] autorelease];	
	
	EventViewController *VC=[[EventViewController alloc] initWithNibName:@"EventViewController" bundle:nil];	
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];
}

-(void)gotoUserProfile
{
    userProfileViewController *VC=[[userProfileViewController alloc] initWithNibName:@"userProfileViewController" bundle:nil];	
    VC.userDict=[NSMutableDictionary dictionaryWithDictionary:appDelegate.userMe.userDictionary];
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];
}

-(void)gotoFriendProfile:(UIButton *)btn
{
    
    userFriendProfileViewController *VC=[[userFriendProfileViewController alloc] initWithNibName:@"userFriendProfileViewController" bundle:nil];	
	[self.navigationController pushViewController:VC animated:YES];
	[VC release];
}


#pragma mark -

-(void)GuluTableViewRefreshDelegateTrgger :(GuluTableView *)guluTable
{
    [commentTable performSelector:@selector(doneLoadingGuluRefreshTableViewData) withObject:nil afterDelay:0.1];
}


/*
-(void)ACConnectionSuccess:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:.1];
    
    [table reloadData];
	
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
	
	if( temp ==nil || [temp isEqual:[NSNull null]] || [temp count]==0 )
	{
		NSLog(@"No Data");
	}
	
    
    NSLog(@"temp %@",temp);
    
    if([temp  isKindOfClass:[NSDictionary class]])
    {
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
        {
            NSString *errorString =CONNECTION_ERROR_STRING;
            [self showErrorAlert:errorString];
            return;
        }
    }

    
	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"commentlist"])
	{
		
		self.commentsArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
		[table reloadData];
        [self scrollToTableEnd];
	}
    
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"commentpost"])
	{
        [self getcommentList];
    }
    
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"generalobject"])
	{
        
        if([[temp objectForKey:@"object_type"] isEqualToString:@"1"])//review
        {
            self.reviewDict=[NSMutableDictionary dictionaryWithDictionary:[temp objectForKey:@"object"]];
            self.userDict=[NSMutableDictionary dictionaryWithDictionary:[reviewDict objectForKey:@"user"]];
            [self showData];
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
	else if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"addFavoriteDish"])
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
	else if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"addTodoDish"])
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
    [self hideSpinnerView:LoadingView];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:.1];
	
//	NSString *errorString =CONNECTION_ERROR_STRING;
//	[self showErrorAlert:errorString];
}
*/

@end
