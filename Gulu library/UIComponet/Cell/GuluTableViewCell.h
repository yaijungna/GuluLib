//
//  GuluTableViewCell.h
//  GULUAPP
//
//  Created by alan on 11/9/16.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuluTableViewCell : UITableViewCell
{
    BOOL isReusedCell;
}

@property(nonatomic)BOOL isReusedCell;

+ (id)cellForIdentifierOfTable :(NSString *)cellClassName  table:(UITableView *)theTable  ;
+ (id)cellForIdentifierOfTableFromNib :(NSString *)cellClassName  table:(UITableView *)theTable  ;

@end

