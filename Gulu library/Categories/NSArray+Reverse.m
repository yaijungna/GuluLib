//
//  NSArray+Reverse.m
//  GULUAPP
//
//  Created by alan on 11/9/15.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "NSArray+Reverse.h"


@implementation NSArray (Reverse)

- (NSArray *)reverse 
{
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

