//
//  ChatMessageViewCell.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#define chat_bubble_clor_others	[UIColor colorWithRed:0.847 green:0.785 blue:0.699 alpha:1]
#define chat_bubble_clor_mine [UIColor colorWithRed:0.789 green:0.652 blue:0.496 alpha:1]
#define chat_text_font			[UIFont fontWithName:FONT_NORMAL size:12]
#define chat_text_font_bold		[UIFont fontWithName:FONT_BOLD size:12]

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppSettings.h"

@interface ChatMessageViewCell : UITableViewCell {
	UIImageView *bgImageView;
	UIImageView *cornorImageView;
    UILabel *nameLabel;
	UILabel *messageLabel;
    UIImageView *ImageView;
    UIWebView *WebView;
}

@property(nonatomic,retain) UILabel *nameLabel;
@property(nonatomic,retain) UILabel *messageLabel;
@property(nonatomic,retain) UIImageView *cornorImageView;
@property(nonatomic,retain) UIImageView *bgImageView;
@property(nonatomic,retain) UIImageView *ImageView;
@property(nonatomic,retain) UIWebView *WebView;

-(void)initCell;
-(void)messageMine;
-(void)messageOthers;
-(void)sizeToFitMessage;
-(void)sizeToFitWebView;

+(CGSize)sizeOfImageFromURL:(NSString *)link;
+(BOOL)isImageLink:(NSString *)link;
 

@end
