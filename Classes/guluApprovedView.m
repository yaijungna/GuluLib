//
//  guluApprovedView.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/13.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "guluApprovedView.h"


@implementation guluApprovedView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) 
	{
		self.backgroundColor =[UIColor clearColor];
		
		
		messageLabel=[[UILabel alloc] initWithFrame:CGRectMake(frame.size.width*0.05, 0, frame.size.width*0.3, frame.size.height)];
		[messageLabel setBackgroundColor:[UIColor clearColor]];
		messageLabel.numberOfLines=2;
		messageLabel.textAlignment=UITextAlignmentCenter;
		[messageLabel setFont:[UIFont fontWithName:FONT_BOLD size:12]];
		messageLabel.textColor=TEXT_COLOR;
		messageLabel.text=NSLocalizedString(@"Thanks for the nomination!",@"user gives gulu aprove ");
		[self addSubview:messageLabel];
		[messageLabel release];
		
		guluapproveImageView=[[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width*0.4, 0, frame.size.width*0.4, frame.size.height)];
		guluapproveImageView.image=[UIImage imageNamed:@"gulu-approved-1.png"];
		[self addSubview:guluapproveImageView];
		[guluapproveImageView release];
	
		thumbImageView1=[[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width*0.85, frame.size.height/2-15, 30, 30)];
		thumbImageView1.image=[UIImage imageNamed:@"active-thumbs-up-1.png"];
		[self addSubview:thumbImageView1];
		[thumbImageView1 release];
		
		thumbImageView2=[[UIImageView alloc] initWithFrame:CGRectMake(thumbImageView1.frame.origin.x+7,thumbImageView1.frame.origin.y+7, 30, 30)];
		thumbImageView2.image=[UIImage imageNamed:@"active-thumbs-up-1.png"];
		[self addSubview: thumbImageView2];
		[thumbImageView2 release];
		
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}


@end
