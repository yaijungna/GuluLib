//
//  GuluTodoItemModel.h
//  GULUAPP
//
//  Created by alan on 11/9/12.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"
#import "GuluDishModel.h"
#import "GuluPlaceModel.h"
#import "GuluTypeDefine.h"

@interface GuluTodoItemModel : GuluModel
{
    NSDictionary *object;
    GuluToDoObjectType type;
    BOOL completed;
    
    id objectModel;
}

@property (nonatomic,retain) NSDictionary *object;
@property (nonatomic,assign)GuluToDoObjectType type;
@property (nonatomic,assign)BOOL completed;
@property (nonatomic,retain)id objectModel;


@end

