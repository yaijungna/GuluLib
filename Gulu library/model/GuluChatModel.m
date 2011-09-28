//
//  GuluChatModel.m
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluChatModel.h"

@implementation GuluChatModel


@synthesize chat_uuid;
@synthesize object;
@synthesize participant_uuid;
@synthesize type;

@synthesize  objectModel;

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
    [chat_uuid release];
    [object release];
    [participant_uuid release];
    [objectModel release];
    
    [super dealloc];
}


-(void)switchDataIntoModel:(NSDictionary *)dataDictionary
{
    [super switchDataIntoModel:dataDictionary];
    id model=[GuluModel getObjectByChatType:type data:object];
    self.objectModel=model;    
}


@end
