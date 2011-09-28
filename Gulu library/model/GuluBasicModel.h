//
//  GuluBasicModel.h
//  GULUAPP
//
//  Created by alan on 11/9/19.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface GuluBasicModel : NSObject
{
    NSMutableDictionary *propsAndAttsDict;
}

@property(nonatomic,retain) NSMutableDictionary *propsAndAttsDict;

-(void)propertiesAndAttributesList;
-(void)switchDataIntoModel:(NSDictionary *)dataDictionary;
-(void)showMyInfo:(BOOL)showMemberObject;

@end
