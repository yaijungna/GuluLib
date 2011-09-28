//
//  GuluUserModel.h
//  GULUAPP
//
//  Created by alan on 11/9/9.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"
#import "GuluPhotoModel.h"

@interface GuluUserModel : GuluModel
{
    NSString *username;
    NSString *phone;
    NSString *email;
    NSString *about_me;
    GuluPhotoModel *photo;
    NSInteger public_comments;
}
@property (nonatomic,retain) NSString *username;
@property (nonatomic,retain) NSString *phone;
@property (nonatomic,retain) NSString *email;
@property (nonatomic,retain) NSString *about_me;
@property (nonatomic,retain) GuluPhotoModel *photo;
@property (nonatomic) NSInteger public_comments;




@end
