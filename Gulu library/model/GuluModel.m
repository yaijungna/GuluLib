//
//  GuluModel.m
//  GULUAPP
//
//  Created by alan on 11/9/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluModel.h"

#import "GuluPhotoModel.h"
#import "GuluPlaceModel.h"
#import "GuluDishModel.h"
#import "GuluReviewModel.h"
#import "GuluUserModel.h"
#import "GuluEventModel.h"
#import "GuluMissionModel.h"


@implementation GuluModel
@synthesize ID;

- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (void)dealloc
{
    [ID release];
    [super dealloc];

}

+(id)getObjectByObjectType :(GuluTargetType)object_type  
                            data:(NSDictionary *)dataDictionary
{
    id model=nil;
    
    switch (object_type) {
        case GuluTargetType_photo:
            model=[[[GuluPhotoModel alloc] init] autorelease];
            break;
        case GuluTargetType_review:
            model=[[[GuluReviewModel alloc] init] autorelease];
            break;
        case GuluTargetType_dish:
            model=[[[GuluDishModel alloc] init] autorelease];
            break;
        case GuluTargetType_place:
            model=[[[GuluPlaceModel alloc] init] autorelease];
            break;
        case GuluTargetType_mission:
            
            break;
        case GuluTargetType_user:
            model=[[[GuluUserModel alloc] init] autorelease];
            break;
            
        default:

            break;
    }
    [model switchDataIntoModel:dataDictionary];
    
    return  model;
}

+(id)getObjectByfavoriteType :(GuluFavoriteType)favorite_type  
                       data:(NSDictionary *)dataDictionary
{
    id model=nil;
    
    switch (favorite_type) {
        case GuluFavoriteType_dish:
            model=[[[GuluDishModel alloc] init] autorelease];
            break;
        case GuluFavoriteType_place:
            model=[[[GuluPlaceModel alloc] init] autorelease];
            break;
        case GuluFavoriteType_review:
            model=[[[GuluReviewModel alloc] init] autorelease];
            break;
        case GuluFavoriteType_user:
            model=[[[GuluUserModel alloc] init] autorelease];
            break;
        case GuluFavoriteType_mission:
            
            break;
            
        default:
            break;
    }
    [model switchDataIntoModel:dataDictionary];
    
    return  model;
}

+(id)getObjectByTodoType :(GuluToDoObjectType)todo_type  
                         data:(NSDictionary *)dataDictionary
{
    id model=nil;
    
    switch (todo_type) {
        case GuluToDoObjectType_dish:
            model=[[[GuluDishModel alloc] init] autorelease];
            break;
        case GuluToDoObjectType_place:
            model=[[[GuluPlaceModel alloc] init] autorelease];
            break;
            
        default:
            
            break;
    }
    [model switchDataIntoModel:dataDictionary];
    
    return  model;
}

+(id)getObjectByChatType :(GuluChatObjectType)chat_type  
                     data:(NSDictionary *)dataDictionary
{
    id model=nil;
    
    switch (chat_type) {
        case GULU_CHATOBJECTTYPE_EVENT:
                 model=[[[GuluEventModel alloc] init] autorelease];
            break;
        case GULU_CHATOBJECTTYPE_MISSION:
                model=[[[GuluMissionModel alloc] init] autorelease];
            break;
        case GULU_CHATOBJECTTYPE_HUNGRY:
            //    model=[[[GuluDishModel alloc] init] autorelease];
            break;
            
        default:
            
            break;
    }
    
    [model switchDataIntoModel:dataDictionary];
    
    return  model;
}


+ (NSString *)getGuluResultErrorMessage:(NSDictionary *)result
{
    if([result isKindOfClass:[NSDictionary class]])
    {
        id resultObject=[result objectForKey:@"errorMessage"];
        
        if([resultObject isKindOfClass:[NSString class]])
        {
            return resultObject;
        }
        else if([resultObject isKindOfClass:[NSNumber class]])
        {
            if([resultObject isEqualToNumber:[NSNumber numberWithInt:0]]){
                return @"0";}
            else if([resultObject isEqualToNumber:[NSNumber numberWithInt:1]]){
                return @"1";}
        }
    }
    
    return nil;
}

+ (GuluFriendStatus)getFriendStatus:(NSDictionary *)result
{
    if([result isKindOfClass:[NSDictionary class]])
    {
        NSNumber *resultNum=[result objectForKey:@"friend_status"];
        
        if([resultNum isEqualToNumber:[NSNumber numberWithInt:0]]){
            return GULU_FRIENDSTATUS_NOT_REQUEST;}
        else if([resultNum isEqualToNumber:[NSNumber numberWithInt:1]]){
            return GULU_FRIENDSTATUS_PENDING;}
        else if([resultNum isEqualToNumber:[NSNumber numberWithInt:2]]){
            return GULU_FRIENDSTATUS_ACCEPT;}
        else if([resultNum isEqualToNumber:[NSNumber numberWithInt:3]]){
            return GULU_FRIENDSTATUS_REJECT;}
    }
    
    return 99;
}


#pragma mark -

-(void)switchDataIntoModel:(NSDictionary *)dataDictionary
{
    [super switchDataIntoModel:dataDictionary];
    
    if([dataDictionary isKindOfClass:[NSDictionary class]])
    {
        if([dataDictionary objectForKey:@"id"])
        {
            self.ID = [dataDictionary objectForKey:@"id"];
        }
    }
}


-(void)showMyInfo:(BOOL)showMemberObject
{
    NSArray *propertiesListArray=[propsAndAttsDict allKeys];
    
    NSString *className = [[self class] description];
    
    NSLog(@"    ***** [%@] HEAD*****",className);
    NSLog(@"        id = %@",ID);
    
    for(NSString *propName in propertiesListArray)
    {
        if([propName isEqualToString:@"propertiesListArray"]){
            continue;}
        
        id temp=[self valueForKey:propName];
        
        if([[temp superclass] isSubclassOfClass:[GuluModel class]] && showMemberObject)
        {
            [temp showMyInfo:showMemberObject];
        }
        else
        {
            if([temp isKindOfClass:[NSDictionary class]] && !showMemberObject)
            {
                NSLog(@"        %@ = <NSDictionary>",propName);
            }
            else if([temp isKindOfClass:[NSArray class]] && !showMemberObject)
            {
                NSLog(@"        %@ = <NSArray>",propName);
            }
            else
            {
                NSLog(@"        %@ = %@",propName,temp);
            }
        }
    }
    
    NSLog(@"    ***** [%@] END*****",className);
}


@end
