//
//  GuluTableViewCell.m
//  GULUAPP
//
//  Created by alan on 11/9/16.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluTableViewCell.h"

@implementation GuluTableViewCell

@synthesize  isReusedCell;

-(void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)layoutSubviews
{
    [super layoutSubviews];    
}

- (void)setHighlighted: (BOOL)highlighted animated: (BOOL)animated
{
	[super setHighlighted:highlighted animated:animated];
}

- (void)setSelected: (BOOL)selected animated: (BOOL)animated 
{
	[super setSelected:selected animated:animated];
}


- (void)dealloc {
    [super dealloc];
    
}


#pragma mark -
#pragma mark cell

+ (id)cellForIdentifierOfTable :(NSString *)cellClassName  table:(UITableView *)theTable  
{
    NSString *cellIdentifier = cellClassName;
    Class CellClass = NSClassFromString(cellClassName);
    
	UITableViewCell * cell =  (UITableViewCell *)[theTable dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil  && [CellClass isSubclassOfClass:[UITableViewCell class]]) {
        cell=[[[CellClass alloc] initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:cellIdentifier] autorelease];
        ((GuluTableViewCell *)cell).isReusedCell=NO;
    }
    else{
        ((GuluTableViewCell *)cell).isReusedCell=YES;
    }
    
    return cell;
}


+ (id)cellForIdentifierOfTableFromNib :(NSString *)cellClassName  table:(UITableView *)theTable  
{
    NSString *cellIdentifier = cellClassName;
    NSString *nibNamed = cellClassName;
    Class CellClass = NSClassFromString(cellClassName);
    
	UITableViewCell * cell =  (UITableViewCell *)[theTable dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil  && [CellClass isSubclassOfClass:[UITableViewCell class]]) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNamed owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell=currentObject;
                [cell initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:cellIdentifier];
                ((GuluTableViewCell *)cell).isReusedCell=NO;
            }
        }
    }
    else{
        ((GuluTableViewCell *)cell).isReusedCell=YES;
    }
    
    return cell;
}


@end

