//
//  GuluGuestModel.h
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluModel.h"
#import "GuluPhotoModel.h"
#import "GuluContactModel.h"

#import "GuluTypeDefine.h"


@interface GuluGuestModel : GuluModel
{
    NSString *display_name;
    NSString *photo_url;
    NSString *uuid;
    NSString *contact_id;
}

@property(nonatomic,retain) NSString *display_name;
@property(nonatomic,retain) NSString *photo_url;
@property(nonatomic,retain) NSString *uuid;
@property(nonatomic,retain) NSString *contact_id;

-(id)initWithContactModel:(GuluContactModel *)contactObject;

@end
