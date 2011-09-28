//
//  missionModel.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/1.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "missionModel.h"


@implementation missionModel

@synthesize missionTitle;
@synthesize missionAbout;
@synthesize missionPhoto;

@synthesize taskArray;
@synthesize photoDict;

@synthesize  missionType;

@synthesize  deadLine;
@synthesize  hours;

@synthesize startTime;
@synthesize endTime;


@synthesize challengersDict;
@synthesize spectatorDict;

@synthesize numberOfChallengersToGrade;

- (id)init {
	
	if(self=[super init])
	{
        deadLine=@"";
        hours=@"";
        startTime=@"";
        endTime=@"";
        numberOfChallengersToGrade=@"";
	}
	return self;
}


- (void) dealloc
{
    [missionTitle release];
    [missionAbout release];
    [missionPhoto release];
    [taskArray release];
    [photoDict release];
    
    [numberOfChallengersToGrade release];
    
    [startTime release];
    [endTime release];
    
    [challengersDict release];
    [spectatorDict release];
    
	[super dealloc];
}

@end
