//
//  chatRoomViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/6.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "newchatVC.h"

#import "ChatMessageViewCell.h"

#import "guestListViewController.h"

#import "EventEditViewController.h"


@implementation newchatVC

@synthesize chatDictionary;
@synthesize chatArray;
@synthesize participatesDict;
@synthesize myUUID;
@synthesize UUID;
@synthesize chatID;
@synthesize chat;

- (void)initViewController 
{
	myView =[[UIView alloc] initWithFrame:self.view.frame];
	[self.view  addSubview:myView];
	[myView release];	
	
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack middle:ButtonTypeGuluLogo right:ButtonTypeNormal];
	[self.view addSubview:topView];
	[topView release];
	
	[topView.topLeftButton	addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topMiddleButton addTarget:self action:@selector(landingAction) forControlEvents:UIControlEventTouchUpInside];
	
	table =[[UITableView alloc] initWithFrame:CGRectMake(0, 55, 320, 360)];
	[self customizeTableView:table];
	table.delegate=self;
	table.dataSource=self;
	[myView addSubview:table];
	[table release];	
	
	
	chatView =[[ChatTextFieldView alloc] initWithFrame:CGRectMake(0, 420, 320, 55)];
	[myView addSubview:chatView];
	[chatView release];
	[self customizeTextField:chatView.chatTextField];
	chatView.chatTextField.placeholder=CHAT_PLACEHOLDER_STRING;
	chatView.chatTextField.delegate=self;
	
	//================================
	
	self.chatArray=[[[NSMutableArray alloc] init] autorelease];
	participatesDict = [[NSMutableDictionary alloc] init] ; 

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];
    
    self.chatArray=[[[NSMutableArray alloc] init] autorelease];
    self.myUUID=@"";
    self.chat=[[[chatModel alloc] init] autorelease];
    chat=[chatModel sharedManager];
    self.chat.delegate=self;

    
    manager=[GuluChatManager sharedManager];
    manager.delegate=self;
    [manager joinChatRoom:@"77935223-0ff7-47c8-a796-5736fe900274"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    chat.delegate=nil;
    [super viewDidUnload];
}

- (void)dealloc {
    chat.delegate=nil;
	[chatArray release];
	[chatDictionary release];
	[participatesDict release];
    [myUUID release];
    [chatID release];
    [UUID release];
    
    [super dealloc];
}

-(void)GuluChatManagerDelegateDidFinishReciveData:(NSMutableDictionary *)resultDictionary
{
    
    self.chatID=[[resultDictionary objectForKey:@"chat"] objectForKey:@"chat"];
    
    /*
    self.chatID=[[resultDictionary objectForKey:@"chat"] objectForKey:@"chat"];
    
    NSLog(@"%@",chatID);
     
     */
    
    /*
     
     chat =     {
     chat = "77935223-0ff7-47c8-a796-5736fe900274";
     messages =         (
     );
     participants =         (
     {
     active = 0;
     "display_name" = "Jason Starkeke";
     "is_admin" = 0;
     "is_banned" = 0;
     "is_gone" = 0;
     "user_id" = 4e019bc0794d404864000006;
     uuid = "4f551dea-ad89-4939-a474-33ce2fd67d14";
     },
     {
     active = 1;
     "display_name" = IMCrowd;
     "is_admin" = 0;
     "is_banned" = 0;
     "is_gone" = 0;
     "user_id" = 4e006fb6794d4074c4000004;
     uuid = "8d3cb73c-419f-43d3-9c69-12792cab846d";
     },
     {
     active = 1;
     "display_name" = alanchen;
     "is_admin" = 0;
     "is_banned" = 0;
     "is_gone" = 0;
     "user_id" = 4e007497794d4005b1002ee2;
     uuid = "47f2d506-d1a5-4751-9b1c-403b7bf0752b";
     }
     );
     userUUID = "47f2d506-d1a5-4751-9b1c-403b7bf0752b";
     };
     "message_id" = 1;
     success = 1;
     }

     */


}

#
#pragma mark -
#pragma mark action Function Methods

- (void)insertCellToTable
{
    NSInteger indexPathForRow = [chatArray count]-1;
	if(indexPathForRow < 0)
		return;
    
    [table beginUpdates];
    NSArray *insertIndexPaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:[chatArray count]-1 inSection:0],nil];
    [table insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
    [table endUpdates];   
}

- (void)scrollToTableEnd
{
    NSInteger indexPathForRow = [chatArray count]-1;
	if(indexPathForRow < 0)
		return;
    
	[table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[chatArray count]-1 inSection:0]
				 atScrollPosition:UITableViewScrollPositionBottom 
						 animated:YES];
}

- (void)tabledUp 
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	CGRect Frame=CGRectMake(table.frame.origin.x, table.frame.origin.y , table.frame.size.width ,145);
	table.frame=Frame;
	[table layoutSubviews];
	[UIView commitAnimations];
	
    [self scrollToTableEnd];
}


- (void)tableDown 
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	CGRect Frame=CGRectMake(table.frame.origin.x, table.frame.origin.y , table.frame.size.width ,360);
	table.frame=Frame;
	[table layoutSubviews];
	[UIView commitAnimations];
}

- (void)chatViewUp 
{
	[self moveTheView:chatView movwToPosition:CGPointMake(0, 205)];
}

- (void)chatViewDown 
{
	[self moveTheView:chatView movwToPosition:CGPointMake(0, 420)];
}

- (void)backAction 
{
    chat.delegate=nil;
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)landingAction 
{
    chat.delegate=nil;
	[self.navigationController popViewControllerAnimated:YES];
}


#
#pragma mark -
#pragma mark  chat action Function Methods

- (void)InsertMessageByMyself:(NSString *)text
{
    // NSLog(@"%@",chatDictionary);
    
    NSMutableDictionary *dict =[[[ NSMutableDictionary alloc] init] autorelease];
    
    NSString *created=[ACUtility nsdateTofloatString:[NSDate date]];
    
    //  [dict setObject:chatID forKey:@"chat"];
    [dict setObject:text forKey:@"content"];
    [dict setObject:created forKey:@"created"];
    [dict setObject:myUUID forKey:@"sender_uuid"];
    [dict setObject:[NSString stringWithFormat:@"%d",[chatArray count]+1] forKey:@"sequence"];
    [dict setObject:@"message" forKey:@"type"];
    
    [chatArray addObject:dict];
    [self insertCellToTable];
    [self scrollToTableEnd];
}

-(void)removeChatByType:(NSString *)type
{
    for(int i=0;i<[chatArray count];i++)
    {
        if([[[chatArray objectAtIndex:i] objectForKey:@"type"] isEqualToString:type])
            [chatArray removeObjectAtIndex:i];
    }
}


#pragma mark -
#pragma mark socket Function Methods


-(void) handleChatData:(NSMutableDictionary *)Dict
{	
    
	//if ([[Dict objectForKey:@"message_id"] isEqualToNumber:[NSNumber numberWithInt:chat.subscribe_message_id]]) // first coming into the chat room
    if ([[Dict objectForKey:@"message_id"] isEqualToNumber:[NSNumber numberWithInt:chat.join_message_id]])
	{
        ACLog(@"message_id==join_message_id");
		self.myUUID=chat.sessionUUID;
        self.participatesDict=chat.participatesDict;
		self.chatArray=chat.historyMessageArray;
        
        //  NSLog(@"%@",participatesDict);
        
        //   NSLog(@"%@",Dict);
		
		[table reloadData];
        [self scrollToTableEnd];
    }
    
	if ([[Dict objectForKey:@"message_id"] isEqualToNumber:[NSNumber numberWithInt:chat.create_message_id]]) 	
    {
        
        ACLog(@"message_id==create_message_id");
        self.chatID=chat.chatUUID;
        
        ACLog(@"%@",chatID);
        
        if(chatID==nil)
        {
            chatID=@"";
            [self backAction];
        }
        //   socket=chat.socket;
        //    [chat subscribe:chatID participants:appDelegate.userMe.UUID];
        
        //   NSLog(@"%@",appDelegate.hungry.hungryChatsArray);
        //   NSLog(@"%@",appDelegate.hungry.hungryFriendsDict);
        
        //   ACLog(@"%@",appDelegate.hungry.hungryChatsArray);
        //   ACLog(@"%@",appDelegate.hungry.hungryFriendsDict);
        
        
        
        //      NSDictionary *userDict=[appDelegate.hungry.hungryFriendsDict objectForKey:createWithUserUUID];
        //      [appDelegate.hungry.hungryBlackFriendsDict setObject:userDict forKey:[NSString stringWithFormat:@"%@",createWithUserUUID]];
        //      [appDelegate.hungry.hungryFriendsDict removeObjectForKey:createWithUserUUID];
        //      [appDelegate.hungry get_hungry];
        
        [appDelegate.hungry.hungryChatsArray addObject:[Dict objectForKey:@"chat"] ];
        [appDelegate.hungry chcekAndRemoveBlockedUser];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChatTable" object:nil];
        
        
        
        // NSLog(@"%@",appDelegate.hungry.hungryChatsArray);
        // NSLog(@"%@",appDelegate.hungry.hungryFriendsDict);
        
        self.myUUID=chat.sessionUUID;
        self.participatesDict=chat.participatesDict;
		self.chatArray=chat.historyMessageArray;
        
        
    }
    
    if([[Dict objectForKey:@"type"] isEqualToString:@"participant"])// who join this caht room 
    {
        if([[Dict objectForKey:@"user_id"] isEqualToString:appDelegate.userMe.uid])
        {
            self.myUUID=[Dict objectForKey:@"uuid"];
        }
    }	
    if([[Dict objectForKey:@"type"] isEqualToString:@"message"])  //handle message
	{
        
        if([myUUID isEqualToString:[Dict objectForKey:@"sender_uuid"]])
        {
            return;  //do not show my meassage
        }
        
        [chatArray addObject:Dict];
        [self insertCellToTable];
        [self scrollToTableEnd];			
	}
    if([[Dict objectForKey:@"type"] isEqualToString:@"broadcast"])  //handle broadcast
	{
        /*    if([myUUID isEqualToString:[Dict objectForKey:@"sender_uuid"]])
         {
         return;  //do not show my meassage
         }
         */   
        [chatArray addObject:Dict];
        [self insertCellToTable];
        [self scrollToTableEnd];	
	}
}

#pragma mark -
#pragma mark TextField Delegate Function Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self chatViewDown];
    [self tableDown];
    
    if(textField.text==nil || [textField.text isEqualToString:@""] )
    {
        return YES;
    }
    
   // [chat sendMessageToChatServer:chatID message:textField.text];
    
    [manager sendMessageToChat:chatID message:textField.text];
    [self InsertMessageByMyself:textField.text];
	
	textField.text=@"";
    
    //    NSLog(@"[chatArray count] %d",[chatArray count]);
    
    
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //   NSLog(@"[chatArray count] %d",[chatArray count]);
    
	[self tabledUp];
	[self chatViewUp];
	return YES;
}

#pragma mark -
#pragma mark tableView Delegate Function Methods


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
	return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	NSDictionary *chatdict=[chatArray objectAtIndex:indexPath.row];
	NSString *participate_uuid=[chatdict objectForKey:@"sender_uuid"];
	NSString *participate_name=[[participatesDict objectForKey:participate_uuid] objectForKey:@"display_name"];
	NSString *content=[chatdict objectForKey:@"content"];
    
	
	NSString *text=[NSString stringWithFormat:@"%@: %@",participate_name,content];
	
	CGSize maxSize = CGSizeMake(200, 2000);
	
	CGSize TextSize = [text sizeWithFont:chat_text_font
                       constrainedToSize:maxSize 
                           lineBreakMode:UILineBreakModeWordWrap];
	
	if(TextSize.height<30)
		TextSize.height=30;
    
    CGSize Size=[ChatMessageViewCell sizeOfImageFromURL:content];
    if([ChatMessageViewCell  isImageLink:content]   && [[chatdict objectForKey:@"type"] isEqualToString:@"message"] && Size.width && Size.height)
    {
        return Size.height/2+10+10+12+3;
    }
    
	return TextSize.height+10+10+12+3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [chatArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellIdentifier = @"ChatMessageViewCell";
	static NSString *nibNamed = @"ChatMessageViewCell";
	
	ChatMessageViewCell *cell = (ChatMessageViewCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil];
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell= (ChatMessageViewCell*) currentObject;
				[cell initCell];
			}
		}
	}
    
	
	NSDictionary *chatdict=[chatArray objectAtIndex:indexPath.row];
	NSString *participate_uuid=[chatdict objectForKey:@"sender_uuid"];
	NSString *participate_name=[[participatesDict objectForKey:participate_uuid] objectForKey:@"display_name"];
    
    //==================================================================
    
    if([[chatdict objectForKey:@"type"] isEqualToString:@"message"])
    {
        NSString *content=[chatdict objectForKey:@"content"];
        cell.nameLabel.text=[NSString stringWithFormat:@"%@:",participate_name];
        cell.messageLabel.text=[NSString stringWithFormat:@"%@",content];
        CGSize Size=[ChatMessageViewCell sizeOfImageFromURL:content];
        
        if([ChatMessageViewCell isImageLink:content] && Size.width && Size.height)  //photo
        {
            cell.WebView.hidden=NO;
            cell.messageLabel.hidden=YES;
            
            NSURL *url = [NSURL URLWithString:content];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
            
            [cell.WebView loadHTMLString:[NSString stringWithFormat:@"<html><body><img src='%@' height='%fpx' width='%fpx' margin=0;padding=0></body></html>",content,Size.height*2,Size.width*2 ] baseURL:nil];
            [request release];
        }
        else   //message
        {
            cell.WebView.hidden=YES;
            cell.messageLabel.hidden=NO;
        }
        
    }
    
    //--------------------------------
    
    if([[chatdict objectForKey:@"type"] isEqualToString:@"broadcast"])
    {
        NSString *action_type=[chatdict objectForKey:@"action_type"];
        cell.WebView.hidden=YES;
        cell.messageLabel.hidden=NO;
        
        if([action_type isEqualToString:@"rsvp"])
        {
            NSNumber *status=[chatdict objectForKey:@"status"];
            NSString *content=[NSString stringWithFormat:@"%@->%@",action_type,status];
            
            cell.messageLabel.text=[NSString stringWithFormat:@"%@: %@",participate_name,content];
        }
        if([action_type isEqualToString:@"vote"])
        {
            NSNumber *object_id=[chatdict objectForKey:@"object_id"];
            NSString *content=[NSString stringWithFormat:@"%@->%@",action_type,object_id];
            
            cell.messageLabel.text=[NSString stringWithFormat:@"%@: %@",participate_name,content];
        }
        if([action_type isEqualToString:@"add_new"])
        {
            NSString *content=[NSString stringWithFormat:@"%@",action_type];
            
            cell.messageLabel.text=[NSString stringWithFormat:@"%@: %@",participate_name,content];
        }
        if([action_type isEqualToString:@"delete_item"])
        {
            NSString *content=[NSString stringWithFormat:@"%@",action_type];
            
            cell.messageLabel.text=[NSString stringWithFormat:@"%@: %@",participate_name,content];
        }
        
    }
    
    //==================================================================
    
	if([myUUID isEqualToString:participate_uuid])	//my bubble
	{
		[cell messageMine];
	}
	else	//others bubble
	{
		[cell messageOthers];
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self tableDown];
	[self chatViewDown];
	[chatView.chatTextField resignFirstResponder];
}




@end
