//
//  UIViewControllerAddtion_Connection_Mission.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/1.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewControllerAddtion.h"
#import "ACNetworkManager.h"
#import "API_URL_MISSION.h"

@interface UIViewController(MyAdditions_mission)

-(void)createMissionConnection:(ACNetworkManager *)net  
                       mission:(missionModel *)mission
                  created_user:(NSString *)created_user; 

-(void)tasksMissionConnection:(ACNetworkManager *)net  
                    missionID:(NSString *)missionID
                      groupID:(NSString *)groupID;

-(void)joinMissionConnection:(ACNetworkManager *)net  
                    missionID:(NSString *)missionID;

-(void)myMissionConnection:(ACNetworkManager *)net  ;


-(void)GradeMissionConnection:(ACNetworkManager *)net missionID:(NSString *)mid;
-(void)myCreatedMissionConnection:(ACNetworkManager *)net;


-(void)passMissionConnection:(ACNetworkManager *)net groupID:(NSString *)gid grade:(NSString *)grade;
-(void)failMissionConnection:(ACNetworkManager *)net 
                     groupID:(NSString *)gid 
                       tasks:(NSMutableArray *)taskArray
                 failmessage:(NSString *)message;

-(void)leaveMissionConnection:(ACNetworkManager *)net 
                    missionID:(NSString *)mid ;


-(void)acceptRecruitMissionConnection:(ACNetworkManager *)net 
                              groupID:(NSString *)gid ;

-(void)rejectRecruitMissionConnection:(ACNetworkManager *)net 
                              groupID:(NSString *)gid ;

-(void)sendRecruitMissionConnection:(ACNetworkManager *)net 
                          missionID:(NSString *)mid 
                      guluListArray:(NSMutableArray*)gulu_list;

 
@end
