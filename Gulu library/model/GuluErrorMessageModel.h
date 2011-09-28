//
//  GuluErrorMessageModel.h
//  GULUAPP
//
//  Created by alan on 11/9/14.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"

@interface GuluErrorMessageModel : GuluModel
{
    NSString  *error;
    NSString *errorMessage;
}

@property (nonatomic,retain) NSString *error;
@property (nonatomic,retain) NSString *errorMessage;

@end
