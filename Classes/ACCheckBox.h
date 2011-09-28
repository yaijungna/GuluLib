//
//  ACCheckBox.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/10.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ACCheckBox : UIButton {
	BOOL ischecked;
	UIImage *normalImage;
	UIImage *selectedImage;
}

@property (nonatomic,retain) UIImage *normalImage;
@property (nonatomic,retain) UIImage *selectedImage;

- (void)initBtn;

@end
