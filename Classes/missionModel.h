//
//  missionModel.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/1.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum 
{
	FoodGuideMissionType,
    DareMissiontype,
    TreasureHuntMissionType,
    TimeCriticalMissionType,
    PrivateGroupMissionType
	
} designMissionType;


@interface missionModel : NSObject {
    
    NSString *missionTitle;
    NSString *missionAbout;
    UIImage *missionPhoto;
    
    NSMutableArray *taskArray;
    
    NSMutableDictionary *photoDict;
    
    designMissionType missionType;
    
    NSString *numberOfChallengersToGrade;
    
    NSString *deadLine;
    NSString *hours;
    
    NSString *startTime;
    NSString *endTime;
    
    NSMutableDictionary *challengersDict;
    NSMutableDictionary *spectatorDict;

}

@property (nonatomic,retain)   NSString *missionTitle;
@property (nonatomic,retain)   NSString *missionAbout;
@property (nonatomic,retain)   UIImage *missionPhoto;

@property (nonatomic,retain)   NSMutableArray *taskArray;

@property (nonatomic,retain)   NSMutableDictionary *photoDict;

@property (nonatomic)    designMissionType missionType;

@property (nonatomic,retain)   NSString *numberOfChallengersToGrade;

@property (nonatomic,retain)NSString *deadLine;
@property (nonatomic,retain)NSString *hours;

@property (nonatomic,retain) NSString *startTime;
@property (nonatomic,retain) NSString *endTime;


@property (nonatomic,retain) NSMutableDictionary *challengersDict;
@property (nonatomic,retain) NSMutableDictionary *spectatorDict;

@end
