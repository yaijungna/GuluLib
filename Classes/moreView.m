//
//  moreView.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/15.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "moreView.h"


@implementation moreView
@synthesize mapbtn,invitebtn,todobtn,favoritebtn,missionbtn;
@synthesize delegate;
@synthesize indexPath;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) 
	{
		UIImageView *imgview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		imgview.image=[UIImage imageNamed:@"more-list-box-1.png"];
		[self addSubview:imgview];
		[imgview release];

		
		self.mapbtn=[ACCreateButtonClass createButton:ButtonTypeMap];
		[self addSubview:mapbtn];
		[mapbtn setFrame:CGRectMake(0, 0, mapbtn.frame.size.width, mapbtn.frame.size.height)];
		
		self.invitebtn=[ACCreateButtonClass createButton:ButtonTypeInvite];
		[self addSubview:invitebtn];
		[invitebtn setFrame:CGRectMake(80, 0, invitebtn.frame.size.width, invitebtn.frame.size.height)];
		
		self.todobtn=[ACCreateButtonClass createButton:ButtonTypeAddTodo];
		[self addSubview:todobtn];
		[todobtn setFrame:CGRectMake(80*2, 0, todobtn.frame.size.width, todobtn.frame.size.height)];
		
		self.favoritebtn=[ACCreateButtonClass createButton:ButtonTypeAddFavorite];
		[self addSubview:favoritebtn];
		[favoritebtn setFrame:CGRectMake(80*3, 0, favoritebtn.frame.size.width, favoritebtn.frame.size.height)];
        
        
        [mapbtn.btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [favoritebtn.btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [todobtn.btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [invitebtn.btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

		
		
    }
    return self;
}

- (void)buttonAction :(UIButton *)btn
{
    if(btn==mapbtn.btn)
    {
        [delegate moreAction:self actionType:GULU_MORE_MAP];
    }
    else if(btn==invitebtn.btn)
    {
        [delegate moreAction:self actionType:GULU_MORE_INVITE];
    }
    else if(btn==todobtn.btn)
    {
        [delegate moreAction:self actionType:GULU_MORE_TODO];
    }
    else if(btn==favoritebtn.btn)
    {
        [delegate moreAction:self actionType:GULU_MORE_FAVORITE];
    }	
}

- (void)dealloc {
	[mapbtn release];
	[invitebtn release];
	[todobtn release];
	[favoritebtn release];
	[missionbtn release];
	
    [indexPath release];
	
    [super dealloc];
}


@end
