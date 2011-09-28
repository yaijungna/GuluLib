//
//  GuluCrashReportModel.h
//  GULUAPP
//
//  Created by alan on 11/9/15.
//  Copyright 2011年 gulu.com. All rights reserved.
//


/*
Add a mail modalViewController on viewController
*/

#import <Foundation/Foundation.h>
#import <CrashReporter/CrashReporter.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface GuluCrashReportModel : NSObject<MFMailComposeViewControllerDelegate>
{
    id deleagte;
    PLCrashReporter *crashReporter;
}

- (id)initWithViewController : (id)viewcontroller;

- (BOOL) checkIfCrashPreviously;
- (void) sendCrashReport;

@end
