//
//  GuluNotificationModel.m
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluNotificationModel.h"

@implementation GuluNotificationModel

@synthesize object;
@synthesize object_type;
@synthesize from_user;
@synthesize message;
@synthesize unseen;
@synthesize notify_type;
@synthesize created;
@synthesize title;
@synthesize status;

@synthesize objectModel;

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
    [object release];
    [from_user release];
    [message release];
    [title release];
    
    [objectModel release];
    
    [super dealloc];
}

-(void)switchDataIntoModel:(NSDictionary *)dataDictionary
{
    [super switchDataIntoModel:dataDictionary];
    
    id model=[GuluModel getObjectByObjectType:object_type data:object];
    
    self.objectModel=model;
   

}

- (NSString *)handleNotificatioMessageString 
{
    NSString *username=from_user.username;
    NSString *returnString=nil;
    
    switch (notify_type) {
            
        case GULU_NOTIFY_INVITE:
            returnString=[NSString stringWithFormat:@"%@ %@%@",username ,NSLocalizedString(@"invited you to the Event:", @"[notify]"),title]; 
            break;
            
        case GULU_NOTIFY_SUGGEST:
            
            returnString=[NSString stringWithFormat:@"%@ %@ %@ %@",username ,NSLocalizedString(@"recommends", @"[notify]"),title,
                          NSLocalizedString(@"to you.", @"[notify] suggest to you")];
            break;
            
        case GULU_NOTIFY_FRIEND:
            
            returnString= [NSString stringWithFormat:@"%@ %@",username ,NSLocalizedString(@"wants to be your friend.",@"")]; 
            break;
            
        case GULU_NOTIFY_MISSION_RECRUIT:
            
            returnString=[NSString stringWithFormat:@"%@ %@ %@ ",username ,NSLocalizedString(@"wants you to join", @"[notify]"),title]; 
            break;
            
        case GULU_NOTIFY_MISSION_CHALLENGER:
            
            returnString=[NSString stringWithFormat:@"%@ %@ %@",username ,NSLocalizedString(@"is challenging you Dare Mission:%@", @"[notify]"),title]; 
            
            break;
            
        case GULU_NOTIFY_MISSION_SPECTATOR:
            
            returnString=[NSString stringWithFormat:@"%@ %@ %@",username ,NSLocalizedString(@"added you as a spectator to the Mission", @"[notify]"),title]; 
            break;
            
        case GULU_NOTIFY_LIKES:
            
            returnString=[NSString stringWithFormat:@"%@ %@ %@",username ,NSLocalizedString(@"likes", @"[notify]"),title]; 
            break;
            
        case GULU_NOTIFY_COMMENTED:
            
            returnString=[NSString stringWithFormat:@"%@ %@ %@",username ,NSLocalizedString(@"commented on", @"[notify]"),title]; 
            break;
            
        case GULU_NOTIFY_FOLLOWS:
            
            returnString=[NSString stringWithFormat:@"%@ %@",username ,NSLocalizedString(@"is now following you.", @"[notify]")]; 
            break;
            
        case GULU_NOTIFY_FRIEND_ACCEPT:
            
            returnString=[NSString stringWithFormat:@"%@ %@",username ,NSLocalizedString(@"accepted your Friend Request.", @"[notify]")]; 
            break;
            
        case GULU_NOTIFY_TAG_IN_POST:
            
            returnString=[NSString stringWithFormat:@"%@ %@",username ,NSLocalizedString(@"tagged you in a gulu post.", @"[notify]")]; 
            break;
        
        case GULU_NOTIFY_TAG_IN_POST_EVENT:
            
            returnString=[NSString stringWithFormat:@"%@ %@",username ,NSLocalizedString(@"tagged an event that you joined in a gulu post.", @"[notify]")]; 
            break;
            
        default:
            returnString=@"";
            break;
    }
            
    
    return returnString;
    
    
}



@end
