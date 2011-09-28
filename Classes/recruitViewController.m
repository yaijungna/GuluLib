//
//  recruitViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/7/8.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "recruitViewController.h"

@implementation recruitViewController

@synthesize  missionDict;

- (void)recruitPeople
{

    [self showSpinnerView:LoadingView mesage:GLOBAL_LOADING_STRING];
   
    NSMutableArray *array=[NSMutableArray arrayWithArray:[chosedDict allValues]];
    NSString *mid=[missionDict objectForKey:@"id"];
    
    [self sendRecruitMissionConnection:network missionID:mid guluListArray:array];
}

- (void)nextAction 
{
    if([chosedDict count]==0)
        return;
    
    [self recruitPeople];

}


-(void)ACConnectionSuccess:(ASIFormDataRequest *)request;
{
    [super ACConnectionSuccess:request];
    
    [self hideSpinnerView:LoadingView];	
	
	NSData *data1= [request responseData];
	NSError *derror;
	CJSONDeserializer *djsonDeserializer = [CJSONDeserializer deserializer];
	id temp=[djsonDeserializer deserialize:data1 error:&derror];
    
	NSLog(@"temp %@",temp);
    
    
    if( [[request.additionDataDictionary objectForKey:@"id"] isEqualToString:@"sendrecruit"])
	{
//        if([temp count]!=0)
//        {
            [self showOKAlert:NSLocalizedString(@"Recruit people ok", @"[mission]")];
            [self.navigationController popViewControllerAnimated:YES];
       /* }
        else 
        {
            [self showErrorAlert:GLOBAL_ERROR_STRING];
          
        }*/
	}
     
    
}

-(void)ACConnectionFailed:(ASIFormDataRequest *)request
{
    [super ACConnectionFailed:request];
    
}



- (void)dealloc {
    
    [missionDict release];
    [super dealloc];
}







@end
