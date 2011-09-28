//
//  moreView.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/15.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACButtonWIthBottomTitle.h"
#import "ACCreateButtonClass.h"

typedef enum {
	GULU_MORE_MAP=0,
    GULU_MORE_INVITE,
    GULU_MORE_TODO,
    GULU_MORE_FAVORITE
    
}GuluMoreType;


@protocol moreDelegate 

- (void)moreAction :(id)more  actionType: (GuluMoreType ) actionType ; 

@end

@interface moreView : UIView {
	ACButtonWIthBottomTitle *mapbtn;
	ACButtonWIthBottomTitle *invitebtn;
	ACButtonWIthBottomTitle *todobtn;
	ACButtonWIthBottomTitle *favoritebtn;
	ACButtonWIthBottomTitle *missionbtn;
    
    id<moreDelegate> delegate;
    
    NSIndexPath *indexPath;
}

@property (nonatomic,retain)ACButtonWIthBottomTitle *mapbtn;
@property (nonatomic,retain)ACButtonWIthBottomTitle *invitebtn;
@property (nonatomic,retain)ACButtonWIthBottomTitle *todobtn;
@property (nonatomic,retain)ACButtonWIthBottomTitle *favoritebtn;
@property (nonatomic,retain)ACButtonWIthBottomTitle *missionbtn;

@property (nonatomic,retain)NSIndexPath *indexPath;
@property(nonatomic,assign)id<moreDelegate> delegate;

@end
