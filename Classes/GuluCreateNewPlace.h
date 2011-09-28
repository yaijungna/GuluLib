//
//  GuluCreateNewPlace.h
//  GULUAPP
//
//  Created by alan on 11/9/1.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuluGeneralHTTPClient.h"

@interface GuluCreateNewPlace : GuluGeneralHTTPClient
{
    NSString *name;
    NSString *phonenumber;
    NSString *address;
    NSString *city;
    NSString *lng;
    NSString *lan;
    NSString *photoID;
}

@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *phonenumber;
@property(nonatomic,retain) NSString *address;
@property(nonatomic,retain) NSString *city;
@property(nonatomic,retain) NSString *lng;
@property(nonatomic,retain) NSString *lan;
@property(nonatomic,retain) NSString *photoID;

- (id)initWithInfo:(NSString *)Name 
       phonenumber:(NSString *)Phonenumber
           address:(NSString *)Address
              city:(NSString *)City
               lng:(NSString *)Lng
               lan:(NSString *)Lan
               pid:(NSString *)PhotoOID;

- (void)startCreatingPlace;

@end
