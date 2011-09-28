//
//  ChatEventHeaderView.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACCreateButtonClass.h"

@interface ChatEventHeaderView : UIView {
	UILabel *label1;
	UILabel *label2;
	UILabel *label3;
	ACButtonWIthBottomTitle *rightBtn;
	

}

@property (nonatomic,retain) UILabel *label1;
@property (nonatomic,retain) UILabel *label2;
@property (nonatomic,retain) UILabel *label3;
@property (nonatomic,retain) ACButtonWIthBottomTitle *rightBtn;

@end
