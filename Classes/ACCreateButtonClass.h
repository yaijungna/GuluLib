//
//  ACCreateButtonClass.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/30.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACButtonWIthBottomTitle.h"
#import "ACButtonWithLeftImage.h"

typedef enum {
	ButtonTypeNoneType,
	ButtonTypeGuluLogo,
	ButtonTypeBack,
	ButtonTypeDone,
    ButtonTypeNext,
	ButtonTypeCancel,
	ButtonTypeSetting,
	ButtonTypeImHungry,
	ButtonTypeNormal,
	
	//=== 5 main features===
	
	ButtonTypeMyGulu,
	ButtonTypeChat,
	ButtonTypePost,
	ButtonTypeMissions,
	ButtonTypeSearch,
	
	//=== camera ===
	
	ButtonTypeTakePicture,
	ButtonTypePhotoAlbum,
	
	//=== chat ===
	
	ButtonTypeCreateEvent,
	ButtonTypeSend,
	ButtonTypeInviteGuests,
	ButtonTypeGuestsList,
	
	//=== Friend ===
	
	ButtonTypeAddFriends,
    
	
	//=== post ===
	
	ButtonTypeSave,
	ButtonTypeAdd,
	
	//=== social network ===
	
	ButtonTypeMixi,
	ButtonTypefaceBook,
	
	//=== Search ===
	
	ButtonTypeCurrentLoaction,
	
	//=== Cell ===
	
	ButtonTypeCellMore,
	ButtonTypeNumberLikes,
	ButtonTypeNumberComments,
	
	//=== More ===
	
	ButtonTypeMap,
	ButtonTypeInvite,
	ButtonTypeAddTodo,
	ButtonTypeAddFavorite,
	ButtonTypeAddMission,
    ButtonTypeUnFavorite,
    
    //=== mission ===
    
    ButtonTypeCreateMission,

	//=== other ===

	ButtonTypeLock

	
	
} ButtonType;

@interface ACCreateButtonClass : NSObject {

}

+(id) createButton :(ButtonType)btnType ;

@end
