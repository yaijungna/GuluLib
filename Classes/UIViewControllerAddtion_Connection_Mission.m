//
//  UIViewControllerAddtion_Connection_Mission.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/1.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "UIViewControllerAddtion_Connection_Mission.h"


@implementation UIViewController(MyAdditions_mission)


-(void)createMissionConnection:(ACNetworkManager *)net  
                       mission:(missionModel *)mission
                 created_user:(NSString *)created_user

{
    NSMutableDictionary *missionDict=[[[NSMutableDictionary alloc] init] autorelease];
    
    [missionDict setObject:mission.missionTitle forKey:@"title"];
    [missionDict setObject:mission.missionAbout forKey:@"description"];
    [missionDict setObject:[mission.photoDict objectForKey:@"id"] forKey:@"badge_pic"];
    [missionDict setObject:created_user forKey:@"created_user"];
   
    [missionDict setObject:mission.deadLine forKey:@"deadline"];
    [missionDict setObject:[NSString stringWithFormat:@"%d",[mission.hours intValue]*60] forKey:@"allowed_mins"];
    [missionDict setObject:mission.numberOfChallengersToGrade forKey:@"max_grade"];
    
    [missionDict setObject:mission.startTime forKey:@"start"];
   
    //===========================
    
    NSMutableArray *taskArray=[[[NSMutableArray alloc] init] autorelease];
    
    for(taskModel* taskobj in mission.taskArray)
    {
        NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
        [dict setObject:taskobj.taskTitle forKey:@"title"];
        [dict setObject:taskobj.taskAbout forKey:@"description"];
        [dict setObject:[taskobj.photoDict objectForKey:@"id"] forKey:@"main_pic"];
        [dict setObject:[taskobj.restaurantDict objectForKey:@"id"] forKey:@"restaurant"];
        if([taskobj.dishDict objectForKey:@"id"])
            [dict setObject:[taskobj.dishDict objectForKey:@"id"] forKey:@"dish"];
        else
            [dict setObject:@"" forKey:@"dish"];
        [dict setObject:taskobj.showPlace forKey:@"show_place"];
        [dict setObject:taskobj.showDish forKey:@"show_dish"];
        [dict setObject:taskobj.showNext forKey:@"show_next"];
        
        [taskArray addObject:dict];
    }
    
    //===========================
    
    NSArray *challengersArray=[mission.challengersDict allValues];
    NSArray *spectatorArray=[mission.spectatorDict allValues];
    
    NSMutableArray *cArray=[[[NSMutableArray alloc] init] autorelease];
    NSMutableArray *sArray=[[[NSMutableArray alloc] init] autorelease];
    
    
    for(NSDictionary *dict  in challengersArray)
    {
        [cArray addObject:[dict objectForKey:@"id"]];
    }
    for(NSDictionary *dict  in spectatorArray)
    {
        [sArray addObject:[dict objectForKey:@"id"]];
    }
    
    
    
    [missionDict setObject:cArray forKey:@"challengers"];
    [missionDict setObject:sArray forKey:@"spectators"];
    
    //==============================


    if(mission.missionType==FoodGuideMissionType)
    {
        [missionDict setObject:@"2" forKey:@"type"];
    }
    if(mission.missionType==DareMissiontype)
    {
        [missionDict setObject:@"1" forKey:@"type"];
    }
    if(mission.missionType==TreasureHuntMissionType)
    {
        [missionDict setObject:@"5" forKey:@"type"];
    }
    if(mission.missionType==TimeCriticalMissionType)
    {
        [missionDict setObject:@"4" forKey:@"type"];
    }
    if(mission.missionType==PrivateGroupMissionType)
    {
        [missionDict setObject:@"3" forKey:@"type"];
    }

    
    
    //===========================
    
    ACLog(@"%@",mission.hours);
    ACLog(@"%@",missionDict);
    ACLog(@"%@",taskArray);
    ACLog(@"%@",cArray);
    ACLog(@"%@",sArray);
    
    
        
    CJSONSerializer *djsonserializer = [CJSONSerializer serializer]; 
	NSString *stringmission = [djsonserializer serializeDictionary:missionDict];
    NSString *stringtasks = [djsonserializer serializeArray:taskArray];

	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:stringmission forKey:@"mission"];
    [dict setObject:stringtasks forKey:@"tasks"];
	
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"createmission" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_MISSSION_CREATE
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
	
}


-(void)tasksMissionConnection:(ACNetworkManager *)net  
                    missionID:(NSString *)missionID
                    groupID:(NSString *)groupID
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:missionID forKey:@"mid"];
    [dict setObject:groupID forKey:@"group_id"];
	
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"missiontasks" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_MISSSION_TASKS
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
}


-(void)joinMissionConnection:(ACNetworkManager *)net  
                   missionID:(NSString *)missionID
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	[dict setObject:missionID forKey:@"mid"];
	
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"missionjoin" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_MISSSION_JOIN
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];

    


}

-(void)myMissionConnection:(ACNetworkManager *)net 
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"missionMine" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_MISSSION_MINE
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];



}



-(void)GradeMissionConnection:(ACNetworkManager *)net missionID:(NSString *)mid 
{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:mid forKey:@"mid"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"grademission" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_MISSSION_MISSION_GRADE
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];

}

-(void)myCreatedMissionConnection:(ACNetworkManager *)net
{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"mycreatedmission" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_MISSSION_I_CREATED
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
}


-(void)passMissionConnection:(ACNetworkManager *)net groupID:(NSString *)gid grade:(NSString *)grade
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:gid forKey:@"group_id"];
    [dict setObject:grade forKey:@"grade"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"passmission" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_MISSSION_PASS
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
}

-(void)failMissionConnection:(ACNetworkManager *)net 
                     groupID:(NSString *)gid 
                       tasks:(NSMutableArray *)taskArray
                 failmessage:(NSString *)message
{
    NSString *tasks;
    
    for(int i=0 ; i<[taskArray count];i++)
    {
        if(i==0)
        {    
            tasks=[[taskArray objectAtIndex:0] objectForKey:@"group_task_id"];
        }
        else
        {
            tasks=[NSString stringWithFormat:@"%@|%@",tasks,[[taskArray objectAtIndex:i] objectForKey:@"group_task_id"]   ];
        }
    }
    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:gid forKey:@"group_id"];
    [dict setObject:tasks forKey:@"tasks"];
    [dict setObject:message forKey:@"fail_message"];
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"failmission" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_MISSSION_FAIL
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];

}

-(void)leaveMissionConnection:(ACNetworkManager *)net 
                     missionID:(NSString *)mid 
{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:mid forKey:@"mid"];

	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"leavemission" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_MISSSION_LEAVE
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
    
}



#pragma mark -
#pragma mark recruit Methods

-(void)acceptRecruitMissionConnection:(ACNetworkManager *)net 
                    groupID:(NSString *)gid 
{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:gid forKey:@"group_id"];
    
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"acceptrecruit" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_MISSSION_ACCEPT_RECRUIT
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
    
    
}

-(void)rejectRecruitMissionConnection:(ACNetworkManager *)net 
                              groupID:(NSString *)gid 
{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:gid forKey:@"group_id"];
    
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"rejectrecruit" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_MISSSION_REJECT_RECRUIT
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];
    
}


-(void)sendRecruitMissionConnection:(ACNetworkManager *)net 
                          missionID:(NSString *)mid 
                      guluListArray:(NSMutableArray*)gulu_list
{
   
    NSString *gulu_listString;
    
    for(int i=0 ; i<[gulu_list count];i++)
    {
        if(i==0)
        {    
            gulu_listString=[[gulu_list objectAtIndex:0] objectForKey:@"id"];
        }
        else
        {
            gulu_listString=[NSString stringWithFormat:@"%@|%@",gulu_listString,[[gulu_list objectAtIndex:i] objectForKey:@"id"]   ];
            
        }
    }

    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:mid forKey:@"mid"];
    [dict setObject:gulu_listString forKey:@"gulu_list"];
    
	
	NSMutableDictionary *ADDdict=[[NSMutableDictionary alloc] init];
	[ADDdict setObject:@"sendrecruit" forKey:@"id"];
	
	ASIFormDataRequest *request= [net createNewRequest:URL_MISSSION_SEND_RECRUIT
									keyValueDictionary:dict 
									 addtionDictionary:ADDdict];
	[dict release];
	[ADDdict release];
	
	request.delegate=self;
	[request setDidFinishSelector:@selector(ACConnectionSuccess:)];
	[request setDidFailSelector:@selector(ACConnectionFailed:)];
	
	[net addRequestToRequestsQueue:request];

    
}

@end
