//
//  GuluHttpRequest.h
//  GULUAPP
//
//  Created by alan on 11/9/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"


@interface GuluHttpRequest : ASIFormDataRequest
{
    id  guluTarget;
    int tag;
    id  tagObj;
}

@property( nonatomic,retain)id guluTarget;
@property( assign)int tag;
@property( nonatomic,retain)id tagObj;

@end
