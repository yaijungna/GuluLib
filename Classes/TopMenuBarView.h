//
//  TopMenuBarView.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/31.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACCreateButtonClass.h"

@interface TopMenuBarView : UIView {
	
	UIImageView *topBackgroundImageView;
	id topLeftButton;
	id topMiddleButton;
	id topRightButton;
}

@property (nonatomic,retain) UIImageView *topBackgroundImageView;
@property (nonatomic,retain) id topLeftButton;
@property (nonatomic,retain) id topMiddleButton;
@property (nonatomic,retain) id topRightButton;

-(id) initTopBarView :(ButtonType)leftType middle:(ButtonType)middleType right:(ButtonType)rightType ;

@end
