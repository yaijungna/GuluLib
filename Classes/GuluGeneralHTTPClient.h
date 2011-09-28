//
//  GuluGeneralHTTPClient.h
//  GULUAPP
//
//  Created by alan on 11/8/31.
//  Copyright 2011年 gulu.com. All rights reserved.
//




#import <Foundation/Foundation.h>
#import "GuluHttpClient.h"

@protocol GuluGeneralHTTPClientDelegate<NSObject>

- (void)GuluGeneralHTTPClientSuccessed:(id)sender info:(id)info;
- (void)GuluGeneralHTTPClientFailed:(id)sender error:(NSError *)error;

@end


@interface GuluGeneralHTTPClient : NSObject
{
    ASIFormDataRequest *request;
    id <GuluGeneralHTTPClientDelegate> delegate;
    id returnObject;
    BOOL isRequestRuinning;
    
    //=======================================
    
   // id target;
    SEL finishSelector;
    SEL failSelector;
    
    //===== in order to tag this request =====
    
    NSString    *tagString; 
    NSInteger   tag;
    NSIndexPath *tagIndexPath;
    id tagObject;
    id target;
}

@property(nonatomic,assign)id<GuluGeneralHTTPClientDelegate> delegate;
@property(nonatomic,retain)ASIFormDataRequest *request;
@property(nonatomic,retain)id returnObject;
@property(nonatomic) BOOL isRequestRuinning;
@property(nonatomic,retain)  NSString *tagString; 
@property(nonatomic)  NSInteger tag; 
@property(nonatomic,retain)NSIndexPath *tagIndexPath;
@property(nonatomic,retain)id tagObject;

@property(assign)id target;
@property(assign)SEL finishSelector;
@property(assign)SEL failSelector;

-(void)createRequest :(NSString *)URLStr info:(NSMutableDictionary *)dict;
-(void)startRequest;
-(void)cancelRequest;
 
 

@end
