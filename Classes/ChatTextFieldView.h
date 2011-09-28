//
//  ChatTextFieldView.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/21.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTextFieldView : UIView {
	
	UIButton *addButton;
	UITextField *chatTextField;

}

@property(nonatomic,retain) UIButton *addButton;
@property(nonatomic,retain) UITextField *chatTextField;

@end
