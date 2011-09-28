//
//  crashreportModel.m
//  GULUAPP
//
//  Created by alan on 11/8/10.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "crashreportModel.h"

@implementation crashreportModel

- (id)initWithViewController : (id)viewcontroller
{
    self = [super init];
    if (self) {
        // Initialization code here.
        deleagte=viewcontroller;
    }
    
    return self;
}

#pragma mark -
#pragma mark Called to handle a pending crash report.


-(void) sendcrashreport : (NSData *)crashData  content:(NSString *)content
{
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    
    if (!picker) {
        NSLog(@"send crash report fail");
        return;
    }
    
    NSLog(@"send crash report start");

    picker.mailComposeDelegate = self;
    
    [picker setSubject:[NSString stringWithFormat:@"Gulu crash report %@",BuildVersionData]];
  //  NSArray *toRecipients = [NSArray arrayWithObject:@"alan.chen@geniecapital.com.tw"]; 
    NSArray *toRecipients = [NSArray arrayWithObject:@"crashreport@gulu.com"]; 
  //  NSArray *ccRecipients = [NSArray arrayWithObjects:@"justin.hsiao@geniecapital.com.tw", @"traderwerks@gmail.com",@"dennis.chao@geniecapital.com.tw",nil]; 
    [picker setToRecipients:toRecipients];
 //   [picker setCcRecipients:ccRecipients];
    
    [picker addAttachmentData:crashData mimeType:@"application/octet-stream" fileName:[NSString stringWithFormat:@"%@.log",BuildVersionData]];
    
    [picker setMessageBody:content isHTML:NO];
    
    [deleagte presentModalViewController:picker animated:YES];
    
    [picker release];
}

//
// Called to handle a pending crash report.
//
- (void) handleCrashReport {
    
    PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
    NSLog(@"crashReporter object=%@ , hasPendingCrashReport=%d",crashReporter,[crashReporter hasPendingCrashReport]);
    
    // Check if we previously crashed
    if (![crashReporter hasPendingCrashReport])
    {
        NSLog(@"no pending crash report");
       return;   
    }
    
    if([MFMailComposeViewController canSendMail])
    {
     //   [self showWarningAlert:NSLocalizedString(@"Because app crashed last time.\nPlease send the crash report to us.\nThank you very much.", @"send crash report")];
        NSLog(@"Could send mail");
    }
    else
    {
        NSLog(@"Could not send mail");
        return;
    }
    
    NSData *crashData;
    NSError *error;
    
    // Try loading the crash report
    crashData = [crashReporter loadPendingCrashReportDataAndReturnError: &error];
    if (crashData == nil) {
        NSLog(@"Could not load crash report: %@", error);
        [crashReporter purgePendingCrashReport];
        return;
    }
    
    // We could send the report from here, but we'll just print out
    // some debugging info instead
    PLCrashReport *report = [[[PLCrashReport alloc] initWithData: crashData error: &error] autorelease];
    if (report == nil) {
        NSLog(@"Could not parse crash report");
        [crashReporter purgePendingCrashReport];
        return;
    }
    
    NSString *str=[NSString stringWithFormat:@"Build:%@\nCrashed on %@\nCrashed with signal %@ (code %@, address=0x%" PRIx64 ")",BuildVersionData,report.systemInfo.timestamp,report.signalInfo.name,report.signalInfo.code, report.signalInfo.address];
    
    [self sendcrashreport:crashData content:str];
    return;
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [deleagte dismissModalViewControllerAnimated:YES];
    // Purge the report
    PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
    [crashReporter purgePendingCrashReport];
    
    if(result==MFMailComposeResultSent)
    {
        //   [self showOKAlert:NSLocalizedString(@"Send crash report ok!", @"send crash report ok")];
        NSLog(@"send crash report OK");
        return;
    }
    else
    {
        NSLog(@"send crash report cancel");
    }
    
}

- (void)dealloc
{
    deleagte=nil;
    [super dealloc];
}


@end
