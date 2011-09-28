//
//  ACUtility.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/7.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

@interface ACUtility : NSObject {

}

+ (void) cleanCookie;

+(void)moveTheView:(id)theView moveToPosition :(CGPoint)position;

+ (NSMutableArray *)doSearchArray  :(NSMutableArray *)array searchTerm:(NSString *)term;
+ (NSMutableArray *)doSearchRestaurantArray  :(NSMutableArray *)array searchTerm:(NSString *)term;
+ (NSMutableArray *)doSearchDishArray  :(NSMutableArray *)array searchTerm:(NSString *)term;
+ (id) createRoundedRectImage:(UIImage*)image size:(CGSize)size;
+ (float) calculateDistance :(CLLocation *)from destination:(CLLocation*)to;

+ (NSString *) nsdateTofloatString:(NSDate *)date;
+ (NSDate *) floatStringToNSDate:(NSString *)time;
+ (NSString *) dateStringToDateFormatString:(NSString *)time;
+ (NSString *) dateStringToDateFormatString_withoutTime:(NSString *)time;
+ (NSString *) dateStringToDateFormatDate:(NSDate *)date;


+ (BOOL)isInteger:(NSString *)toCheck ;

@end


@interface NSArray (Reverse)
- (NSArray *)reversedArray ;
@end

@interface NSMutableArray (Reverse)
- (void)reverse;
@end

//=========================================

@implementation NSArray (Reverse)

- (NSArray *)reversedArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
}

@end

@implementation NSMutableArray (Reverse)

- (void)reverse {
    NSInteger i = 0;
    NSInteger j = [self count] - 1;
    
	while (i < j) 
	{
        [self exchangeObjectAtIndex:i
                  withObjectAtIndex:j];
		
        i++;
        j--;
    }
}
@end

