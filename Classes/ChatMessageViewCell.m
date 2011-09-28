//
//  ChatMessageViewCell.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "ChatMessageViewCell.h"
#import	"ACUtility.h"

@implementation ChatMessageViewCell

@synthesize nameLabel;
@synthesize messageLabel;
@synthesize cornorImageView;
@synthesize bgImageView;
@synthesize ImageView;
@synthesize WebView;

- (void)setHighlighted: (BOOL)highlighted animated: (BOOL)animated
{
	
}

- (void)setSelected: (BOOL)selected animated: (BOOL)animated 
{
	
}

-(void)initCell
{
	
	cornorImageView =[[UIImageView alloc] initWithFrame:CGRectZero];
	[self addSubview:cornorImageView];
	
	bgImageView =[[UIImageView alloc] initWithFrame:CGRectZero];
	[self addSubview:bgImageView];
	bgImageView.layer.cornerRadius=7.0;

    nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 200, 12)];
    [bgImageView addSubview:nameLabel]; 
    nameLabel.backgroundColor=[UIColor clearColor];
    [nameLabel setFont:chat_text_font_bold];
	nameLabel.numberOfLines=0;
	nameLabel.lineBreakMode=UILineBreakModeWordWrap;
	[nameLabel setTextAlignment:UITextAlignmentLeft];
    
	messageLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
	[bgImageView addSubview:messageLabel];
	messageLabel.backgroundColor=[UIColor clearColor];
	[messageLabel setFont:chat_text_font];
	messageLabel.numberOfLines=0;
	messageLabel.lineBreakMode=UILineBreakModeWordWrap;
	[messageLabel setTextAlignment:UITextAlignmentLeft];
    
    ImageView=[[UIImageView alloc] init];
    [bgImageView addSubview:ImageView];
    ImageView.hidden=YES;
    
    WebView=[[UIWebView alloc] init];
    [bgImageView addSubview:WebView];
    WebView.hidden=YES;
    WebView.scalesPageToFit = YES;
    [WebView sizeThatFits:CGSizeMake(200, 200)];
  
}

-(void)sizeToFitMessage 
{
	CGSize maxSize = CGSizeMake(200, 2000);
	
	CGSize TextSize = [messageLabel.text  sizeWithFont:chat_text_font
							  constrainedToSize:maxSize 
								  lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize NameTextSize = [nameLabel.text  sizeWithFont:chat_text_font_bold
                                     constrainedToSize:maxSize 
                                         lineBreakMode:UILineBreakModeWordWrap];
    
    

	if(TextSize.height<30)
		TextSize.height=30;
    
    if(TextSize.width<NameTextSize.width)
        TextSize.width=NameTextSize.width;

    if(WebView.hidden==NO)
    {
        [self sizeToFitWebView];
    }
    
    nameLabel.frame=CGRectMake(nameLabel.frame.origin.x,nameLabel.frame.origin.y, NameTextSize.width, nameLabel.frame.size.height);
	messageLabel.frame=CGRectMake(nameLabel.frame.origin.x, 5+12+3, TextSize.width, TextSize.height);	
    
}

-(void)sizeToFitWebView
{
    CGSize Size=[ChatMessageViewCell sizeOfImageFromURL:messageLabel.text];
    WebView.frame=CGRectMake(nameLabel.frame.origin.x, 5+12+3,Size.width/2 , Size.height/2);
}

-(void)messageMine
{	
	[self sizeToFitMessage];
	
	cornorImageView.image=[UIImage imageNamed:@"chat-corner-1_1.png"];
	[cornorImageView setFrame:CGRectMake(320-10-20-8, 10, 25, 20)];
	
	bgImageView.backgroundColor=chat_bubble_clor_mine;
	CGSize bgSize=CGSizeMake(messageLabel.frame.size.width+10 ,messageLabel.frame.size.height+10+12+3 );
	
	[bgImageView setFrame:CGRectMake(320-10-cornorImageView.frame.size.width-bgSize.width,
									 0,
									 bgSize.width, 
									 bgSize.height)];
    
    if(WebView.hidden==NO)
    {
        if(WebView.frame.size.width < nameLabel.frame.size.width)
         {
             [bgImageView setFrame:CGRectMake(320-10-cornorImageView.frame.size.width-( WebView.frame.size.width+10),
                                              0,
                                              nameLabel.frame.size.width+10, 
                                              WebView.frame.size.height+10+12+3)];
         }
         else
         {
             [bgImageView setFrame:CGRectMake(320-10-cornorImageView.frame.size.width-( WebView.frame.size.width+10),
                                              0,
                                              WebView.frame.size.width+10, 
                                              WebView.frame.size.height+10+12+3)];
         }

    }
    
}	

-(void)messageOthers
{
	[self sizeToFitMessage];
	
	cornorImageView.image=[UIImage imageNamed:@"chat-corner-2_1.png"];
	[cornorImageView setFrame:CGRectMake(10+1, 10, 25, 20)];
	
	bgImageView.backgroundColor=chat_bubble_clor_others;
	CGSize bgSize=CGSizeMake(messageLabel.frame.size.width+10 ,messageLabel.frame.size.height+10+12+3 );
	
	[bgImageView setFrame:CGRectMake(cornorImageView.frame.origin.x+cornorImageView.frame.size.width-3,
									 0,
									 bgSize.width, 
									 bgSize.height)];
    
    if(WebView.hidden==NO)
    {
        if(WebView.frame.size.width < nameLabel.frame.size.width)
        {
            [bgImageView setFrame:CGRectMake(cornorImageView.frame.origin.x+cornorImageView.frame.size.width-3,
                                             0,
                                             nameLabel.frame.size.width+10, 
                                             WebView.frame.size.height+10+12+3)];
        }
        else
        {
            [bgImageView setFrame:CGRectMake(cornorImageView.frame.origin.x+cornorImageView.frame.size.width-3,
                                             0,
                                             WebView.frame.size.width+10, 
                                             WebView.frame.size.height+10+12+3)];
        }
    }
    
    
}

- (void)dealloc {
	[nameLabel release];
	[messageLabel release];
	[bgImageView release];
	[cornorImageView release];
    [ImageView release];
    [WebView release];
	
    [super dealloc];
}


+(CGSize)sizeOfImageFromURL:(NSString *)link
{
    CGSize Size=CGSizeZero;
    NSArray *lines = [link componentsSeparatedByString:@"?"];
    
    if([lines count]<2)
    {
        return Size;
    }
    
    NSString *whString=[lines objectAtIndex:1];
    NSArray *lineElements = [whString componentsSeparatedByString:@"&"];
    
    if([lineElements count]!=2)
    {
        return Size;
    }
    
    NSString *Str0=[lineElements objectAtIndex:0];
    NSString *Str1=[lineElements objectAtIndex:1];
    
    NSString *Width=nil;
    NSString *Height=nil;    

    
    if([Str0 rangeOfString:@"w=" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
       Width=[Str0 stringByReplacingOccurrencesOfString:@"w=" withString:@""];
    }
    if([Str0 rangeOfString:@"h=" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        Height=[Str0 stringByReplacingOccurrencesOfString:@"h=" withString:@""];
    }
    if([Str1 rangeOfString:@"w=" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        Width=[Str1 stringByReplacingOccurrencesOfString:@"w=" withString:@""];
    }
    if([Str1 rangeOfString:@"h=" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        Height=[Str1 stringByReplacingOccurrencesOfString:@"h=" withString:@""];
    }
    
    if(Width==nil || Height==nil)
    {
        return Size;
    }
    
    /*
    NSLog(@"----");
    NSLog(@"%@",link);
    NSLog(@"%@,%@",Str0,Str1);
    NSLog(@"%@",Width);
    NSLog(@"%@",Height);
    NSLog(@"----");
     */
    
    float ratio=[Height floatValue]/[Width floatValue];
    
    if([Width floatValue]>200)
    {
        Width=@"200";
        float float_h=ratio*200;
        Height=[NSString stringWithFormat:@"%f",float_h];
    }
    
    CGSize SIZE=CGSizeMake([Width floatValue], [Height floatValue]);
        
    return SIZE;

}


+(BOOL)isImageLink:(NSString *)link
{
   BOOL match=NO;
    
    if(([link rangeOfString:@"http://" options:NSCaseInsensitiveSearch].location != NSNotFound)  &&
       (([link rangeOfString:@".jpg" options:NSCaseInsensitiveSearch].location != NSNotFound) ||
        ([link rangeOfString:@".png" options:NSCaseInsensitiveSearch].location != NSNotFound) ||
        ([link rangeOfString:@".gif" options:NSCaseInsensitiveSearch].location != NSNotFound) ||
        ([link rangeOfString:@".bmp" options:NSCaseInsensitiveSearch].location != NSNotFound) ))
    {
        match=YES;
    }

    
    return match;
}



@end
