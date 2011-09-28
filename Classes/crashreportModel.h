//
//  crashreportModel.h
//  GULUAPP
//
//  Created by alan on 11/8/10.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CrashReporter/CrashReporter.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

#define BuildVersionData @"Debug-2011-09-07-1"

@interface crashreportModel : NSObject <MFMailComposeViewControllerDelegate>
{
    id deleagte;
}

- (id)  initWithViewController : (id)viewcontroller;
- (void) handleCrashReport;



@end
