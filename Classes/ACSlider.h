//
//  ACSlider.h
//  GULUAPP
//
//  Created by chen alan on 2011/6/9.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ACSliderDelegate

-(void)slideToEndAction;

@end


@interface ACSlider : UISlider {
	id <ACSliderDelegate> delegate;
	UIImageView *arrowImageView;
	UILabel *sliderLabel;
}

@property(nonatomic,retain) id <ACSliderDelegate> delegate;


@end
