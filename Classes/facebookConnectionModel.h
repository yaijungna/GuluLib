//
//  facebookConnectionModel.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/14.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACNetworkManager.h"
#import "API_URL_USER.h"

@protocol facebookDelegate

-(void)facebookGetTokenSuccess;
-(void)facebookGetTokenFail;

@end



@interface facebookConnectionModel : NSObject {
	id<facebookDelegate> delegate;
	NSString *fbToken;
	NSString *urlString;
	
	ACNetworkManager *network;

}

- (void) getFBRandomToken;
- (void) cancelGetFBRandomToken;

@property (nonatomic,assign)	id<facebookDelegate> delegate;
@property (nonatomic,retain)	NSString *fbToken;
@property (nonatomic,retain)	NSString *urlString;

@end
