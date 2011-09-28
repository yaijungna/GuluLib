//
//  GuluPostImage.h
//  GULUAPP
//
//  Created by alan on 11/9/1.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluGeneralHTTPClient.h"

@interface GuluPostImage : GuluGeneralHTTPClient
{
    UIImage *photo;
}

@property(nonatomic,retain) UIImage *photo;

- (id)initWithPhoto:(UIImage *)image;

- (void)startSubmitPhoto;

@end
