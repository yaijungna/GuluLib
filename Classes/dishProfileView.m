//
//  dishProfileView.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/17.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "dishProfileView.h"


@implementation dishProfileView

@synthesize imageView,titleLabel,addressLabel,phoneLabel,follwersLabel,reviewsLabel,follwersNumberLabel,reviewsNumberLabel,guluapproveImageView;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) 
	{
		self.backgroundColor=[UIColor clearColor];
		
		imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5,100 , 100)];
		[self addSubview:imageView];
		[imageView release];
		[imageView setBackgroundColor:[UIColor lightGrayColor]];
		
		titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(120, 0 ,200 , 60)];
		[self addSubview:titleLabel];
		[titleLabel release];
		titleLabel.numberOfLines=3;
		
		/*
		addressLabel=[[UILabel alloc] initWithFrame:CGRectMake(120,20 ,200 , 40)];
		[self addSubview:addressLabel];
		[addressLabel release];
		addressLabel.numberOfLines=2;
		
		
		phoneLabel=[[UILabel alloc] initWithFrame:CGRectMake(120,60 ,200 , 20)];
		[self addSubview:phoneLabel];
		[phoneLabel release];
		*/
		
		follwersLabel=[[UILabel alloc] initWithFrame:CGRectMake(120,60 ,90 , 20)];
		[self addSubview:follwersLabel];
		[follwersLabel release];
		
		reviewsLabel=[[UILabel alloc] initWithFrame:CGRectMake(120,80 ,90 , 20)];
		[self addSubview:reviewsLabel];
		[reviewsLabel release];
		
		
		follwersNumberLabel=[[UILabel alloc] initWithFrame:CGRectMake(210,60 ,20 , 20)];
		[self addSubview:follwersNumberLabel];
		[follwersNumberLabel release];
		
		reviewsNumberLabel=[[UILabel alloc] initWithFrame:CGRectMake(210,80 ,20 , 20)];
		[self addSubview:reviewsNumberLabel];
		[reviewsNumberLabel release];
		
		guluapproveImageView=[[UIImageView alloc] initWithFrame:CGRectMake(245, 65,70 , 30)];
		[self addSubview:guluapproveImageView];
		[guluapproveImageView release];
		[guluapproveImageView setImage:[UIImage imageNamed:@"gulu-approved-1.png"]];
        
        guluapproveImageView.hidden=YES;
		
		follwersLabel.text = RESTAURANT_FOLLWERS_STRING;
		reviewsLabel.text =RESTAURANT_REVIEWS_STRING;
		
    }
    return self;
}

- (void)dealloc {
	[imageView release];
    [super dealloc];
}



@end
