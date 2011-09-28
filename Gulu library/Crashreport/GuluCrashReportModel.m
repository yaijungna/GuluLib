//
//  GuluCrashReportModel.m
//  GULUAPP
//
//  Created by alan on 11/9/15.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluCrashReportModel.h"

@implementation GuluCrashReportModel

- (id)initWithViewController : (id)viewcontroller
{
    self = [super init];
    if (self) {
        deleagte=viewcontroller;
        crashReporter = [PLCrashReporter sharedReporter];
    }
    
    return self;
}
- (BOOL)checkIfCrashPreviously
{
    // Check if we previously crashed
    if (![crashReporter hasPendingCrashReport]){
        NSLog(@"no pending crash report");
        return NO;   
    }
    else{
        NSLog(@"there is a pending crash report");
        return YES;
    }
    
    return NO;
}

- (void) sendCrashReport {
        
    if([MFMailComposeViewController canSendMail]){
        NSLog(@"Could send mail");
    }
    else{
        NSLog(@"Could not send mail");
        return;
    }
    
    NSError *error=nil;
    NSData *crashData=[crashReporter loadPendingCrashReportDataAndReturnError: &error];

    if (crashData == nil) {
        NSLog(@"Could not load crash report: %@", error);
        [crashReporter purgePendingCrashReport];
        return;
    }
    else
    {
        // We could send the report from here, but we'll just print out
        // some debugging info instead
        PLCrashReport *report = [[[PLCrashReport alloc] initWithData: crashData error: &error] autorelease];
        if (report == nil) {
            NSLog(@"Could not parse crash report");
            [crashReporter purgePendingCrashReport];
            return;
        }
        NSString *content=[NSString stringWithFormat:@"Crashed on %@\nCrashed with signal %@ (code %@, address=0x%" PRIx64 ")",report.systemInfo.timestamp,report.signalInfo.name,report.signalInfo.code, report.signalInfo.address];
        
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        
        if (!picker) {
            NSLog(@"Could not init MFMailComposeViewController.");
            return;
        }
        
        picker.mailComposeDelegate = self;
        [picker setSubject:[NSString stringWithFormat:@"Gulu crash report."]]; 
        [picker setToRecipients:[NSArray arrayWithObject:@"crashreport@gulu.com"]];
        [picker addAttachmentData:crashData mimeType:@"application/octet-stream" fileName:[NSString stringWithFormat:@"crash.log"]];
        [picker setMessageBody:content isHTML:NO];
        [deleagte presentModalViewController:picker animated:YES];
        
        [picker release];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller 
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error
{
    [deleagte dismissModalViewControllerAnimated:YES];
    [crashReporter purgePendingCrashReport];// Purge the report
    
    if(result==MFMailComposeResultSent){
        NSLog(@"send crash report OK.");
    }
    else{
        NSLog(@"send crash report cancel.");
    }
}

- (void)dealloc
{
    deleagte=nil;
    [super dealloc];
}


@end