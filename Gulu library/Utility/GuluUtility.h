//
//  GuluUtility.h
//  GULUAPP
//
//  Created by alan on 11/9/15.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

@interface GuluUtility : NSObject {
    
}

+ (BOOL)    checkIsInteger:(NSString *)toCheck ;
+ (BOOL)    checkUserName:(NSString *)text;
- (BOOL)    CheckPassword:(NSString *)text;
+ (BOOL)    checkConnection;

+ (BOOL)    validateEmail: (NSString *) candidate ;
+ (void)    cleanCookie;
+ (void)    moveTheView:(id)theView moveToPosition:(CGPoint)position;
+ (void)    addBackgroundFrame:(id)target backgroundImage:(UIImage *)bg distance:(NSInteger)dist;
+ (float)   calculateDistance :(CLLocation *)from destination:(CLLocation*)to;

+ (double)     time_NSDateTodouble:(NSDate *)date;
+ (NSDate *)   time_doubleToNSDate:(double)time;
+ (NSString *) time_NSDateToDateFormatString:(NSDate *)date format:(NSString *)format;
+ (NSString *) timeAgoString:(double)timePeriod;

@end


