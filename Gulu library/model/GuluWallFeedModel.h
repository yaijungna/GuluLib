//
//  GuluWallFeedModel.h
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"
#import "GuluReviewModel.h"

#import "GuluTypeDefine.h"

@interface GuluWallFeedModel : GuluModel
{
 
    NSDictionary *object;
    GuluWallFeedType type;
    
    id objectModel;
}
@property (nonatomic,retain) NSDictionary *object;
@property (nonatomic,assign) GuluWallFeedType type;

@property (nonatomic,retain) id objectModel;


@end

