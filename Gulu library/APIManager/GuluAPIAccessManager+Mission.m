//
//  GuluAPIAccessManager+Mission.m
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluAPIAccessManager+Mission.h"

@implementation GuluAPIAccessManager(Mission)

#pragma mark -
#pragma mark create mission


- (GuluHttpRequest *)createMission :(id)target 
                            mission:(GuluMissionModel *)mission
                              tasks:(NSMutableArray *)taskArray
                   challengers:(NSMutableArray *)challengersArray
                     spectators:(NSMutableArray *)spectatorsArray
{
  
    NSAssert(target,@"Pass a null object.");
    NSAssert(mission.title,@"Pass a null object.");
    NSAssert(mission.description,@"Pass a null object.");
    NSAssert(mission.badge_pic.ID,@"Pass a null object.");
    NSAssert(mission.created_user.ID,@"Pass a null object.");
    NSAssert(taskArray,@"Pass a null object.");

    //=========================== set up mission dict =============================
    
    NSMutableDictionary *missionDict=[[[NSMutableDictionary alloc] init] autorelease];
    NSMutableArray *taskListArray=[[[NSMutableArray alloc] init] autorelease];
    
    [missionDict setObject:mission.title forKey:@"title"];
    [missionDict setObject:mission.description forKey:@"description"];
    [missionDict setObject:mission.badge_pic.ID forKey:@"badge_pic"];
    [missionDict setObject:mission.created_user.ID forKey:@"created_user"];
    [missionDict setObject:[NSString stringWithFormat:@"%f",mission.deadline] forKey:@"deadline"];
    [missionDict setObject:[NSString stringWithFormat:@"%d",mission.allowed_mins*60] forKey:@"allowed_mins"];
    [missionDict setObject:[NSString stringWithFormat:@"%d",mission.member_num] forKey:@"max_grade"];
    [missionDict setObject:[NSString stringWithFormat:@"%f",mission.start] forKey:@"start"];
    [missionDict setObject:[NSString stringWithFormat:@"%d",mission.type] forKey:@"type"];
    
    //===== set up challengers & spectators array =====
    
    NSMutableArray *cArray=[[[NSMutableArray alloc] init] autorelease];
    NSMutableArray *sArray=[[[NSMutableArray alloc] init] autorelease];
    
    for(GuluContactModel *user  in challengersArray){
        [cArray addObject:user.gulu_user_id];}
    for(GuluContactModel *user  in spectatorsArray){
        [sArray addObject:user.gulu_user_id];}
    
    [missionDict setObject:cArray forKey:@"challengers"];
    [missionDict setObject:sArray forKey:@"spectators"];
    
    //=========================== set up task array ================================
    
    for(GuluTaskModel* taskobj in taskArray)
    {
        NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
        [dict setObject:taskobj.title forKey:@"title"];
        [dict setObject:taskobj.description forKey:@"description"];
        [dict setObject:taskobj.main_pic.ID forKey:@"main_pic"];
        [dict setObject:taskobj.restaurant.ID forKey:@"restaurant"];
        if(taskobj.dish.ID)
            [dict setObject:taskobj.dish.ID forKey:@"dish"];
        else
            [dict setObject:@"" forKey:@"dish"];
        [dict setObject:[NSString stringWithFormat:@"%d",taskobj.show_place] forKey:@"show_place"];
        [dict setObject:[NSString stringWithFormat:@"%d",taskobj.show_dish] forKey:@"show_dish"];
        [dict setObject:[NSString stringWithFormat:@"%d",taskobj.show_next] forKey:@"show_next"];
        
        [taskListArray addObject:dict];
    }
    
    //===========================request================================

    
    CJSONSerializer *djsonserializer = [CJSONSerializer serializer]; 
    NSString *stringmission = [djsonserializer serializeDictionary:missionDict];
    NSString *stringtasks = [djsonserializer serializeArray:taskListArray];
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init]autorelease];
    [dict setObject:stringmission forKey:@"mission"];
    [dict setObject:stringtasks forKey:@"tasks"];

    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_MISSSION_CREATE
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(createMissioFinish:)];
    [http setDidFailSelector:@selector(createMissioFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)createMissionFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSLog(@"%@",info);
    
    [self APIRequestFinish:request returnData:info];
}

-(void)createMissionFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark task of mission

- (GuluHttpRequest *)taskListOfMission :(id)target 
                                mission:(GuluMissionModel *)mission
{
    
    NSAssert(target,@"Pass a null object.");
    NSAssert(mission,@"Pass a null object.");
    NSAssert(mission.ID,@"Pass a null object.");
    NSAssert(mission.group_id,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:mission.ID forKey:@"mid"];
    [dict setObject:mission.group_id forKey:@"group_id"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_MISSSION_TASKS
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(taskListOfMissionFinish:)];
    [http setDidFailSelector:@selector(taskListOfMissionFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)taskListOfMissionFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSLog(@"%@",info);
    
    [self APIRequestFinish:request returnData:info];
}

-(void)taskListOfMissionFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark join a mission

- (GuluHttpRequest *)joinMission :(id)target 
                          mission:(GuluMissionModel *)mission
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(mission,@"Pass a null object.");
    NSAssert(mission.ID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:mission.ID forKey:@"mid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_MISSSION_JOIN
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(joinMissionFinish:)];
    [http setDidFailSelector:@selector(joinMissionFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)joinMissionFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSLog(@"%@",info);
    
    [self APIRequestFinish:request returnData:info];
}

-(void)joinMissionFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark my mission list

- (GuluHttpRequest *)myMissionList :(id)target
{
    NSAssert(target,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_MISSSION_MINE
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(myMissionListFinish:)];
    [http setDidFailSelector:@selector(myMissionListFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)myMissionListFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSLog(@"%@",info);
    
    [self APIRequestFinish:request returnData:info];
}

-(void)myMissionListFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


#pragma mark -
#pragma mark all missions I created

- (GuluHttpRequest *)missionsICreated :(id)target;
{
    NSAssert(target,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_MISSSION_I_CREATED
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(missionsICreatedFinish:)];
    [http setDidFailSelector:@selector(missionsICreatedFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)missionsICreatedFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSLog(@"%@",info);
    
    [self APIRequestFinish:request returnData:info];
}

-(void)missionsICreatedFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark get grade missions 

- (GuluHttpRequest *)gradeMissionDetailInfomation :(id)target
                                           mission:(GuluMissionModel *)mission
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(mission.ID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:mission.ID forKey:@"mid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_MISSSION_MISSION_GRADE
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(gradeMissionDetailInfomationFinish:)];
    [http setDidFailSelector:@selector(gradeMissionDetailInfomationFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)gradeMissionDetailInfomationFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSLog(@"%@",info);
    
    [self APIRequestFinish:request returnData:info];
}

-(void)gradeMissionDetailInfomationFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


#pragma mark -
#pragma mark pass missions 

- (GuluHttpRequest *)passMission :(id)target
                          mission:(GuluMissionModel *)mission
                            grade:(NSString *)grade;
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(mission.group_id,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:mission.group_id forKey:@"group_id"];
    [dict setObject:grade forKey:@"grade"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_MISSSION_PASS
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(passMissionFinish:)];
    [http setDidFailSelector:@selector(passMissionFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)passMissionFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSLog(@"%@",info);
    
    [self APIRequestFinish:request returnData:info];
}

-(void)passMissionFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark fail mission

- (GuluHttpRequest *)failMission :(id)target
                          mission:(GuluMissionModel *)mission
                            tasks:(NSMutableArray *)tasksArray
                      failmessage:(NSString *)message;
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(mission.group_id,@"Pass a null object.");
    NSAssert(message,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    
    [dict setObject:mission.group_id forKey:@"group_id"];
//    [dict setObject:tasks forKey:@"tasks"];
    [dict setObject:message forKey:@"fail_message"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_MISSSION_FAIL
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(failMissionFinish:)];
    [http setDidFailSelector:@selector(failMissionFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)failMissionFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSLog(@"%@",info);
    
    [self APIRequestFinish:request returnData:info];
}

-(void)failMissionFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark leave mission


- (GuluHttpRequest *)leaveMission :(id)target 
                           mission:(GuluMissionModel *)mission
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(mission.ID,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:mission.ID forKey:@"mid"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_MISSSION_LEAVE
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(leaveMissionFinish:)];
    [http setDidFailSelector:@selector(leaveMissionFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)leaveMissionFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSLog(@"%@",info);
    
    [self APIRequestFinish:request returnData:info];
}

-(void)leaveMissionFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


#pragma mark -
#pragma mark accept a mission someone recruit you 

- (GuluHttpRequest *)acceptRecruitMission :(id)target 
                                   mission:(GuluMissionModel *)mission
{
    NSAssert(target,@"Pass a null object.");
    NSAssert(mission.group_id,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:mission.group_id forKey:@"group_id"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_MISSSION_ACCEPT_RECRUIT
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(acceptRecruitFinish:)];
    [http setDidFailSelector:@selector(acceptRecruitFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)acceptRecruitFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSLog(@"%@",info);
    
    [self APIRequestFinish:request returnData:info];
}

-(void)acceptRecruitFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark reject mission

- (GuluHttpRequest *)rejectRecruitMission :(id)target 
                                   mission:(GuluMissionModel *)mission
{    
    NSAssert(target,@"Pass a null object.");
    NSAssert(mission.group_id,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:mission.group_id forKey:@"group_id"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_MISSSION_REJECT_RECRUIT
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(rejectRecruitMissionFinish:)];
    [http setDidFailSelector:@selector(rejectRecruitMissionFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)rejectRecruitMissionFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSLog(@"%@",info);
    
    [self APIRequestFinish:request returnData:info];
}

-(void)rejectRecruitMissionFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}

#pragma mark -
#pragma mark send recruit mission

- (GuluHttpRequest *)sendRecruitMission :(id)target 
                                 mission:(GuluMissionModel *)mission
                              sendtoWhom:(NSMutableArray *)contactsArray
{

    NSAssert(target,@"Pass a null object.");
    NSAssert(mission.ID,@"Pass a null object.");
    NSAssert(contactsArray,@"Pass a null object.");
    
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:mission.ID forKey:@"group_id"];
    [dict setObject:[mission contactListString:contactsArray] forKey:@"gulu_list"];
    
    GuluHttpRequest *http = [self createNewGuluRequestWithURL:URL_MISSSION_SEND_RECRUIT
                                                       target:target];
    
    [self setupRequestWithData:http keyValueInfo:dict];
    
    [http setDelegate:self];
    [http setDidFinishSelector:@selector(sendRecruitMissionFinish:)];
    [http setDidFailSelector:@selector(sendRecruitMissionFail:)];
    [http startAsynchronous];
    
    return http;
}

- (void)sendRecruitMissionFinish:(GuluHttpRequest *)request
{
    id info= [self decodeJSONFromGuluRequest:request];
    
    NSLog(@"%@",info);
    
    [self APIRequestFinish:request returnData:info];
}

-(void)sendRecruitMissionFail:(GuluHttpRequest *)Request
{
    [self APIRequestFail:Request returnData:nil];
}


@end

