//
//  ACAlertView.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//




//
//  customDialog.m
//  guluapp
//
//  Created by chen alan on 2011/2/16.
//  Copyright 2011 Gulu.com. All rights reserved.
//

/*
 
 --------------------
 |		padding		|50
 --------------------
 |					|
 |		title		|
 |					|
 --------------------10
 |					|
 |		text		|
 |					|
 --------------------10
 |					|
 |	button	button  |
 |					|
 --------------------
 |		padding		|70
 --------------------
 
 How to use :
 
 ACAlertView *theAlert = [[[ACAlertView alloc] init] autorelease];
 theAlert.ACDelegate=self;
 [theAlert show];
 [theAlert setStringAndSizeToFit:@"" text:@"" firstFont:[UIFont fontWithName:@"AmericanTypewriter" size:14] secondFont:[UIFont fontWithName:@"AmericanTypewriter" size:14] firstBtn:@"" secondBtn:nil];
 [theAlert setBackgroundImage:nil]; 
 [theAlert setButtonImage:nil highlight:nil];
 
 
 or
 
 ACAlertView *theAlert = [[[ACAlertView alloc] init] autorelease];
 theAlert.ACDelegate=self;
 [theAlert show];
 [theAlert setframeToDefinedSize:alertBigSzie];
 [theAlert setBackgroundImage:nil];
 
 
 "customize your alert"
 
 */

#import "ACAlertView.h"

static  BOOL showAlertFlag;

@implementation ACAlertView

@synthesize ACDelegate;
@synthesize firstBtn;
@synthesize secondBtn;
@synthesize titleLabel;
@synthesize textLabel;

#pragma mark -
#pragma mark  Function Methods

- (void)dealloc {
	[firstBtn release];
	[secondBtn release];
	[titleLabel release];
	[textLabel release];
	
    [super dealloc];
}

- (id)init {
	if (self = [super init]) 
	{
		self.titleLabel=[[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
		self.textLabel=[[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
		
		[titleLabel setTextAlignment:UITextAlignmentCenter];
		[textLabel setTextAlignment:UITextAlignmentCenter];
		
		titleLabel.lineBreakMode=UILineBreakModeWordWrap;
		textLabel.lineBreakMode=UILineBreakModeWordWrap;
		
		titleLabel.numberOfLines=0;
		textLabel.numberOfLines=0;
		
		titleLabel.backgroundColor=[UIColor clearColor];
		textLabel.backgroundColor=[UIColor clearColor];
		
		[self addSubview:titleLabel];
		[self addSubview:textLabel];
		
		//[titleLabel release];
		//[textLabel release];
		
		self.firstBtn=[[[UIButton alloc] initWithFrame:CGRectZero] autorelease];
		self.secondBtn=[[[UIButton alloc] initWithFrame:CGRectZero] autorelease];
		
		[firstBtn.titleLabel setTextColor:TEXT_COLOR];
		[secondBtn.titleLabel setTextColor:TEXT_COLOR];
		
		[firstBtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
		[secondBtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
		
		[firstBtn addTarget:self action:@selector(firstBtnAction) forControlEvents:UIControlEventTouchUpInside];	
		[secondBtn addTarget:self action:@selector(secondBtnAction) forControlEvents:UIControlEventTouchUpInside];	
		
		[self addSubview:firstBtn];
		[self addSubview:secondBtn];
		
	//	[firstBtn release];
	//	[secondBtn release];
		
	}
	return self;
}


#pragma mark -
#pragma mark action Function Methods

-(void)setFlagToNO
{
  showAlertFlag=NO;
}

- (void) firstBtnAction {
	[ACDelegate ACAlertViewDelegateFirstBtnAction:self];
	[self dismissWithClickedButtonIndex:0 animated:YES];
    [self performSelector:@selector(setFlagToNO) withObject:nil afterDelay:0.8];
   
}

- (void) secondBtnAction {
	[ACDelegate ACAlertViewDelegateSecondBtnAction:self];
	[self dismissWithClickedButtonIndex:0 animated:YES];
    [self performSelector:@selector(setFlagToNO) withObject:nil afterDelay:0.8];
}


#pragma mark -
#pragma mark basic Function Methods

-(void) setStringAndSizeToFit :(NSString *)titleStr 
						  text:(NSString *)textStr 
					  firstFont:(UIFont *)font1 
					 secondFont:(UIFont *)font2 
					  firstBtn:(NSString *)btnStr1 
					 secondBtn:(NSString *)btnStr2 
{	
	float labelWidth=ALERT_WIDTH-ALERT_LEFT_PADDING-ALERT_RIGHT_PADDING;
	
	CGSize maxSize1 = CGSizeMake(labelWidth, ALERT_TITLE_MAX_HEIGHT);
	CGSize maxSize2 = CGSizeMake(labelWidth, ALERT_TEXT_MAX_HEIGHT);
	
	CGSize TextSize1 = [titleStr sizeWithFont:font1 
							constrainedToSize:maxSize1 
								lineBreakMode:UILineBreakModeWordWrap];
	CGSize TextSize2 = [textStr sizeWithFont:font2 
							 constrainedToSize:maxSize2 
								 lineBreakMode:UILineBreakModeWordWrap];
	
	
	if(TextSize1.height<ALERT_TITLE_MIN_HEIGHT)
		TextSize1.height=ALERT_TITLE_MIN_HEIGHT;
	if(TextSize2.height<ALERT_TEXT_MIN_HEIGHT)
		TextSize2.height=ALERT_TEXT_MIN_HEIGHT;
	
	titleLabel.font=font1;
	textLabel.font=font2;

	
	titleLabel.frame = CGRectMake(ALERT_LEFT_PADDING,
								  ALERT_UP_PADDING, labelWidth, TextSize1.height);
	
	textLabel.frame = CGRectMake(titleLabel.frame.origin.x,
								 titleLabel.frame.origin.y+titleLabel.frame.size.height+ALERT_BETWEEN_PADDING, 
								 labelWidth, 
								 TextSize2.height);
	
	
	titleLabel.text=titleStr;
	textLabel.text=textStr;
	
	//===================button======================
	
	[firstBtn  setTitle:btnStr1 forState:UIControlStateNormal];
	[secondBtn  setTitle:btnStr2 forState:UIControlStateNormal];
	
	NSInteger numberOfBtn=0;
	if(btnStr1){
		numberOfBtn++;}
	if(btnStr2){
		numberOfBtn++;}
	
	if(numberOfBtn == 0)
	{
		
	}
	else if(numberOfBtn == 1)
	{
		firstBtn.frame = CGRectMake(ALERT_WIDTH/2-ALERT_BUTTON_WIDTH*0.5,
								   textLabel.frame.origin.y+textLabel.frame.size.height+ALERT_BETWEEN_PADDING, 
									ALERT_BUTTON_WIDTH, 
									ALERT_BUTTON_HEIGHT);
		
		secondBtn.hidden=YES;
	}
	else if(numberOfBtn == 2)
	{
		firstBtn.frame = CGRectMake(ALERT_WIDTH/2-ALERT_BUTTON_WIDTH-10,
								   textLabel.frame.origin.y+textLabel.frame.size.height+ALERT_BETWEEN_PADDING, 
									ALERT_BUTTON_WIDTH, 
									ALERT_BUTTON_HEIGHT);
		
		secondBtn.frame = CGRectMake(ALERT_WIDTH/2+10,
									textLabel.frame.origin.y+textLabel.frame.size.height+ALERT_BETWEEN_PADDING, 
									 ALERT_BUTTON_WIDTH, 
									 ALERT_BUTTON_HEIGHT);
		
	}
	
	
	//===========================================================
	
	self.bounds = CGRectMake(0,0,ALERT_WIDTH ,firstBtn.frame.origin.y + firstBtn.frame.size.height+ALERT_DOWN_PADDING );

	
//	NSLog(@"%@",self);
	
	
}

-(void)setBackgroundImage :(UIImage *)theImage
{
	if(theImage==nil)
		theImage = [UIImage imageNamed:@"pop-up-1.png"]; 
	
	id img=[self.subviews objectAtIndex:0];
		
	//img.bounds =  [self bounds];
	//[img setImage:theImage];
	
	CGSize theSize = [self bounds].size;
	
	UIGraphicsBeginImageContext(theSize);    
	theImage = [theImage stretchableImageWithLeftCapWidth:0 topCapHeight:0];
	[theImage drawInRect:CGRectMake(0, 0, theSize.width, theSize.height)];    
	theImage = UIGraphicsGetImageFromCurrentImageContext();    
	UIGraphicsEndImageContext();
	
	
//	NSLog(@"%@",[self subviews]);
	
	if([img isKindOfClass:[UIImageView class]])
	{
		((UIImageView *)img).bounds =  [self bounds];
		[img setImage:theImage];
        NSLog(@"imageView %@",[self subviews]);
        
	}
	else
	{
		self.backgroundColor=[UIColor clearColor];
		self.layer.contents = (id)[theImage CGImage];
        NSLog(@"!imageView %@",[self subviews]);
	}

	
/*	if([img isKindOfClass:[UIImageView class]])
	{
		((UIImageView *)img).image=theImage;
		self.backgroundColor=[UIColor clearColor];
		((UIImageView *)img).layer.contents = (id)[theImage CGImage];
	}
	else 
	{
		//img.image=theImage;
		self.backgroundColor=[UIColor clearColor];
		self.layer.contents = (id)[theImage CGImage];
	}
 
 */
}

-(void)setButtonImage :(UIImage *)theImage  highlight:(UIImage *)highLightImage
{
	if(!theImage)
		theImage=[UIImage imageNamed:@"button-1.png"];
//	if(!highLightImage)
//		highLightImage=[UIImage imageNamed:@"button-1.png"];
	
	[firstBtn setBackgroundImage:theImage forState:UIControlStateNormal];
	[firstBtn setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
	
	[secondBtn setBackgroundImage:theImage forState:UIControlStateNormal];
	[secondBtn setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
	
	
}

-(void) setframeToDefinedSize :(ACAlertViewSizeType )type
{	
	switch (type)
	{
		case alertSmallSzie:
			//self.frame = CGRectMake(0, 0, 300, 200);
			self.bounds = CGRectMake(0, 0, 300, 200);
			break;
		case alertMidiumSzie:
			//self.frame = CGRectMake(0, 0, 300, 300);
			self.bounds = CGRectMake(0, 0, 300, 300);
			break;
		case alertBigSzie:
			//self.frame = CGRectMake(0, 0, 300, 400);
			self.bounds = CGRectMake(0, 0, 300, 400);	
			break;
			
		default:
			
			break;
	}
}

-(void)showAction
{
    [super show];
    showAlertFlag=YES;
}

-(void)show
{
	/*for (UIWindow* window in [UIApplication sharedApplication].windows)
    {
		NSArray* subviews = window.subviews;
		if ([subviews count] > 0)
        {
            for(id view1 in subviews )
            {
                if ([view1 isKindOfClass:[UIAlertView class]])
                {
                    [view1 dismissWithClickedButtonIndex:0 animated:NO];
                    //[(UIAlertView *)[subviews objectAtIndex:0] dismissWithClickedButtonIndex:[(UIAlertView *)[subviews objectAtIndex:0] cancelButtonIndex] animated:NO];
                    
                }
            }
        }
	}
    
    */
    
    if(showAlertFlag==YES)
    {
        //[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(showAction) userInfo:nil repeats:NO];
     //   showAlertFlag=NO;
        return;
    }
    else if(showAlertFlag==NO)
    {
 
        showAlertFlag=YES;
        [super show];
        
     /*   id img=[self.subviews objectAtIndex:0];
        
        if(![img isKindOfClass:[UIImageView class]])
        {
            [self dismissWithClickedButtonIndex:0 animated:YES];
        }
      */
    }
}



@end
