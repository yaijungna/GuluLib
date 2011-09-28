//
//  ACActionSheetView.h
//  GULUAPP
//
//  Created by alan on 11/8/17.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ACActionSheetViewDelegate;

@interface ACActionSheetView : UIView
{
    UIImageView *backGroundImageView;
    UIView *sheetView;
	NSMutableArray *buttonsArray;
    id deleagte;
    UIView *aboveView;
    
}

@property (nonatomic,retain) UIImageView *backGroundImageView;
@property (nonatomic,retain) UIView *sheetView;
@property (nonatomic,retain) NSMutableArray *buttonsArray;
@property (nonatomic,retain) UIView *aboveView;
@property (nonatomic,assign) id deleagte;

- (id)initWithAboveSheet:(UIView *)aboveview;
- (NSInteger)addButton:(UIButton *)btn;
- (void)dismissSheet;
- (void)showFromBottom;


@end


//=======
@protocol ACActionSheetViewDelegate

@optional

-(void) ACActionSheetViewTapAtIndexButton:(ACActionSheetView *)view index:(NSInteger)index;

@end
