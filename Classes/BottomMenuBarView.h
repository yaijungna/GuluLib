//
//  BottomMenuBarView.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/31.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACCreateButtonClass.h"

@interface BottomMenuBarView : UIView {
	
	UIImageView *bottomBackgroundImageView;
	id bottomButton1;
	id bottomButton2;
	id bottomButton3;
	id bottomButton4;
	id bottomButton5;

}

-(void) setUpMainBtnAction;
-(void) setUpMainBtnAction2;
-(void) setUpMainBtnSelected:(NSInteger)index;


-(id) initCameraBottomBarView:(ButtonType)Type1 
					   second:(ButtonType)Type2;




-(id) initOneBtnsBottomBarView:(ButtonType)Type1;

-(id) initTwoBtnsBottomBarView:(ButtonType)Type1 
						  second:(ButtonType)Type2;

-(id) initThreeBtnsBottomBarView:(ButtonType)Type1 
						  second:(ButtonType)Type2
						   third:(ButtonType)Type3;

-(id) initFourBottomsBarBottomView:(ButtonType)Type1 
							second:(ButtonType)Type2
							 third:(ButtonType)Type3
							 forth:(ButtonType)Type4;

-(id) initBottomBarView:(ButtonType)Type1 
				 second:(ButtonType)Type2
				  third:(ButtonType)Type3
				  forth:(ButtonType)Type4
				  fifth:(ButtonType)Type5;



-(void) firstBtnAction;
-(void) secondBtnAction;
-(void) thirdBtnAction;
-(void) fourthBtnAction;
-(void) fifthBtnAction;

+(void) firstBtnAction;
+(void) secondBtnAction;
+(void) thirdBtnAction;
+(void) fourthBtnAction;
+(void) fifthBtnAction;

@property (nonatomic,retain) UIImageView *bottomBackgroundImageView;
@property (nonatomic,retain) id bottomButton1;
@property (nonatomic,retain) id bottomButton2;
@property (nonatomic,retain) id bottomButton3;
@property (nonatomic,retain) id bottomButton4;
@property (nonatomic,retain) id bottomButton5;

@end
