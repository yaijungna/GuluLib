//
//  GuluTableViewCell_BigPhoto.m
//  GULUAPP
//
//  Created by alan on 11/9/21.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluTableViewCell_BigPhoto.h"

@implementation GuluTableViewCell_BigPhoto

@synthesize bigImageview;
@synthesize Btn1;
@synthesize Btn2;
@synthesize contentLabel;
@synthesize  atLabel;
@synthesize viewForMore;
@synthesize likeView;
@synthesize commentView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        bigImageview=[[UIImageView alloc] init];
        Btn1=[UIButton buttonWithType:UIButtonTypeCustom];
        Btn2=[UIButton buttonWithType:UIButtonTypeCustom];
        contentLabel=[[UILabel alloc] init];
        likeView=[[GuluLikeView alloc] init];
        commentView=[[GuluCommentsNumberView alloc] init];
        atLabel =[[UILabel alloc] init] ;
        
        [contentLabel customizeLabelToGuluStyle];
        bigImageview.backgroundColor=[UIColor lightGrayColor];
        
        [Btn1 customizeLabelToGuluStyle];
        [Btn2 customizeLabelToGuluStyle];
        
        [atLabel customizeLabelToGuluStyle];
        atLabel.font=[UIFont fontWithName:LibraryTextFontName size:LibraryTextMediumSize];
        atLabel.text=@"@";

        [self.contentView addSubview:bigImageview];
        [self.contentView addSubview:Btn1];
        [self.contentView addSubview:Btn2];
        [self.contentView addSubview:contentLabel];
        [self.contentView addSubview:likeView];
        [self.contentView addSubview:commentView];
        [self.contentView addSubview:atLabel];

	}
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    CGRect contentRect = self.contentView.bounds;
//    CGPoint centerPoint = self.contentView.center;
    
    float interval1=20.0;
    float interval2=5.0;
    
    CGSize bigImageSize=CGSizeMake(280, 280);
    CGSize contentSize=CGSizeMake(300, 300);
    CGSize btnSize=CGSizeMake(300, 20);
    CGSize atLabelSize=CGSizeMake(20, 20);
    CGSize likeSize=CGSizeMake(100, 20);
    CGSize commentSize=CGSizeMake(150, 20);
    CGSize constrainSize=CGSizeMake(300, 10000);
    
    //=======
    
    CGRect imageViewRect = CGRectMake(interval1, interval2 , bigImageSize.width, bigImageSize.height);  
    bigImageview.frame=imageViewRect;
    
    CGSize btn1Size=[Btn1 dynamicSizeOfText:btnSize];
    CGSize btn2Size=[Btn2 dynamicSizeOfText:btnSize];
    
    atLabelSize=CGSizeMake([atLabel dynamicSizeOfText:atLabelSize].width, atLabelSize.height);
    
    float btnOriginY=bigImageview.frame.size.height+ bigImageview.frame.origin.y;

    if(btn1Size.width + btn2Size.width >constrainSize.width)  //    2 lines
    {
        Btn1.frame=CGRectMake(interval2, 
                              btnOriginY,
                              btn1Size.width,
                              btnSize.height);
        
        atLabel.frame=CGRectMake(interval2, 
                                 btnOriginY+Btn1.frame.size.height, 
                                 atLabelSize.width, 
                                 atLabelSize.height);
        
        Btn2.frame=CGRectMake(atLabel.frame.origin.x+atLabel.frame.size.width, 
                              btnOriginY+Btn1.frame.size.height,
                              btn2Size.width,
                              btnSize.height);

    }
    else  //1 line
    {
        Btn1.frame=CGRectMake(interval2, 
                              btnOriginY,
                              btn1Size.width,
                              btnSize.height);
        
        atLabel.frame=CGRectMake(Btn1.frame.origin.x+Btn1.frame.size.width, 
                                 btnOriginY, 
                                 atLabelSize.width, 
                                 atLabelSize.height);
        
        Btn2.frame=CGRectMake(atLabel.frame.origin.x+atLabel.frame.size.width, 
                              btnOriginY,
                              btn2Size.width,
                              btnSize.height);
    }
    
    contentLabel.frame= CGRectMake(interval2, 
                                    Btn2.frame.origin.y+Btn2.frame.size.height ,
                                    contentSize.width, 
                                    [contentLabel dynamicSizeOfText:constrainSize].height);  

    likeView.frame=CGRectMake(interval2, contentLabel.frame.origin.y+contentLabel.frame.size.height+interval2, likeSize.width, likeSize.height);
    commentView.frame=CGRectMake(likeView.frame.origin.x + likeView.frame.size.width, 
                                 contentLabel.frame.origin.y+contentLabel.frame.size.height+interval2, 
                                 commentSize.width,
                                 commentSize.height);

}

- (void)dealloc {
    [bigImageview release];
    [Btn1 release];
    [Btn2 release];
	[contentLabel release];
    [atLabel release];
    [viewForMore release];
    
    [likeView release];
    [commentView release];
	
    [super dealloc];
}


@end

