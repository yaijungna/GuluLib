//
//  GuluUtility.m
//  GULUAPP
//
//  Created by alan on 11/9/15.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluUtility.h"
#import <SystemConfiguration/SCNetworkReachability.h>
#import <netinet/in.h>


@implementation GuluUtility

+ (BOOL) validateEmail: (NSString *) candidate 
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    
    return [emailTest evaluateWithObject:candidate];
}

+(BOOL)checkUserName:(NSString *)text
{
    NSString *Regex = @"^\\w{4,16}$"; 
    NSPredicate *userTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex]; 
    return [userTest evaluateWithObject:text];
}

-(BOOL)CheckPassword:(NSString *)text
{
    NSString *Regex = @"\\w{6,16}";
    NSPredicate *pwTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex]; 
    return [pwTest evaluateWithObject:text];
}

+ (BOOL) checkIsInteger:(NSString *)toCheck ;
{
    NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];    
    NSString *trimmed = [toCheck stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    BOOL isNumeric = trimmed.length > 0 && [trimmed rangeOfCharacterFromSet:nonNumberSet].location == NSNotFound;
    
    return isNumeric;
}

+ (BOOL) checkConnection
{
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
    
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
    
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
    
	if (!didRetrieveFlags){
		return NO;}
    
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    
	return (isReachable && !needsConnection) ? YES : NO;
}

+ (void) cleanCookie
{
	NSHTTPCookie *cookie;
	NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	
	for (cookie in [storage cookies]) {
		[storage deleteCookie:cookie];}
}

+(void)moveTheView:(id)theView moveToPosition:(CGPoint)position
{
    if([theView isKindOfClass:[UIView class]])
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        CGRect Frame=CGRectMake(position.x ,position.y ,((UIView *)theView).frame.size.width ,((UIView *)theView).frame.size.height );
        ((UIView *)theView).frame=Frame;
        [theView layoutSubviews];
        [UIView commitAnimations];
    }
}

+ (void)addBackgroundFrame:(id)target backgroundImage:(UIImage *)bg distance:(NSInteger)dist
{
    if( [target isKindOfClass:[UIView class]])
    {
        UIView *temp=(UIView *)target;
        if( [[temp superview] isKindOfClass:[UIView class]])
        {
            UIView *tempsuperview=[temp superview];
            CGRect frame=temp.frame;
            UIImageView *bgImageView=[[[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x-dist, frame.origin.y-dist, frame.size.width+dist*2, frame.size.height+dist*2)] autorelease];
            [tempsuperview insertSubview:bgImageView belowSubview:target];
            [bgImageView setImage:bg];
        }
    }
}

+ (float) calculateDistance :(CLLocation *)from destination:(CLLocation*)to
{
	CLLocationDistance d = [from distanceFromLocation:to];
	float distance = d/1000;
	
	return distance;
}

+ (double)time_NSDateTodouble:(NSDate *)date
{
	return [date timeIntervalSince1970];
}

+ (NSDate *)time_doubleToNSDate:(double)time;
{	
	return [NSDate dateWithTimeIntervalSince1970:time];
}

+ (NSString *) time_NSDateToDateFormatString:(NSDate *)date format:(NSString *)format
{	      
    if(!format){
        format=@"yy/MM/dd EEEE hh:mm a";}
    
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease]; 
	[dateFormatter setDateFormat:format]; 
	return [dateFormatter stringFromDate:date];  
}

+(NSString *)timeAgoString:(double)timePeriod
{
    
    NSString *dateContent=@"";
    NSString *ago=NSLocalizedString(@"ago", @"how long ago");
    NSString *daysago   =NSLocalizedString(@"days", @"how long ago");
    NSString *hoursago  =NSLocalizedString(@"hours", @"how long ago");
    NSString *minsago   =NSLocalizedString(@"minutes", @"how long ago");
    NSString *justnow   =NSLocalizedString(@"Just Now", @"how long ago");
    NSString *about  =NSLocalizedString(@"About", @"about how long ago");
    NSString *yesterday  =NSLocalizedString(@"Yesterday", @"");
    
    /*
     0-5min [Just now]
     5-59min [NN minutes ago] eg: 54 minutes ago
     1hr-23hr59min [About NN hours ago] eg: About 2 hours ago
     24hr-47hr59min [Yesterday] eg: Yesterday
     48hr-7days [N days ago] eg: 6 days ago
     7days+ [DAY, Month, Date, Year] eg: Tuesday, Aug 23, 2011
     */

    NSTimeInterval nowtime=[[NSDate date] timeIntervalSince1970];
    
    if(timePeriod<0)
        timePeriod=0;
    
    if(timePeriod>7*24*3600){
        NSDate *date =  [NSDate dateWithTimeIntervalSince1970:nowtime-timePeriod];      
        return [GuluUtility time_NSDateToDateFormatString:date format:@"EEE, MMM d, yyyy"];
    }
    
    NSInteger days=((NSInteger)timePeriod)/(3600*24);
    NSInteger hours=((NSInteger)timePeriod)/3600;
    NSInteger mins=((NSInteger)timePeriod)/60;

    
    if(days>0){
        if(days==1){
            dateContent=yesterday;
            return yesterday;
        }
        else{
            dateContent=[NSString stringWithFormat:@"%d %@",days,daysago];
        }
    }
    else  // day==0
    {
        if(hours>0){
            dateContent=[NSString stringWithFormat:@"%@ %d %@",about,hours,hoursago];    
        }
        else{//< 1 hour
            if(mins<=5){
                dateContent=justnow;
            }
            else{
                dateContent=[NSString stringWithFormat:@"%d %@",mins,minsago];
            }
        }
    }
    dateContent=[NSString stringWithFormat:@"%@ %@",dateContent,ago];
    return dateContent;
    
}




@end
