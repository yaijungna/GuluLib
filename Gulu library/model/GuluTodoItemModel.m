//
//  GuluTodoItemModel.m
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluTodoItemModel.h"

@implementation GuluTodoItemModel

@synthesize  object;
@synthesize  type;
@synthesize  completed;
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
    [object release];
    [objectModel release];
    
    [super dealloc];
}


-(void)switchDataIntoModel:(NSDictionary *)dataDictionary
{
    [super switchDataIntoModel:dataDictionary];
    id model=[GuluModel getObjectByTodoType:type data:object];
    self.objectModel=model;
}


@end
