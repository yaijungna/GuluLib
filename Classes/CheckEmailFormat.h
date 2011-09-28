//
//  CheckEmailFormat.h
//  
//
//  Created by Isken on 11/12/10.
//  Copyright 2010 Isken. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CheckEmailFormat : NSObject {
	
}

-(BOOL) check:(NSString *) string;
-(void) errorAlert:(NSString *)string;

@end
