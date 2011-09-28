//
//  GuluGuestModel.m
//  GULUAPP
//
//  Created by alan on 11/9/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluGuestModel.h"

@implementation GuluGuestModel

@synthesize display_name;
@synthesize photo_url;
@synthesize uuid;
@synthesize contact_id;

-(id)initWithContactModel:(GuluContactModel *)contactObject
{
    
    self = [super init];
    if (self) {
        self.contact_id=contactObject.ID;
        self.photo_url=contactObject.profile_pic; 
    }
    
    return self;
}


- (void)dealloc
{
    [display_name release];
    [photo_url release];
    [uuid release];
    [contact_id release];
    
    [super dealloc];
}


@end
