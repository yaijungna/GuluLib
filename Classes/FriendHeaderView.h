//
//  FriendHeaderView.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/20.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACCreateButtonClass.h"

@interface FriendHeaderView : UIView {
	ACButtonWIthBottomTitle *btn1;
	ACButtonWIthBottomTitle *btn2;
	ACButtonWIthBottomTitle *btn3;
}

@property (nonatomic,retain) ACButtonWIthBottomTitle *btn1;
@property (nonatomic,retain) ACButtonWIthBottomTitle *btn2;
@property (nonatomic,retain) ACButtonWIthBottomTitle *btn3;


@end
