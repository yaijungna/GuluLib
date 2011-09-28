//
//  inviteModel.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/22.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface inviteModel : NSObject {
	
	NSString *eid;
	NSMutableDictionary *restaurantDict;
	NSString *dateString;
	NSString *EventTitle;
	NSMutableDictionary *contactDict;
}
@property(nonatomic,retain) NSString *eid;
@property(nonatomic,retain) NSMutableDictionary *restaurantDict;
@property(nonatomic,retain) NSString *dateString;
@property(nonatomic,retain) NSString *EventTitle;
@property(nonatomic,retain) NSMutableDictionary *contactDict;

@end
