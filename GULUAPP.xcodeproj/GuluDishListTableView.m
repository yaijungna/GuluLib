//
//  GuluDishListTableView.m
//  GULUAPP
//
//  Created by alan on 11/9/22.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluDishListTableView.h"

@implementation GuluDishListTableView

@synthesize userLocation;

- (id)initWithFrame:(CGRect)frame pullToRefresh:(BOOL)refresh
{
    self = [super initWithFrame:frame pullToRefresh:refresh];
    if (self) {
        
        self.delegate=self;
        self.dataSource=self;
        
    }
    return self;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    NSString *cellClassStr = @"GuluTableViewCell_Image_Twoline";
    
    GuluTableViewCell_Image_Twoline *cell = [GuluTableViewCell cellForIdentifierOfTable:cellClassStr table:tableView];
    cell.tag=indexPath.row;
    
    GuluDishModel *dish=[tableArray objectAtIndex:indexPath.row];
    GuluPlaceModel *place=dish.restaurant;
    
    CLLocation *Location = [[[CLLocation alloc] initWithLatitude:place.latitude longitude:place.longitude] autorelease]; 
    float d=[GuluUtility calculateDistance:userLocation destination:Location];
    
    cell.label1.text=[NSString stringWithFormat:@"%@ @ %@",dish.name,place.name];
    cell.label2.text=[NSString stringWithFormat: @"%.2f km",d];
    
    NSString *url_key=dish.photo.image_small;
    [cell.leftImageview setImageWithURL:[NSURL URLWithString:url_key]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)dealloc {
	
    [userLocation release];
    [super dealloc];
}


@end
