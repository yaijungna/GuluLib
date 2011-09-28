//
//  GuluEventModel.m
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluEventModel.h"

@implementation GuluEventModel

@synthesize inviter;
@synthesize title;
@synthesize restaurant;
@synthesize start_time;
@synthesize status;
@synthesize guest_list;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [inviter release];
    [title release];
    [restaurant release];
    [guest_list release];
    
    [super dealloc];
}

-(NSString *) contactListString
{
    NSString *contact_list;

    for(int i=0;i<[guest_list count];i++)
	{
        GuluGuestModel *guest=[guest_list objectAtIndex:0];
        
		if(i==0)
		{
			contact_list=guest.ID;
		}
		else
		{
			contact_list=[NSString stringWithFormat:@"%@|%@",contact_list,guest.ID];
		}
	}
    
    return contact_list;
}

@end
