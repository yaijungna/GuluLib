//
//  NSStreamAdditions.h
//  GULUAPP
//
//  Created by chen alan on 2011/5/26.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSStream (MyAdditions)

+ (void)getStreamsToHostNamed:(NSString *)hostName 
                         port:(NSInteger)port 
                  inputStream:(NSInputStream **)inputStreamPtr 
                 outputStream:(NSOutputStream **)outputStreamPtr;

@end
