//
//  CheckEmailFormat.m
//  
//
//  Created by Isken on 11/12/10.
//  Copyright 2010 Isken. All rights reserved.
//

#import "CheckEmailFormat.h"


@implementation CheckEmailFormat


-(BOOL) check:(NSString *) email{
	NSLog(@"email = %@", email);
	
	NSArray *signArray = [[[NSArray alloc] initWithObjects:@"/", @"!", @"#", @"$", @"%", @"^", @"&", @"*", @"(", @")", @"+", @"=", @"{", @"}", @"[", @"]", @"|", @"~", @"`", @"<", @">", @"..", @"--", @"@.", @".@", nil] autorelease];
//	NSArray *endCharArray = [[[NSArray alloc] initWithObjects:@"com", @"net", @"tw", @"au", @"cn", @"us", @"uk", @"jp", @"kr", @"hk", @"eu", nil] autorelease];
	BOOL signChar = NO;
	BOOL endChar = NO;
	
	NSInteger atLocation = 0;
	NSInteger atQuantity = 0;
	
	
	//check @
	for (int i = 0; i < [email length]; i++) {
		if([[email substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"@"]){
		    atLocation = i;
			atQuantity++;
		}
	}
	if([email length] > 8){

		//check char
		for(int j = 0; j < [signArray count]; j++){
			NSRange signRange = [email rangeOfString:[signArray objectAtIndex:j]];
			if(signRange.length > 0){
				signChar = YES;
			}
		}
		
		//check end char
        
        /*
		for(int j = 0; j < [endCharArray count]; j++){
			NSRange endRange = [[email substringFromIndex:[email length]-6] rangeOfString:[endCharArray objectAtIndex:j]];
			if(endRange.length > 0)
            {
				endChar = YES;
			}
            
		}
         
         */
		endChar = YES;
	}
	
	if(atLocation > 0){
		NSInteger beforeAtDotQuantity = 0;
		NSInteger afterAtDotQuantity = 0;
		for(int i = 0; i <[[email substringToIndex:atLocation] length]; i++){
			if([[[email substringToIndex:atLocation] substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"."]){
				beforeAtDotQuantity++;
			}
		}
		
		for(int i = 0; i <[[email substringFromIndex:atLocation] length]; i++){
			if([[[email substringFromIndex:atLocation] substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"."]){
				afterAtDotQuantity++;
			}
		}
		
		if(beforeAtDotQuantity > 2 || afterAtDotQuantity > 3 || afterAtDotQuantity < 1){
			//[self errorAlert:@"請確認所輸入電子信箱(Email)是否正確"];
			return NO;
		}
	}
	
	if(atQuantity > 1 || atQuantity == 0 || signChar == YES || endChar == NO || [email length] < 9){
		//[self errorAlert:@"請確認所輸入電子信箱(Email)是否正確"];
		return NO;
	}
	
//	[signArray release];
//	[endCharArray release];
	return YES;
}

-(void) errorAlert:(NSString *)string{
	//alert
//	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系統訊息" message:string delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil] autorelease];
//	[alert show];
}


-(void) dealloc{
	[super dealloc];
}

@end
