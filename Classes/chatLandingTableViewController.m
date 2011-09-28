//
//  chatLandingTableViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/21.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "chatLandingTableViewController.h"
#import "ACTableTwoLinesWithImageCell.h"
#import "oneLineTableHeaderView.h"

#import "ChatViewController.h"
#import "chatRoomViewController.h"
#import "missionChatViewController.h"
#import "hungryChatViewController.h"

#import "UIImageView+WebCache.h"

@implementation chatLandingTableViewController

@synthesize chatArray;
@synthesize navigationController;

@synthesize chatArray_hungry;
@synthesize chatArray_mission;
@synthesize chatArray_event;

- (void)viewDidLoad {
    [super viewDidLoad];
    
	[self customizeTableView:self.tableView];
	self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
	[self.tableView setFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 320)];
	
	[self shareGULUAPP];
	network=[[ACNetworkManager alloc] init];
	network.userMe=appDelegate.userMe;
    
	
//	LoadingView=[[loadingSpinnerAndMessageView alloc] init];
//	[self.tableView addSubview:LoadingView];
//	[LoadingView release];
//	LoadingView.hidden=YES;
	
    
    if([ACCheckConnection isConnectedToNetwork])
    {
        [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
        [self getMyChat];
    }
    else
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
    }

	
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(callBackRefreshChatFunction)
	 name: @"refreshChat"
	 object:nil];
    
    [[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(callBackRefreshChatTableFunction)
	 name: @"refreshChatTable"
	 object:nil];
	
}


- (void)refresh {
    
    [network cancelAllRequestsInRequestsQueue];
	[self getMyChat];
//    [appDelegate.hungry connectToChatServerAgain];
//    [appDelegate.hungry subscribe:@"" participants:appDelegate.hungry.UUID];
    [appDelegate.hungry get_hungry];
}

- (void)viewDidUnload {
	
	[network cancelAllRequestsInRequestsQueue];
	
    [super viewDidUnload];
	
}


- (void)dealloc {
	
	[network release];
	[chatArray release];

    [chatArray_hungry release];
    [chatArray_mission release];
    [chatArray_event release];
	
    [super dealloc];
}


-(void)callBackRefreshChatFunction
{
    
	[self getMyChat];	
}

-(void)callBackRefreshChatTableFunction
{
	[self.tableView reloadData];	
}


#pragma mark -
#pragma mark segment Delegate Function Methods

- (void) touchSegmentAtIndex:(NSInteger)segmentIndex
{
	
	if(segmentIndex==0) 
	{
        self.tableView.tag=0;
		
	}
	else if(segmentIndex==1) 
	{ 
		self.tableView.tag=1;
	}
	else if(segmentIndex==2) 
	{
		self.tableView.tag=2;
	}
	else if(segmentIndex==3) 
	{
		self.tableView.tag=3;
	}
    [self.tableView reloadData];
	
}

#pragma mark -
#pragma mark table Delegate Function Methods


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	oneLineTableHeaderView *view1 = [[oneLineTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    view1.label1.text=NSLocalizedString(@"Event chats",@"[title]");
	view1.rightBtn.hidden=YES;
	[self customizeLabel:view1.label1];
    
    if(tableView.tag==0)
    {
        if(section==0)
        {
            view1.label1.text=NSLocalizedString(@"Hungry Friends Nearby",@"[title]");
        }
        if(section==1)
        {
             view1.label1.text=NSLocalizedString(@"Ongoing Chats",@"[title]");
        }
        if(section==2)
        {
            view1.label1.text=NSLocalizedString(@"Mission Chats",@"[title]");
        }
        if(section==3)
        {
            view1.label1.text=NSLocalizedString(@"Event Chats",@"[title]");
        }

    }
    if(tableView.tag==1)
    {
        if(section==0)
        {
            view1.label1.text=NSLocalizedString(@"Hungry Friends Nearby",@"[title]");
        }
        if(section==1)
        {
            view1.label1.text=NSLocalizedString(@"Ongoing Chats",@"[title]");
        }

    }
    if(tableView.tag==2)
    {
        view1.label1.text=NSLocalizedString(@"Mission Chats",@"[title]");

    }
    if(tableView.tag==3)
    {
        view1.label1.text=NSLocalizedString(@"Event Chats",@"[title]");
    }


	return [view1 autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    

    if(tableView.tag==0)
    {
        return 4;
    }
    if(tableView.tag==1)
    {
        return 2;
    }
    if(tableView.tag==2)
    {
        return 1;
    }
    if(tableView.tag==3)
    {
        return 1;
    }
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView.tag==0)
    {
        if(section == 0)
        {
            return [[appDelegate.hungry.hungryFriendsDict allValues] count];

        }
        if(section == 1)
        {
            return [appDelegate.hungry.hungryChatsArray count];
        }
        if(section == 2)
        {
            return [chatArray_mission count];
        }
        if(section == 3)
        {
            return [chatArray_event count];
        }
        
    }
    if(tableView.tag==1)
    {
        if(section == 0)
        {
            return [[appDelegate.hungry.hungryFriendsDict allValues] count];
            return 0;
        }
        if(section == 1)
        {
            return [appDelegate.hungry.hungryChatsArray count];
            return 0;
        }

    }
    if(tableView.tag==2)
    {
        return [chatArray_mission count];
    }
    if(tableView.tag==3)
    {
        return [chatArray_event count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellIdentifier = @"ACTableTwoLinesWithImageCell";
	static NSString *nibNamed = @"ACTableTwoLinesWithImageCell";
	
	ACTableTwoLinesWithImageCell *cell = (ACTableTwoLinesWithImageCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil];
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell= (ACTableTwoLinesWithImageCell*) currentObject;
				[cell initCell];
				cell.backgroundView=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"large-list-box-1.png"]] autorelease];
				[self customizeImageView_cell:cell.leftImageview];
				[cell setRightBtnToNormaltype];
			}
		}
	}
    
    if(tableView.tag==0)
    {
        if(indexPath.section==0)  //friend room
        {
            NSDictionary *userDict=[[appDelegate.hungry.hungryFriendsDict allValues] objectAtIndex:indexPath.row];
            NSString *friendName=[userDict objectForKey:@"nickname"];
            
            cell.label1.text=friendName;
            cell.label2.text=NSLocalizedString(@"Chat With your friend.", @"chat");
            cell.leftImageview.image=[UIImage imageNamed:@"gulu-Icon.png"];
        }
        if(indexPath.section==1)  //chat
        {
            NSArray *friendInChatRoom=[[appDelegate.hungry.hungryChatsArray objectAtIndex:indexPath.row] objectForKey:@"participants"];
            NSString *text=nil;
            
            for(NSDictionary *dict  in friendInChatRoom)
            {
                NSString *name=[dict objectForKey:@"display_name"];
             //   NSLog(@"%@",dict);
             //   NSLog(@"%@",name);
                
                if(text==nil){
                    text=name;}
                else{
                    text=[NSString stringWithFormat:@"%@,%@",text,name];}
            }
            
            cell.label1.text=text;
            cell.label2.text=NSLocalizedString(@"Join in chat room.", @"chat");
            cell.leftImageview.image=[UIImage imageNamed:@"gulu-Icon.png"];
            
        }
        if(indexPath.section == 2)
        {
            NSDictionary *dict=[[chatArray_mission objectAtIndex:indexPath.row] objectForKey:@"object"];
            
            
            cell.label1.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"title"]];
            cell.label2.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"description"]];
            
            NSString *url_key=[[dict  objectForKey:@"badge_pic"] objectForKey:@"image_small"];
            [cell.leftImageview setImageWithURL:[NSURL URLWithString:url_key]];
            
        }
        if(indexPath.section == 3)
        {
            NSDictionary *dict=[[chatArray_event objectAtIndex:indexPath.row] objectForKey:@"object"];
            NSDictionary *restaurantDict= [dict objectForKey:@"restaurant"];
            NSString *restaurantName;
            
            if([restaurantDict isEqual:[NSNull null]])
                restaurantName=@"";
            else
                restaurantName=[restaurantDict objectForKey:@"name"];
            
            NSDictionary *inviterDict=[dict objectForKey:@"inviter"];
            
            cell.label1.text=[NSString stringWithFormat:@"%@ @ %@",[dict objectForKey:@"title"],restaurantName];
            
            
            if([[inviterDict objectForKey:@"id"] isEqualToString:appDelegate.userMe.uid])
            {
                cell.label2.text=NSLocalizedString(@"You created this event.",@"invite");
                
            }
            else {
                cell.label2.text=[NSString stringWithFormat:@"%@ %@",[inviterDict objectForKey:@"username"],
                                  NSLocalizedString(@"invited you.",@"invite")];
                
            }
            
            if(![restaurantDict isEqual:[NSNull null]])
            {
                NSString *url_key=[[restaurantDict  objectForKey:@"photo"] objectForKey:@"image_small"];
                [cell.leftImageview setImageWithURL:[NSURL URLWithString:url_key]];
            }
                
        }
    }
    if(tableView.tag==1)
    {
        if(indexPath.section==0)  //friend room
        {
            NSDictionary *userDict=[[appDelegate.hungry.hungryFriendsDict allValues] objectAtIndex:indexPath.row];
            NSString *friendName=[userDict objectForKey:@"nickname"];
            cell.label1.text=friendName;
            cell.label2.text=NSLocalizedString(@"Chat With your friend.", @"chat");
        }
        if(indexPath.section==1)  //chat
        {
            NSArray *friendInChatRoom=[[appDelegate.hungry.hungryChatsArray objectAtIndex:indexPath.row] objectForKey:@"participants"];
            NSString *text=nil;
            
            for(NSDictionary *dict  in friendInChatRoom)
            {
                NSString *name=[dict objectForKey:@"display_name"];
             //   NSLog(@"%@",dict);
             //   NSLog(@"%@",name);
                
                if(text==nil){
                    text=name;}
                else{
                    text=[NSString stringWithFormat:@"%@,%@",text,name];}
            }
            
            cell.label1.text=text;
            cell.label2.text=NSLocalizedString(@"Join in chat room.", @"chat");

        }
        
        cell.leftImageview.image=[UIImage imageNamed:@"gulu-Icon.png"];
     
    }
    if(tableView.tag==2)
    {
        NSDictionary *dict=[[chatArray_mission objectAtIndex:indexPath.row] objectForKey:@"object"];
       
        cell.label1.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"title"]];
        cell.label2.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"description"]];
        
        NSString *url_key=[[dict  objectForKey:@"badge_pic"] objectForKey:@"image_small"];
        [cell.leftImageview setImageWithURL:[NSURL URLWithString:url_key]];
        
    }
    if(tableView.tag==3)
    {
        NSDictionary *dict=[[chatArray_event objectAtIndex:indexPath.row] objectForKey:@"object"];
        NSDictionary *restaurantDict= [dict objectForKey:@"restaurant"];
        NSString *restaurantName;
        
        if([restaurantDict isEqual:[NSNull null]])
            restaurantName=@"";
        else
            restaurantName=[restaurantDict objectForKey:@"name"];
        
        
        NSDictionary *inviterDict=[dict objectForKey:@"inviter"];
        
        cell.label1.text=[NSString stringWithFormat:@"%@ @ %@",[dict objectForKey:@"title"],restaurantName];
        
        
        if([[inviterDict objectForKey:@"id"] isEqualToString:appDelegate.userMe.uid])
        {
            cell.label2.text=NSLocalizedString(@"You created this event.",@"invite");
            
        }
        else {
            cell.label2.text=[NSString stringWithFormat:@"%@ %@",[inviterDict objectForKey:@"username"],
                              NSLocalizedString(@"invited you.",@"invite")];
            
        }
        
        if(![restaurantDict  isEqual:[NSNull null]])
        {
            NSString *url_key=[[restaurantDict  objectForKey:@"photo"] objectForKey:@"image_small"];
            [cell.leftImageview setImageWithURL:[NSURL URLWithString:url_key]];
        }

        
    }
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }
    
    
    
    
    
    if(tableView.tag==0)
    {
        if(indexPath.section==0)  // my friend chat
        {
            NSArray *arr=[appDelegate.hungry.hungryFriendsDict allKeys];
           
            if([arr count]==0)
                return;
            
            NSString *friendUID=[arr objectAtIndex:indexPath.row];
            
            hungryChatViewController *VC=[[hungryChatViewController alloc] initWithNibName:@"chatRoomViewController" bundle:nil];	
            [self.navigationController pushViewController:VC animated:YES];
            [VC release];
            
            [VC createChatRoom:friendUID];
            
        }
        
        if(indexPath.section==1)  //on going chat room
        {
            NSString *chatID=[[appDelegate.hungry.hungryChatsArray objectAtIndex:indexPath.row] objectForKey:@"chat"];
            
            hungryChatViewController *VC=[[hungryChatViewController alloc] initWithNibName:@"chatRoomViewController" bundle:nil];	
            VC.chatID=chatID;
            [self.navigationController pushViewController:VC animated:YES];
            [VC release];
            
            [VC joinChatRoom];
            
        }
        if(indexPath.section == 2) //mission chat
        {
            missionChatViewController *VC=[[missionChatViewController alloc] initWithNibName:@"chatRoomViewController" bundle:nil];	
            VC.chatDictionary=[chatArray_mission objectAtIndex:indexPath.row];
            VC.chatID=[[chatArray_mission objectAtIndex:indexPath.row] objectForKey:@"chat_uuid"];
        
            [self.navigationController pushViewController:VC animated:YES];
            [VC release];
            
        }
        if(indexPath.section == 3) //event chat
        {
            ChatViewController *VC=[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];	
            VC.chatDictionary=[chatArray_event objectAtIndex:indexPath.row];
            VC.chatID=[[chatArray_event objectAtIndex:indexPath.row] objectForKey:@"chat_uuid"];
            [self.navigationController pushViewController:VC animated:YES];
            [VC release];
        }
    }
    if(tableView.tag==1)
    {        
        if(indexPath.section==0)  // my friend chat
        {
            NSString *friendUID=[[appDelegate.hungry.hungryFriendsDict allKeys] objectAtIndex:indexPath.row];
            
            hungryChatViewController *VC=[[hungryChatViewController alloc] initWithNibName:@"chatRoomViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            [VC release];
            
             [VC createChatRoom:friendUID];
            
        }
        
        if(indexPath.section==1)  //on going chat room
        {
            NSString *chatID=[[appDelegate.hungry.hungryChatsArray objectAtIndex:indexPath.row] objectForKey:@"chat"];
            
            hungryChatViewController *VC=[[hungryChatViewController alloc] initWithNibName:@"chatRoomViewController" bundle:nil];	
            VC.chatID=chatID;

            [self.navigationController pushViewController:VC animated:YES];
            [VC release];
            
            [VC joinChatRoom];
            

        }
    
    }
    if(tableView.tag==2)
    {
        missionChatViewController *VC=[[missionChatViewController alloc] initWithNibName:@"chatRoomViewController" bundle:nil];	
        VC.chatDictionary=[chatArray_mission  objectAtIndex:indexPath.row];
        VC.chatID=[[chatArray_mission objectAtIndex:indexPath.row] objectForKey:@"chat_uuid"];
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
    
    }
    if(tableView.tag==3)
    {
        ChatViewController *VC=[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];	
        VC.chatDictionary=[chatArray_event objectAtIndex:indexPath.row];
        VC.chatID=[[chatArray_event objectAtIndex:indexPath.row] objectForKey:@"chat_uuid"];
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
    }
    
}

#pragma mark -
#pragma mark request Delegate Function Methods

- (void)getMyChat
{
    
    if([ACCheckConnection isConnectedToNetwork])
    {
        [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
        [self chatListConnection:network];
    }
    else
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        [self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.1];
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
		//NSLog(@"No Data");
        ACLog(@"No Data");
	}
	
	ACLog(@"temp %@",temp);
    
    ACLog(@"request ok");
    
    if([temp  isKindOfClass:[NSDictionary class]])
    {
        if([[temp objectForKey:@"errorMessage"] isKindOfClass:[NSString class]])
        {
         //   NSString *errorString =CONNECTION_ERROR_STRING;
         //   [self showErrorAlert:errorString];
            
            ACLog(@"request error %@",temp);
            return;
        }
    }

	
	if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"chatList"])
	{		
		self.chatArray=[[[NSMutableArray alloc] initWithArray:temp] autorelease];
        self.chatArray_event=[[[NSMutableArray alloc] init] autorelease];
        self.chatArray_hungry=[[[NSMutableArray alloc] init] autorelease];
        self.chatArray_mission=[[[NSMutableArray alloc] init] autorelease];
        
        for( NSDictionary *dict in chatArray)
        {
            NSNumber *typenumber=[dict objectForKey:@"type"];
            
            if([typenumber isEqualToNumber:[NSNumber numberWithInt:0]])
            {
                [chatArray_event addObject:dict];
            }
            if([typenumber isEqualToNumber:[NSNumber numberWithInt:1]])
            {
                [chatArray_mission addObject:dict];
            }
            if([typenumber isEqualToNumber:[NSNumber numberWithInt:2]])
            {
                [chatArray_hungry addObject:dict];
            }
        }
        
        [self.tableView reloadData];
    }
	
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{	
	[self hideSpinnerView:LoadingView];
	self.tableView.userInteractionEnabled=YES; 
	[self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.1];
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{	
    
}



@end
