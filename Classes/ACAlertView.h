//
//  ACAlertView.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import "AppSettings.h"

#define ALERT_WIDTH 300
#define ALERT_HEIGHT 400

#define ALERT_TITLE_MIN_HEIGHT	30
#define ALERT_TEXT_MIN_HEIGHT	100

#define ALERT_TITLE_MAX_HEIGHT	50
#define ALERT_TEXT_MAX_HEIGHT	0

#define ALERT_UP_PADDING		25
#define ALERT_DOWN_PADDING		25
#define ALERT_LEFT_PADDING		20
#define ALERT_RIGHT_PADDING		20
#define ALERT_BETWEEN_PADDING	10

#define ALERT_BUTTON_HEIGHT	35
#define ALERT_BUTTON_WIDTH	100

typedef enum 
{
	alertSmallSzie=0,
	alertMidiumSzie,
	alertBigSzie

} ACAlertViewSizeType;


@protocol ACAlertViewDelegate;

@interface ACAlertView :  UIAlertView {
	
	id <ACAlertViewDelegate> Delegate;
	UIButton *firstBtn;
	UIButton *secondBtn;
	UILabel *titleLabel;
	UILabel *textLabel;
}

-(void) setBackgroundImage :(UIImage *)theImage;
-(void)	setButtonImage :(UIImage *)theImage  highlight:(UIImage *)highLightImage;
-(void) setframeToDefinedSize :(ACAlertViewSizeType )type;
-(void) setStringAndSizeToFit :(NSString *)titleStr 
						  text:(NSString *)textStr 
					 firstFont:(UIFont *)font1 
					secondFont:(UIFont *)font2 
					  firstBtn:(NSString *)btnStr1 
					 secondBtn:(NSString *)btnStr2 ;

@property (nonatomic,retain) id <ACAlertViewDelegate> ACDelegate;
@property (nonatomic,retain) UIButton *firstBtn;
@property (nonatomic,retain) UIButton *secondBtn;
@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UILabel *textLabel;

@end

@protocol ACAlertViewDelegate
@optional
-(void) ACAlertViewDelegateFirstBtnAction:(ACAlertView*)alert;
-(void) ACAlertViewDelegateSecondBtnAction:(ACAlertView*)alert;
@end