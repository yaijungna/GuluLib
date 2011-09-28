//
//  taskModel.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/1.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface taskModel : NSObject {
    
    
    NSString *taskTitle;
    NSString *taskAbout;
    UIImage *taskPhoto;
    
    NSMutableDictionary *restaurantDict;
    NSMutableDictionary *dishDict;
    NSMutableDictionary *photoDict;
    
    NSString *showPlace;
    NSString *showDish;
    NSString *showNext;
    
    BOOL isChangePhoto;

}

@property (nonatomic,retain) NSString *taskTitle;
@property (nonatomic,retain) NSString *taskAbout;
@property (nonatomic,retain) UIImage *taskPhoto;

@property (nonatomic,retain) NSMutableDictionary *restaurantDict;
@property (nonatomic,retain) NSMutableDictionary *dishDict;
@property (nonatomic,retain) NSMutableDictionary *photoDict;

@property (nonatomic,retain) NSString *showPlace;
@property (nonatomic,retain) NSString *showDish;
@property (nonatomic,retain) NSString *showNext;
@property (nonatomic) BOOL isChangePhoto;

@end
