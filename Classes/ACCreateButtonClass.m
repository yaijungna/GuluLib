//
//  ACCreateButtonClass.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/30.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACCreateButtonClass.h"
#import "AppSettings.h"

@implementation ACCreateButtonClass



+(id) createButton :(ButtonType)btnType 
{
	id btn = ButtonTypeNoneType ;
	UIButton *normalbtn;
	ACButtonWIthBottomTitle *btnWithTitle;
	ACButtonWithLeftImage	*btnWithLeftImage;
	
	switch (btnType) {
		case ButtonTypeNoneType:
		default:	// GMC
			normalbtn=[[UIButton alloc] initWithFrame:CGRectZero];
			btn=normalbtn;
			break;
		case ButtonTypeGuluLogo:
			normalbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64,64 )];
			//[normalbtn setBackgroundImage:[UIImage imageNamed:@"gulu-Icon.png"] forState:UIControlStateNormal];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"gulu-logo-no-tagline-1.png"] forState:UIControlStateNormal];
			btn=normalbtn;
			break;
		case ButtonTypeBack:
			normalbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65,30 )];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"back-button-iocn.png"] forState:UIControlStateNormal];
			[normalbtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
			[normalbtn.titleLabel setTextColor:[UIColor whiteColor]];
			[normalbtn setTitle:NSLocalizedString(@"Back",@"[button] Back") forState:UIControlStateNormal];
			btn=normalbtn;
			break;
        case ButtonTypeNext:
			normalbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65,30 )];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"next-button-1.png"] forState:UIControlStateNormal];
			[normalbtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
			[normalbtn.titleLabel setTextColor:[UIColor whiteColor]];
			[normalbtn setTitle:NSLocalizedString(@"Next",@"[button] Next") forState:UIControlStateNormal];
			btn=normalbtn;
			break;
		case ButtonTypeDone:
			normalbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65,30 )];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"button-1.png"] forState:UIControlStateNormal];
			[normalbtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
			[normalbtn.titleLabel setTextColor:[UIColor whiteColor]];
			[normalbtn setTitle:NSLocalizedString(@"Done",@"[button] done") forState:UIControlStateNormal];
			btn=normalbtn;
			break;
		case ButtonTypeCancel:
			normalbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65,30 )];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"button-1.png"] forState:UIControlStateNormal];
			[normalbtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
			[normalbtn.titleLabel setTextColor:[UIColor whiteColor]];
			[normalbtn setTitle:NSLocalizedString(@"Cancel",@"[button] cancel") forState:UIControlStateNormal];
			btn=normalbtn;
			break;			
		case ButtonTypeSetting:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0, 64,47 )];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"settings-icon-1.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"settings-icon-1.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"settings-icon-1.png"];
			btnWithTitle.btnTitleLabel.text=NSLocalizedString(@"ACCOUNT",@"[button] settings");
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_BOLD size:10]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(25, 25)];
			btn=btnWithTitle;
			
			break;
		case ButtonTypeImHungry:
            normalbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 110,35 )];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"button-2.png"] forState:UIControlStateNormal];
			[normalbtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:11]];
			[normalbtn.titleLabel setTextColor:[UIColor whiteColor]];
			[normalbtn setTitle:NSLocalizedString(@"I'm Hungry",@"[button]I am hungry") forState:UIControlStateNormal];
			btn=normalbtn;
			break;			
			
		case ButtonTypeNormal:
			normalbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65,30 )];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"button-1.png"] forState:UIControlStateNormal];
			[normalbtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
			[normalbtn.titleLabel setTextColor:[UIColor whiteColor]];
			//[normalbtn setTitle:NSLocalizedString(@"Cancel",@"[button] cancel") forState:UIControlStateNormal];
			btn=normalbtn;
			break;			
			
			
			
			
		//=== 5 main features===
		
		case ButtonTypeMyGulu:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0, 64,49 )];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"inactive-my-gulu-icon-1.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"inactive-my-gulu-icon-1.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"active-my-gulu-icon-1.png"];
			btnWithTitle.btnTitleLabel.text=NSLocalizedString(@"MY GULU",@"[button] 5 main feature button");
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_BOLD size:10]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(34, 27)];
			btn=btnWithTitle;
			break;
		case ButtonTypeChat:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0, 64,49 )];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"inactive-chat-icon-1.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"inactive-chat-icon-1.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"active-chat-icon-1.png"];
			btnWithTitle.btnTitleLabel.text=NSLocalizedString(@"CHAT",@"[button] 5 main feature button");
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_BOLD size:10]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(34, 27)];
			btn=btnWithTitle;
			break;
		case ButtonTypePost:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0,64,49 )];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"inactive-post-icon-1.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"inactive-post-icon-1.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"active-post-icon-1.png"];
			btnWithTitle.btnTitleLabel.text=NSLocalizedString(@"POST",@"[button] 5 main feature button");
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_BOLD size:10]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(34, 27)];
			btn=btnWithTitle;
			break;
		case ButtonTypeMissions:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0, 64,49 )];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"inactive-mission-icon-1.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"inactive-mission-icon-1.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"active-mission-icon-1.png"];
			btnWithTitle.btnTitleLabel.text=NSLocalizedString(@"MISSION",@"[button] 5 main feature button");
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_BOLD size:10]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(30, 31)];
			btn=btnWithTitle;
			break;
		case ButtonTypeSearch:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0, 64,49 )];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"inactive-search-icon-1.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"inactive-search-icon-1.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"active-search-icon-1.png"];
			btnWithTitle.btnTitleLabel.text=NSLocalizedString(@"SEARCH",@"[button] 5 main feature button");
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_BOLD size:10]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(34, 27)];
			btn=btnWithTitle;
			break;
		
		//=== camera ===
		
		case ButtonTypePhotoAlbum:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0, 50,49 )];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"inactive-album-icon.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"inactive-album-icon.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"active-album-icon.png"];
			btnWithTitle.btnTitleLabel.text=NSLocalizedString(@"Album",@"[button] photo album in phone ");
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(30, 25)];
			btn=btnWithTitle;
			break;
		case ButtonTypeTakePicture:
			normalbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 140,40 )];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"take-picture-button.png"] forState:UIControlStateNormal];
			[normalbtn.titleLabel setFont:[UIFont fontWithName:FONT_NORMAL size:12]];
			[normalbtn.titleLabel setTextColor:[UIColor blackColor]];
			[normalbtn setTitle:NSLocalizedString(@"",@"") forState:UIControlStateNormal];
			btn=normalbtn;
			break;
		
		//=== chat ===
			
		case ButtonTypeCreateEvent:
			normalbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100,35 )];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"button-1.png"] forState:UIControlStateNormal];
			[normalbtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
			[normalbtn.titleLabel setTextColor:[UIColor whiteColor]];
			[normalbtn setTitle:NSLocalizedString(@"Create Event",@"[button] Create event") forState:UIControlStateNormal];
			btn=normalbtn;
			break;
		case ButtonTypeSend:
			normalbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65,35 )];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"button-1.png"] forState:UIControlStateNormal];
			[normalbtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
			[normalbtn.titleLabel setTextColor:[UIColor whiteColor]];
			[normalbtn setTitle:NSLocalizedString(@"Send",@"[button] Send") forState:UIControlStateNormal];
			btn=normalbtn;
			break;
		case ButtonTypeInviteGuests:
			normalbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200,60 )];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"button-0.png"] forState:UIControlStateNormal];
			[normalbtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:16]];
			[normalbtn.titleLabel setTextColor:[UIColor whiteColor]];
			[normalbtn setTitle:NSLocalizedString(@"Invite Guests!",@"[button] Invite Guests") forState:UIControlStateNormal];
			btn=normalbtn;
			break;
			
		case ButtonTypeGuestsList:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0, 70,50 )];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"guest-list-icon-1.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"guest-list-icon-1.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"guest-list-icon-1.png"];
			btnWithTitle.btnTitleLabel.text=NSLocalizedString(@"Guest List",@"[button]");
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(30, 30)];
			btn=btnWithTitle;
			break;

			
		//=== Friend ===
			
		case ButtonTypeAddFriends:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0, 80,50 )];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"inactive add-friend-1.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"inactive add-friend-1.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"active-add-friend-icon-1.png"];
			btnWithTitle.btnTitleLabel.text=NSLocalizedString(@"Add Friends",@"[button] add friend");
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(30, 30)];
			btn=btnWithTitle;
			break;

		//=== post ===
			
		case ButtonTypeSave:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0, 50,49 )];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"inactive-save-icon-1.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"inactive-save-icon-1.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"active-save-icon-1.png"];
			btnWithTitle.btnTitleLabel.text=NSLocalizedString(@"SAVE",@"[button] save post");
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(34, 27)];
			btn=btnWithTitle;
			break;
		case ButtonTypeAdd:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0, 50,49 )];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"inactive-add-icon-1.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"inactive-add-icon-1.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"active-add-icon-1.png"];
			btnWithTitle.btnTitleLabel.text=NSLocalizedString(@"ADD",@"[button] add function in post review page,");
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(30,30)];
			btn=btnWithTitle;
			break;
			
		//=== social network ===
			
		case ButtonTypeMixi:
			normalbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40,40 )];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"inactive-mixi-icon-1.png"] forState:UIControlStateNormal];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"active-mixi-icon-1.png"] forState:UIControlStateSelected];
			[normalbtn.titleLabel setFont:[UIFont fontWithName:FONT_NORMAL size:12]];
			[normalbtn.titleLabel setTextColor:[UIColor blackColor]];
			[normalbtn setTitle:NSLocalizedString(@"",@"") forState:UIControlStateNormal];
			btn=normalbtn;
			break;
			
		case ButtonTypefaceBook:
			normalbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40,40 )];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"inactive-FB-icon-1.png"] forState:UIControlStateNormal];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"active-FB-icon-1.png"] forState:UIControlStateSelected];
			[normalbtn.titleLabel setFont:[UIFont fontWithName:FONT_NORMAL size:12]];
			[normalbtn.titleLabel setTextColor:[UIColor blackColor]];
			[normalbtn setTitle:NSLocalizedString(@"",@"") forState:UIControlStateNormal];
			btn=normalbtn;
			break;
			
		//=== Search ===
			
		case ButtonTypeCurrentLoaction:
			normalbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 140,40 )];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"button-1.png"] forState:UIControlStateNormal];
			[normalbtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:14]];
			[normalbtn.titleLabel setTextColor:[UIColor whiteColor]];
			[normalbtn setTitle:NSLocalizedString(@"Current Location",@"show this string on the map") forState:UIControlStateNormal];
			btn=normalbtn;
			break;
			
		//=== Cell ===
			
		case ButtonTypeCellMore:
			normalbtn=[[ACButtonWithLeftImage alloc] initWithFrame:CGRectMake(0, 0, 25, 20)];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"more-icon-1.png"] forState:UIControlStateNormal];
			btn=normalbtn;
			break;
			
		case ButtonTypeNumberLikes:
			
			btnWithLeftImage=[[ACButtonWithLeftImage alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
			[btnWithLeftImage.leftImageView setImage:[UIImage imageNamed:@"active-like-star-1.png"]];
			[btnWithLeftImage.leftImageView setFrame:CGRectMake(10, 12, 16, 15)];
			[btnWithLeftImage.textlabel setTextColor:TEXT_COLOR];
			[btnWithLeftImage.textlabel setFont:[UIFont fontWithName:FONT_NORMAL size:12]];

			btn=btnWithLeftImage;
			break;
			
		case ButtonTypeNumberComments:
			btnWithLeftImage=[[ACButtonWithLeftImage alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
			[btnWithLeftImage.leftImageView setImage:[UIImage imageNamed:@"inactive-comment-bubble-1.png"]];
			[btnWithLeftImage.leftImageView setFrame:CGRectMake(10, 12, 27, 16)];
			[btnWithLeftImage.textlabel setTextColor:TEXT_COLOR];
			[btnWithLeftImage.textlabel setFont:[UIFont fontWithName:FONT_NORMAL size:12]];
			
			btn=btnWithLeftImage;
			break;
			
		//=== More ===
			
		case ButtonTypeMap:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0, 64,50)];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"inactive-map-icon-1.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"inactive-map-icon-1.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"active-map-icon-1.png"];
			btnWithTitle.btnTitleLabel.text=NSLocalizedString(@"MAP",@"[button] map button");
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_BOLD size:10]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(30, 30)];
			btn=btnWithTitle;
			break;
		case ButtonTypeInvite:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0, 64,50)];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"inactive-invite-icon-1.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"inactive-invite-icon-1.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"active-invite-icon-1.png"];
			btnWithTitle.btnTitleLabel.text=NSLocalizedString(@"INVITE",@"[button] invite button");
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_BOLD size:10]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(40, 30)];
			btn=btnWithTitle;
			break;
		case ButtonTypeAddFavorite:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0, 80,50)];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"inactive-favorite-icon-1.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"inactive-favorite-icon-1.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"active-favorite-icon-1.png"];
			btnWithTitle.btnTitleLabel.text=NSLocalizedString(@"FAVORITE",@"[button] favorite button");
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_BOLD size:10]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(33, 30)];
			btn=btnWithTitle;
			break;
		case ButtonTypeAddTodo:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0, 64,50)];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"inactive-+todo-icon-1.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"inactive-+todo-icon-1.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"active-+todo-icon-1.png"];
            
			btnWithTitle.btnTitleLabel.text=NSLocalizedString(@"+TO DO",@"[button] add to do button");
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_BOLD size:10]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(31, 30)];
			btn=btnWithTitle;
			break;
		case ButtonTypeAddMission:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0, 64,50)];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"inactive-+mission-icon-1.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"inactive-+mission-icon-1.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"active-+mission-icon-1.png"];
			btnWithTitle.btnTitleLabel.text=NSLocalizedString(@"+MISSION",@"[button] add Mission button");
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_BOLD size:10]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(40, 30)];
			btn=btnWithTitle;
			break;
        case ButtonTypeUnFavorite:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0, 80,50)];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"inactive-favorite-icon-1.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"inactive-favorite-icon-1.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"active-favorite-icon-1.png"];
			btnWithTitle.btnTitleLabel.text=NSLocalizedString(@"UNFAVORITE",@"[button] favorite button");
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_BOLD size:10]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(33, 30)];
			btn=btnWithTitle;
			break;

            
        //=== mission ===
            
        case ButtonTypeCreateMission:
			normalbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100,35 )];
			[normalbtn setBackgroundImage:[UIImage imageNamed:@"button-1.png"] forState:UIControlStateNormal];
			[normalbtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
			[normalbtn.titleLabel setTextColor:[UIColor whiteColor]];
			[normalbtn setTitle:NSLocalizedString(@"Create Mission",@"[button] Create mission") forState:UIControlStateNormal];
			btn=normalbtn;
			break;

		//=== other ===
		
		case ButtonTypeLock:
			btnWithTitle=[[ACButtonWIthBottomTitle alloc] initWithFrame:CGRectMake(0, 0, 60,50 )];
			btnWithTitle.imgView.image=[UIImage imageNamed:@"inactive-lock-1.png"];
			btnWithTitle.normalImage=[UIImage imageNamed:@"inactive-lock-1.png"];
			btnWithTitle.hightlightImage=[UIImage imageNamed:@"active-lock-1.png"];
			[btnWithTitle.btnTitleLabel setFont:[UIFont fontWithName:FONT_NORMAL size:12]];
			[btnWithTitle.btnTitleLabel setTextColor:lightBrownColor];
			[btnWithTitle setImageViewSize:CGSizeMake(25,30)];
			
			btn=btnWithTitle;
			break;
		
		// GMC - just in case, you do not want a garbage value returned in
		// btn in the case something strange happens. I moved default to the top
		//default:
		//	break;
	}
	
	return [btn autorelease];
}


@end
