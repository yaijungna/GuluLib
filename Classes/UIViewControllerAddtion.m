//
//  UIViewControllerAddtion.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "UIViewControllerAddtion.h"
#import <QuartzCore/QuartzCore.h>
#import "GULUAPPAppDelegate.h"

#import "TSAlertView.h"

@implementation UIViewController(MyAdditions)

-(void)shareGULUAPP
{
	appDelegate = (GULUAPPAppDelegate *) [[UIApplication sharedApplication] delegate];
}

-(void)showDebugErrorString :(NSData *) data
{

	ACLog(@"%@",[[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease]);
	
}

-(void)showSpinnerView :(loadingSpinnerAndMessageView *) spinview mesage:(NSString *)str
{
 
        @try {
            CGSize frameSize=[spinview setMessageAndAdjustFrameSizeToFitMessage:str frameSize:CGSizeMake(self.view.frame.size.width,200)];
            spinview.frame=CGRectMake(self.view.center.x-frameSize.width/2, self.view.center.y-frameSize.height/2, frameSize.width, frameSize.height);
            spinview.hidden=NO;
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        @finally {
            
        }   
        
}

-(void)hideSpinnerView :(loadingSpinnerAndMessageView *) spinview
{
	if(spinview!=nil)
	{
		spinview.hidden=YES;
	}
}



-(void) showErrorAlert:(NSString *)errorString
{	

	/*
    ACAlertView *ErrorAlert = [[[ACAlertView alloc] init] autorelease];
	[ErrorAlert show];
	[ErrorAlert setStringAndSizeToFit:GLOBAL_ERROR_STRING
	 // text:[NSString stringWithFormat:@"Error [%@]",errorString ] 
								 text:[NSString stringWithFormat:@"%@",errorString ] 
							firstFont:[UIFont fontWithName:FONT_BOLD size:18] 
						   secondFont:[UIFont fontWithName:FONT_NORMAL size:14] 
							 firstBtn:GLOBAL_OK_STRING
							secondBtn:nil];
	
	[ErrorAlert setBackgroundImage:nil]; 
	[ErrorAlert setButtonImage:nil highlight:nil];	
   
 */   
    TSAlertView* av = [[[TSAlertView alloc] init] autorelease];
	av.title =GLOBAL_ERROR_STRING;
	av.message = errorString;
 //   av.delegate=self;
    [av addButtonWithTitle: GLOBAL_OK_STRING];
	[av show];
    

}

-(void)showWarningAlert:(NSString *)errorString
{
 /*   
    ACAlertView *ErrorAlert = [[[ACAlertView alloc] init] autorelease];
	[ErrorAlert show];
	[ErrorAlert setStringAndSizeToFit:GLOBAL_WARNING_STRING
	 // text:[NSString stringWithFormat:@"Error [%@]",errorString ] 
								 text:[NSString stringWithFormat:@"%@",errorString ] 
							firstFont:[UIFont fontWithName:FONT_BOLD size:18] 
						   secondFont:[UIFont fontWithName:FONT_NORMAL size:14] 
							 firstBtn:GLOBAL_OK_STRING
							secondBtn:nil];
	
	[ErrorAlert setBackgroundImage:nil]; 
	[ErrorAlert setButtonImage:nil highlight:nil];	
  */
    
    TSAlertView* av = [[[TSAlertView alloc] init] autorelease];
	av.title =GLOBAL_WARNING_STRING;
	av.message = errorString;
    //   av.delegate=self;
    [av addButtonWithTitle: GLOBAL_OK_STRING];
	[av show];


}

-(void)showOKAlert:(NSString *)okString
{
/*	ACAlertView *OKAlert = [[[ACAlertView alloc] init] autorelease];
    
    
	[OKAlert show];
	[OKAlert setStringAndSizeToFit:GLOBAL_OK_STRING
								 text:[NSString stringWithFormat:@"%@",okString ] 
							firstFont:[UIFont fontWithName:FONT_BOLD size:18] 
						   secondFont:[UIFont fontWithName:FONT_NORMAL size:14] 
							 firstBtn:GLOBAL_OK_STRING
							secondBtn:nil];
	
	[OKAlert setBackgroundImage:nil]; 
	[OKAlert setButtonImage:nil highlight:nil];   
 */   
    
    TSAlertView* av = [[[TSAlertView alloc] init] autorelease];
	av.title =GLOBAL_OK_STRING;
	av.message = okString;
    //   av.delegate=self;
    [av addButtonWithTitle: GLOBAL_OK_STRING];
	[av show];
	
}

#pragma mark -

- (void)iamhungry 
{
    
    if(![ACCheckConnection isConnectedToNetwork])
    {
        NSString *errorString =CONNECTION_ERROR_STRING;
        [self showErrorAlert:errorString];
        return;
    }

    
    [self shareGULUAPP];
    if(appDelegate.hungry.hungryStatus==NO)
    {
        [appDelegate.hungry start_hungry];
        
        //   NSLog(@"start_hungry");
        
    }
    else
    {
        [appDelegate.hungry stop_hungry];
    }
}

#pragma mark -

-(UILabel*)customizeLabel:(UILabel *) textlabel
{
	textlabel.backgroundColor=[UIColor clearColor];
	textlabel.font=[UIFont fontWithName:FONT_NORMAL size:14];
	textlabel.textColor=TEXT_COLOR;
	[textlabel setTextAlignment:UITextAlignmentLeft];

	return textlabel;
}

-(UILabel*)customizeLabel_title:(UILabel *) textlabel
{
	textlabel.backgroundColor=[UIColor clearColor];
	textlabel.font=[UIFont fontWithName:FONT_BOLD size:14];
	textlabel.textColor=TEXT_COLOR;
	[textlabel setTextAlignment:UITextAlignmentLeft];
	
	return textlabel;
}


-(UITextField *)customizeTextField :(UITextField *) textfield
{
	textfield.background=[UIImage imageNamed:@"text-box.png"];
	textfield.borderStyle= UITextBorderStyleBezel;
	textfield.font=[UIFont fontWithName:FONT_NORMAL size:12];
	textfield.textColor=TEXT_COLOR;
	textfield.layer.borderWidth = 1.0f;
	textfield.layer.borderColor=[[UIColor lightGrayColor] CGColor];
	[textfield setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter]	;
	
	textfield.autocapitalizationType= UITextAutocapitalizationTypeNone;
	textfield.autocorrectionType=UITextAutocorrectionTypeDefault;
	
	return textfield;
}

-(UITextView *)customizeTextView :(UITextView *) textview
{
	textview.font=[UIFont fontWithName:FONT_NORMAL size:14];
	textview.textColor=TEXT_COLOR;	
	textview.layer.borderWidth = 1.0f;
	textview.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	
	return textview;
}

-(UITableView *)customizeTableView :(UITableView *) tableview
{	
//	UIImageView *imageview=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]] autorelease];
	
	[tableview setBackgroundColor:[UIColor clearColor]];
	[tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//	[tableview setBackgroundView:imageview];
	
	return tableview;
}



-(UIImageView *)customizeImageView	:(UIImageView *) imageView
{
	CGRect frame=imageView.frame;
	
	UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x-8, frame.origin.y-8, frame.size.width+16, frame.size.height+16)];
	[[imageView superview] insertSubview:bgImageView belowSubview:imageView];
	[bgImageView release];
	[bgImageView setImage:[UIImage imageNamed:@"big_photo_frame.png"]];
	return imageView;
}

-(UIImageView *)customizeImageView_cell	:(UIImageView *) imageView
{
	CGRect frame=imageView.frame;
	
	UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x-3, frame.origin.y-3, frame.size.width+6, frame.size.height+6)];
	[[imageView superview] insertSubview:bgImageView belowSubview:imageView];
	[bgImageView release];
	[bgImageView setImage:[UIImage imageNamed:@"big_photo_frame.png"]];
	return imageView;
}

-(void)moveTheView:(id)theView movwToPosition :(CGPoint)position
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	CGRect Frame=CGRectMake(position.x, position.y , ((UIView *)theView).frame.size.width ,((UIView *)theView).frame.size.height );
	((UIView *)theView).frame=Frame;
	[theView layoutSubviews];
	[UIView commitAnimations];
}

-(float)calculateDistanceFromUserToPlace :(CLLocation*)to
{	
	[self shareGULUAPP];
	float d =[ACUtility calculateDistance:appDelegate.userMe.myLocation destination:to];
	return d;
}

- (void)cancelImageLoaders:(NSMutableDictionary *)dict
{
	NSArray *array=[dict allValues];
	
	for( ACImageLoader *loader in array )
		[loader cancelDownload];
}

@end

