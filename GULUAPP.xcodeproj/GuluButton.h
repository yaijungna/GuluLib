//
//  GuluButton.h
//  GULUAPP
//
//  Created by alan on 11/9/27.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuluButton : UIButton
{
    NSIndexPath *indexPath;
}

@property(nonatomic,retain)NSIndexPath *indexPath;


@end
