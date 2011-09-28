//
//  GuluMissionModel.m
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluMissionModel.h"

@implementation GuluMissionModel

@synthesize title;
@synthesize created_user;
@synthesize description;
@synthesize start;
@synthesize deadline;
@synthesize type;
@synthesize badge_pic;
@synthesize allowed_mins;
@synthesize member_status;
@synthesize group_status;
@synthesize inviter;
@synthesize member_num;
@synthesize group_id;
@synthesize group_number;
@synthesize grade_number;

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
    [title release];
    [created_user release];
    [description release];
    [badge_pic release];
    [inviter release];
    [group_id release];

    [super dealloc];
}

-(NSString *) contactListString:(NSMutableArray *)contactsArray
{
    NSString *contact_list;
    
    for(int i=0;i<[contactsArray count];i++)
	{
        GuluGuestModel *contact=[contactsArray objectAtIndex:0];
        
		if(i==0)
		{
			contact_list=contact.ID;
		}
		else
		{
			contact_list=[NSString stringWithFormat:@"%@|%@",contact_list,contact.ID];
		}
	}
    
    return contact_list;
}




@end

