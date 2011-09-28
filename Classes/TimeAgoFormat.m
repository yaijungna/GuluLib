//
//  TimeAgoFormat.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/13.
//  Copyright 2011年 gulu.com. All rights reserved.
//



#import "TimeAgoFormat.h"
#import "ACUtility.h"

@implementation TimeAgoFormat


+(NSString *)getTimeAgoPeriod:(NSString *)timeString
{
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970];	
    NSString *nowStr=[NSString stringWithFormat:@"%0.0f",time];	
    
    if([nowStr floatValue]-[timeString floatValue]>=0)
    {
        return [NSString stringWithFormat:@"%f", [nowStr floatValue]-[timeString floatValue]]; 
    }
    
    return [NSString stringWithFormat:@"%f", 0]; 
}

+(NSString *)TimeAgoString:(NSString *)timeAgoString
{
    NSInteger timePeriod =[timeAgoString intValue];
    NSTimeInterval nowtime=[[NSDate date] timeIntervalSince1970];
    
    if(timePeriod<0)
        timePeriod=0;
    
    if(timePeriod>nowtime)
    {
     //   NSLog(@"timePeriod=%d,NSTimeIntervalSince1970=%f",timePeriod,nowtime);
        timePeriod=nowtime-timePeriod;
        return  [ACUtility dateStringToDateFormatString_withoutTime:[NSString stringWithFormat:@"%f",timePeriod]];
    }
    
    if(timePeriod>7*24*60*60)
    {
    //    NSLog(@"timePeriod=%d,%d",timePeriod,7*24*60*6);
    //    NSLog(@"%f\n",nowtime-timePeriod);
        
        NSDate *date =  [NSDate dateWithTimeIntervalSince1970:nowtime-timePeriod];        
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease]; 
        [dateFormatter setDateFormat:@"EEE, MMM d, yyyy"]; 
        NSString *dateStr = [dateFormatter stringFromDate:date];  
        
        return dateStr;

        
     //   return  [ACUtility dateStringToDateFormatString_withoutTime:[NSString stringWithFormat:@"%f",nowtime-timePeriod]];
    }
    
    
    NSInteger days=((NSInteger)timePeriod)/(3600*24);
    NSInteger hours=((NSInteger)timePeriod)/(3600)%24;
    NSInteger mins=((NSInteger)timePeriod)/60%60;
    // NSInteger secs=((NSInteger)timePeriod)%60;
    
    //   NSLog(@"%d,%d,%d,%d,",days,hours,mins,secs);
    
    NSString *dateContent=@"";
    NSString *ago=NSLocalizedString(@"ago", @"how long ago");
    
//    NSString *dayago    =NSLocalizedString(@"day", @"how long ago");
    NSString *daysago   =NSLocalizedString(@"days", @"how long ago");
 //   NSString *hourago   =NSLocalizedString(@"hour", @"how long ago");
    NSString *hoursago  =NSLocalizedString(@"hours", @"how long ago");
//    NSString *minago    =NSLocalizedString(@"minute", @"how long ago");
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
    
    if(days>0)
    {
        if(days==1)
        {
            dateContent=yesterday;
            return dateContent;
        }
        else
        {
            dateContent=[NSString stringWithFormat:@"%d %@",days,daysago];
        }
        
    /*    if(hours>0)
        {
            if(hours==1)
            {
                dateContent=[NSString stringWithFormat:@"%@,%d %@",dateContent,hours,hourago];
            }
            else
            {
                dateContent=[NSString stringWithFormat:@"%@,%d %@",dateContent,hours,hoursago];
            }
        }
     */
        
        dateContent=[NSString stringWithFormat:@"%@ %@",dateContent,ago];
        
    }
    else  // day==0
    {
        if(hours>0)
        {
         /*   if(hours==1)
            {
                dateContent=[NSString stringWithFormat:@"%d %@",hours,hourago];
            }
            else
            {
                dateContent=[NSString stringWithFormat:@"%d %@",hours,hoursago];
            }
            
            if(mins>0)
            {
                if(mins==1)
                {
                    dateContent=[NSString stringWithFormat:@"%@,%d %@",dateContent,mins,minago];
                }
                else
                {
                    dateContent=[NSString stringWithFormat:@"%@,%d %@",dateContent,mins,minsago];
                }
            }
          */
            
            dateContent=[NSString stringWithFormat:@"%@ %d %@",about,hours,hoursago];
            
            
            dateContent=[NSString stringWithFormat:@"%@ %@",dateContent,ago];
            
        }
        else //< 1 hour
        {
            if(mins<=5)
            {
                dateContent=justnow;
                return dateContent;
            }
            else
            {
                dateContent=[NSString stringWithFormat:@"%d %@",mins,minsago];
            }
            
            dateContent=[NSString stringWithFormat:@"%@ %@",dateContent,ago];
        }
        
    }
    
  //  NSLog(@"data content = %@",dateContent);
    return dateContent;
    
}

@end
