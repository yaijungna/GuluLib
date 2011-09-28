//
//  GuluAPIAccessManager+Mission.h
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluAPIAccessManager.h"

#import "GuluMissionModel.h"
#import "GuluTaskModel.h"
#import "GuluContactModel.h"

#import "API_URL_MISSION.h"

@interface GuluAPIAccessManager(Mission)

#pragma mark -
#pragma mark  basic mission

- (GuluHttpRequest *)createMission :(id)target 
                            mission:(GuluMissionModel *)mission
                              tasks:(NSMutableArray *)taskArray   // GuluTaskModel Array
                        challengers:(NSMutableArray *)challengersArray // GuluContactModel Array
                         spectators:(NSMutableArray *)spectatorsArray; // GuluContactModel Array

- (GuluHttpRequest *)taskListOfMission :(id)target 
                          mission:(GuluMissionModel *)mission;

- (GuluHttpRequest *)joinMission :(id)target 
                                mission:(GuluMissionModel *)mission;

- (GuluHttpRequest *)myMissionList :(id)target;

- (GuluHttpRequest *)missionsICreated :(id)target;


#pragma mark -
#pragma mark grade mission

- (GuluHttpRequest *)gradeMissionDetailInfomation :(id)target
                               mission:(GuluMissionModel *)mission;

- (GuluHttpRequest *)passMission :(id)target
                          mission:(GuluMissionModel *)mission
                          grade:(NSString *)grade;

- (GuluHttpRequest *)failMission :(id)target
                          mission:(GuluMissionModel *)mission
                            tasks:(NSMutableArray *)tasksArray
                      failmessage:(NSString *)message;

#pragma mark -
#pragma mark recruit mission

- (GuluHttpRequest *)leaveMission :(id)target 
                          mission:(GuluMissionModel *)mission;

- (GuluHttpRequest *)acceptRecruitMission :(id)target 
                          mission:(GuluMissionModel *)mission;

- (GuluHttpRequest *)rejectRecruitMission :(id)target 
                                  mission:(GuluMissionModel *)mission;

- (GuluHttpRequest *)sendRecruitMission :(id)target 
                                 mission:(GuluMissionModel *)mission
                              sendtoWhom:(NSMutableArray *)contactsArray;


@end



