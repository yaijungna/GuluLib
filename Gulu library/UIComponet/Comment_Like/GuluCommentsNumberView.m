//
//  GuluCommentsNumberView.m
//  GULUAPP
//
//  Created by alan on 11/9/21.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluCommentsNumberView.h"
#import "UILabel+Custom.h"

@implementation GuluCommentsNumberView

@synthesize commentImageView;
@synthesize commentStringLabel;
@synthesize commentButton;

@synthesize numOfComment;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        commentImageView=[[UIImageView alloc] init];
        commentStringLabel=[[UILabel alloc] init];
        commentButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [commentStringLabel customizeLabelToGuluStyle];
        
        [self addSubview:commentImageView];
        [self addSubview:commentStringLabel];
        [self addSubview:commentButton];    }
    
    return self;
}

- (void)dealloc {
	[commentImageView release];
    [commentStringLabel release];
	
    [super dealloc];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    float w=frame.size.width;
    float h=frame.size.height;
    
    commentButton.frame=CGRectMake(0, 0, w, h);
    commentImageView.frame=CGRectMake(0, 2, 2*(h-2), h-2);
    commentStringLabel.frame=CGRectMake(2*(h-2)+5, 0, w-h-5, h);
}


-(void)setNumOfComment:(NSInteger)NumOfComment
{
    numOfComment=NumOfComment;
    UIImage *commentImage=[UIImage imageNamed:@"comment-bubble-1.png"];
    UIImage *unCommentImage=[UIImage imageNamed:@"comment-bubble-2.png"];
    
    if(numOfComment==0){
        commentImageView.image=unCommentImage;
    }
    else if(numOfComment>0){
        commentImageView.image=commentImage;
    }
    else{
        numOfComment=0;
    }
    commentStringLabel.text=[NSString stringWithFormat:@"%d %@",numOfComment,NSLocalizedString(@"Comments",@"Comments")];

}




@end
