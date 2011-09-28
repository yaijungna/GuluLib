//
//  NSStream+additions.h
//  GULUAPP
//
//  Created by alan on 11/9/14.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSStream (Additions)

+ (void)getStreamsToHostNamed:(NSString *)hostName 
                         port:(NSInteger)port 
                  inputStream:(NSInputStream **)inputStreamPtr 
                 outputStream:(NSOutputStream **)outputStreamPtr;

@end
