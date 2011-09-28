//
//  TimeAgoFormat.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TimeAgoFormat : NSObject {
    
}

+(NSString *)getTimeAgoPeriod:(NSString *)timeString;
+(NSString *)TimeAgoString:(NSString *)timeAgoString;

@end
