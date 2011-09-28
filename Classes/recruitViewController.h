//
//  recruitViewController.h
//  GULUAPP
//
//  Created by chen alan on 2011/7/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "choseFriendViewController.h"
#import "UIViewControllerAddtion_Connection_Mission.h"

@interface recruitViewController : choseFriendViewController {
    NSMutableDictionary *missionDict;
    
}
@property (nonatomic,retain)NSMutableDictionary *missionDict;

@end
