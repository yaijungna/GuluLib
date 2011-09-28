//
//  ACUtility.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/7.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACUtility.h"

@implementation ACUtility


+ (void) cleanCookie
{
	NSHTTPCookie *cookie;
	NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	
	for (cookie in [storage cookies]) 
	{
		[storage deleteCookie:cookie];
	}
}

+(void)moveTheView:(id)theView moveToPosition :(CGPoint)position
{
    if([theView isKindOfClass:[UIView class]])
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        CGRect Frame=CGRectMake(position.x, position.y , ((UIView *)theView).frame.size.width ,((UIView *)theView).frame.size.height );
        ((UIView *)theView).frame=Frame;
        [theView layoutSubviews];
        [UIView commitAnimations];
    }
}

+ (NSMutableArray *)doSearchArray  :(NSMutableArray *)array searchTerm:(NSString *)term
{
	NSMutableArray *arr=[[NSMutableArray alloc] init];
	
	for(NSString *str in array)
	{
		BOOL match = ([str rangeOfString:term options:NSCaseInsensitiveSearch].location != NSNotFound);
		if(match)
		{
			[arr addObject:str];
		}
	}
	return [arr autorelease];
}




+ (NSMutableArray *)doSearchRestaurantArray  :(NSMutableArray *)array searchTerm:(NSString *)term
{
	NSMutableArray *arr=[[NSMutableArray alloc] init];
	
	for(NSDictionary *dict in array)
	{
		NSString *name=[dict objectForKey:@"name"];
		
		BOOL match = ([name rangeOfString:term options:NSCaseInsensitiveSearch].location != NSNotFound);
		if(match)
		{
			[arr addObject:dict];
		}
	}
	return [arr autorelease];
}

+ (NSMutableArray *)doSearchDishArray  :(NSMutableArray *)array searchTerm:(NSString *)term
{
	NSMutableArray *arr=[[NSMutableArray alloc] init];
	
	for(NSDictionary *dict in array)
	{
		NSString *name=[dict objectForKey:@"name"];
		
		BOOL match = ([name rangeOfString:term options:NSCaseInsensitiveSearch].location != NSNotFound);
		if(match)
		{
			[arr addObject:dict];
		}
	}
	return [arr autorelease];
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
								 float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
		CGContextAddRect(context, rect);
		return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}


+ (id) createRoundedRectImage:(UIImage*)image size:(CGSize)size
{
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;
    
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, 10, 10);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
	/** GMC ********* CHECK THIS PART - SUSPECIOUS ********************************
	 Given the new code, the retainCount of the UIImage as it comes out of 
	 the function will be 1, and assigning it to the imageView's image will 
	 cause it to bump to 2. At that point deallocating the imageView will 
	 leave the retainCount of the UIImage to be 1, resulting in a leak. It 
	 is important, then, after assigning the UIImage to the imageView, to 
	 release it. It may look a bit strange, but it will cause the 
	 retainCount to be properly set to 1.
	 *********************************************************************/
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    UIImage     *result = [UIImage imageWithCGImage:imageMasked];
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease( imageMasked);
    
   // return [UIImage imageWithCGImage:imageMasked];
    
    return result ;
    
}

+ (float) calculateDistance :(CLLocation *)from destination:(CLLocation*)to
{
	CLLocationDistance d = [from distanceFromLocation:to];
	float distance = d/1000;
	
	return distance;
}

+ (NSString *) nsdateTofloatString:(NSDate *)date
{
	NSTimeInterval time=[date timeIntervalSince1970];	
    
    NSLog(@"[ACUtility nsdateTofloatString] time=%@",[NSString stringWithFormat:@"%f",time]);
	
	return [NSString stringWithFormat:@"%f",time];	
}

+ (NSDate *) floatStringToNSDate:(NSString *)time
{	
//    NSLog(@"[ACUtility floatStringToNSDate] time=%@",time);
    
	return [NSDate dateWithTimeIntervalSince1970:[time floatValue]];
}

+ (NSString *) dateStringToDateFormatString:(NSString *)time
{	
//    NSLog(@"[ACUtility dateStringToDateFormatString] time=%@",time);
    
	NSDate *date = [self floatStringToNSDate:time];        
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease]; 
	[dateFormatter setDateFormat:@"yy/MM/dd EEEE hh:mm a"]; 
	NSString *dateStr = [dateFormatter stringFromDate:date];  
    
   //  NSLog(@"time=%@",[NSString stringWithFormat:@"%f",time]);

	return dateStr;
}
+ (NSString *) dateStringToDateFormatString_withoutTime:(NSString *)time
{	
 //   NSLog(@"[ACUtility dateStringToDateFormatString] time=%@",time);
    
	NSDate *date = [self floatStringToNSDate:time];        
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease]; 
	[dateFormatter setDateFormat:@"yy/MM/dd EEEE"]; 
	NSString *dateStr = [dateFormatter stringFromDate:date];  
    
    //  NSLog(@"time=%@",[NSString stringWithFormat:@"%f",time]);
    
	return dateStr;
}


+ (NSString *) dateStringToDateFormatDate:(NSDate *)date
{	      
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease]; 
	[dateFormatter setDateFormat:@"yy/MM/dd EEEE hh:mm a"]; 
	NSString *dateStr = [dateFormatter stringFromDate:date];  
    
    //  NSLog(@"time=%@",[NSString stringWithFormat:@"%f",time]);
    
	return dateStr;
}


+ (BOOL)isInteger:(NSString *)toCheck 
{
    NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];    NSString *trimmed = [toCheck stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    BOOL isNumeric = trimmed.length > 0 && [trimmed rangeOfCharacterFromSet:nonNumberSet].location == NSNotFound;
    
    return isNumeric;
}







@end
