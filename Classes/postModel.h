//
//  postModel.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/9.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PostDataModel.h"

#import "GuluGeneralHTTPClient.h"
#import "GuluPostImage.h"
#import "GuluCreateNewPlace.h"


@protocol PostDelegate

- (void)postSuccessed:(id)sender info:(id)info;
- (void)postFailed:(id)sender error:(NSError *)error;

@end

typedef enum {
	postImageStep,
	createPlaceStep,
	submitReviewStep,
}PostStep;


@interface postModel : NSObject <GuluGeneralHTTPClientDelegate> {
	UIImage *photo;
	NSMutableDictionary *restaurantDict;
	NSMutableDictionary *dishDict;
	NSMutableDictionary *photoDict;
	NSString *review;
	NSString *bestKnownFor;
    
	NSString *todoid;
    NSString *taskid;
    NSString *groupid;
    
    NSInteger isThumb ;  // up:1  down:-1  noChose:0
    BOOL isGuluapproved ;
    
    //============================
    
    BOOL isSubmitStart; 
    
    PostStep step;
    
    GuluGeneralHTTPClient *submitReview;
    GuluGeneralHTTPClient *deleteTodo;
    GuluPostImage *submitPhoto;
    GuluCreateNewPlace *createPlace;
    
    id<PostDelegate>delegate;
    
    //============================
    
    PostDataModel *dataModel;
    
}


@property(nonatomic,retain) UIImage *photo;
@property(nonatomic,retain) NSMutableDictionary *restaurantDict;
@property(nonatomic,retain) NSMutableDictionary *dishDict;
@property(nonatomic,retain) NSMutableDictionary *photoDict;
@property(nonatomic,retain) NSString *review;
@property(nonatomic,retain) NSString *bestKnownFor;

@property(nonatomic,retain) NSString *todoid;
@property(nonatomic,retain) NSString *taskid;
@property(nonatomic,retain) NSString *groupid;

@property(nonatomic)NSInteger isThumb ;
@property(nonatomic)BOOL isGuluapproved ;

@property(nonatomic)PostStep step;
@property(nonatomic,retain)GuluGeneralHTTPClient *submitReview;
@property(nonatomic,retain)GuluGeneralHTTPClient *deleteTodo;
@property(nonatomic,retain)GuluPostImage *submitPhoto;
@property(nonatomic,retain)GuluCreateNewPlace *createPlace;

@property(nonatomic,assign)id<PostDelegate>delegate;

@property(nonatomic)BOOL isSubmitStart; 

@property(nonatomic,retain)PostDataModel *dataModel;

- (void)submit;
- (void)submitPhotoStart;
//- (void)submitReviewStart; // should not call by outside  directly
//- (void)createPlaceStart; //should not call by outside directly

- (void)save;
- (void)removeFromBD;
- (void)importDataModel:(PostDataModel *)postdata; 


@end
