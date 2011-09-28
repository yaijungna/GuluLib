//
//  UIViewControllerAddtion_Connection_Post.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerAddtion.h"
#import "ACNetworkManager.h"
#import "API_URL_POST.h"
#import "postModel.h"

@interface UIViewController(MyAdditions_post)

-(void)uploadPhotoConnection:(ACNetworkManager *)net  
				   imageData:(NSData *)imagedata;

-(void)bestKnownForConnection:(ACNetworkManager *)net  
					   serial:(NSString *)serial;

- (void)creatNewRestaurant :(ACNetworkManager *)net 
                 restaurant:(NSMutableDictionary *)restaurantDict 
                   photo_id:(NSString *)pid;

- (void)submitReview:(ACNetworkManager *)net 
           postModel:(postModel *)post
             isThumb:(NSString *)isThumb
      isGuluapproved:(NSString *)isGuluapproved;



@end
