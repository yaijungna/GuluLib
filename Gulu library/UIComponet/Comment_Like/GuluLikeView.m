//
//  GuluLikeView.m
//  GULUAPP
//
//  Created by alan on 11/9/21.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluLikeView.h"
#import "UILabel+Custom.h"

@implementation GuluLikeView

@synthesize starImageView;
@synthesize likeStringLabel;
@synthesize likeButton;

@synthesize numOfLike;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        starImageView=[[UIImageView alloc] init];
        likeStringLabel=[[UILabel alloc] init];
        likeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [likeStringLabel customizeLabelToGuluStyle];
        
        [self addSubview:starImageView];
        [self addSubview:likeStringLabel];
        [self addSubview:likeButton];
    }
    
    return self;
}


- (void)dealloc {
	[starImageView release];
    [likeStringLabel release];
	
    [super dealloc];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    float w=frame.size.width;
    float h=frame.size.height;
    
    likeButton.frame=CGRectMake(0, 0, w, h);
    starImageView.frame=CGRectMake(0, 2, h-2, h-2);
    likeStringLabel.frame=CGRectMake(h+5, 0, w-h-5, h);
}

- (void)setNumOfLike:(NSInteger)NumOfLike {
    numOfLike=NumOfLike;
    
    UIImage *likeImage=[UIImage imageNamed:@"like-star-1.png"];
    UIImage *unLikeImage=[UIImage imageNamed:@"like-star-2.png"];
    
    if(numOfLike==0){
        starImageView.image=unLikeImage;
    }
    else if(numOfLike>0){
        starImageView.image=likeImage;
    }
    else{
        numOfLike=0;
    }
    
    likeStringLabel.text=[NSString stringWithFormat:@"%d %@",numOfLike,NSLocalizedString(@"Likes",@"Likes")];

}

@end
