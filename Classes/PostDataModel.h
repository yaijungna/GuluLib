//
//  PostDataModel.h
//  GULUAPP
//
//  Created by alan on 11/9/1.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface PostDataModel : SQLitePersistentObject
{
    UIImage *photo;
    NSMutableDictionary *restaurantDict;
    NSMutableDictionary *dishDict;
    NSMutableDictionary *photoDict;
    NSString *review;
    NSString *bestKnownFor;
    
    NSString *todoid;
    NSString *taskid;
    NSString *groupid;
    
    NSInteger isThumb ;  // up:1  down:-1  noChose:0
    BOOL isGuluapproved ;
}


@property(nonatomic,retain) UIImage *photo;
@property(nonatomic,retain) NSMutableDictionary *restaurantDict;
@property(nonatomic,retain) NSMutableDictionary *dishDict;
@property(nonatomic,retain) NSMutableDictionary *photoDict;
@property(nonatomic,retain) NSString *review;
@property(nonatomic,retain) NSString *bestKnownFor;

@property(nonatomic,retain) NSString *todoid;
@property(nonatomic,retain) NSString *taskid;
@property(nonatomic,retain) NSString *groupid;

@property(nonatomic)NSInteger isThumb ;
@property(nonatomic)BOOL isGuluapproved ;


@end
