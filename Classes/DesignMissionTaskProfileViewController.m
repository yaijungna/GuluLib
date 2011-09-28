//
//  DesignMissionTaskProfileViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/30.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "DesignMissionTaskProfileViewController.h"

#import "MissionSummaryViewController.h"


@implementation DesignMissionTaskProfileViewController


- (void)showData
{
    [self shareGULUAPP];
    taskObj=appDelegate.temp.taskObj;
    missionObj=appDelegate.temp.missionObj;
    
    if(missionObj.missionType == TreasureHuntMissionType )
    {

        aboutLabel.text=NSLocalizedString(@"Give a hint or clue for this Treasure Hunt Task.", @"[treasure hunt]");
        
        NSString *dishName=[taskObj.dishDict objectForKey:@"name"];
        NSString *restaurantName=[taskObj.restaurantDict objectForKey:@"name"];
        
        if(dishName==nil)
        {
            dishName=@"";
        }
        
        
        titleTextField.text=[NSString stringWithFormat:@"%@ @ %@",dishName ,restaurantName];
        
        placenameLabel.text=restaurantName;
        dishnameLabel.text=dishName;

    }
    else 
    {
        aboutLabel.text=NSLocalizedString(@"Anything you want to say about this task.", @"[mission]");
        
        
        showdishLabel.hidden=YES;
        showplaceLabel.hidden=YES;
        
        placeSwitcher.hidden=YES;
        dishSwitcher.hidden=YES;
        
        NSString *dishName=[taskObj.dishDict objectForKey:@"name"];
        NSString *restaurantName=[taskObj.restaurantDict objectForKey:@"name"];
        
        if(dishName==nil)
        {
            dishName=@"";
        }
        
        titleTextField.text=[NSString stringWithFormat:@"%@ @ %@",dishName ,restaurantName];
        
        placenameLabel.text=restaurantName;
        dishnameLabel.text=dishName;
    }
    
    //==============================
    
    if(missionObj.missionType == FoodGuideMissionType)
    {
        taskObj.photoDict=[taskObj.restaurantDict objectForKey:@"photo"] ;
        
        imageLoader=[[ACImageLoader alloc] init];
        imageLoader.delegate=self;
        imageLoader.URLStr=[[taskObj.restaurantDict objectForKey:@"photo"] objectForKey:@"image_medium"];
        [imageLoader startDownload];
    }
    
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    
    topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeBack
                                                                                      middle:ButtonTypeGuluLogo 
                                                                                       right:ButtonTypeDone];
	[self.view addSubview:topView];
	[topView release];
    
    [topView.topLeftButton	addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topMiddleButton addTarget:self action:@selector(landingAction) forControlEvents:UIControlEventTouchUpInside];
    
    [topView.topRightButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    
    //================================================
    
    [self customizeTextField:titleTextField];
    [self customizeLabel_title:aboutLabel];
    
    aboutLabel.text=@"Give a hint";
    
    [self customizeTextView:aboutTextView];
    
    photobg.backgroundColor=TEXT_COLOR;
    photobg.alpha=0.2;
    photobg.layer.cornerRadius=5.0;
    
    photoLabel.text=NSLocalizedString(@"Change Photo", @"[design mission]");
    [self customizeLabel:photoLabel];
    photoLabel.textColor=[UIColor grayColor];
    photoLabel.textAlignment=UITextAlignmentCenter;
    
    [photoButton addTarget:self action:@selector(gotoCamera) forControlEvents:UIControlEventTouchUpInside];

    
    [self customizeLabel_title:placeLabel];
    [self customizeLabel_title:dishLabel];
    placeLabel.text=NSLocalizedString(@"Place:", @"[task place]");
    dishLabel.text=NSLocalizedString(@"Dish:", @"[task dish]");
    
    [self customizeLabel:placenameLabel];
    [self customizeLabel:dishnameLabel];
    
    placenameLabel.text=@"place";
    dishnameLabel.text=@"dish";
    
    [self customizeLabel_title: showplaceLabel];
    [self customizeLabel_title: showdishLabel];
    
    showplaceLabel.text=NSLocalizedString(@"Show place to challengers?", @"[task]");
    showdishLabel.text=NSLocalizedString(@"Show dish to challengers?", @"[task]");
    
    [self showData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}


- (void)dealloc
{
    [super dealloc];
}


#pragma mark ACImageDidLoad Delegate and Function Methods

- (void)ACImageDidLoad:(ACImageLoader *)imageloader
{
	if (imageloader.image != nil)
	{
		[photoButton setBackgroundImage:imageloader.image forState:UIControlStateNormal];
        taskObj.taskPhoto=imageloader.image;
	}	 
}



#pragma mark -
#pragma mark camera Function Methods

- (void)gotoCamera
{
	imagePicker =[ACCameraViewController sharedManager];
	imagePicker.ACDelegate=self;
	[self presentModalViewController:imagePicker animated:NO];
}

- (void)ACCameraViewControllerDelegateDidFinishPickingImage:(UIImage *)image
{
	[self dismissModalViewControllerAnimated:NO];
	
    taskObj.taskPhoto =image;
    taskObj.isChangePhoto=YES;
    taskObj.photoDict=nil;
    
    [photoButton setBackgroundImage:image forState:UIControlStateNormal];
	
    
}

- (void)ACCameraViewControllerDelegateCancelImagePicker
{
    [self dismissModalViewControllerAnimated:NO];
}


#pragma mark -
#pragma mark action Function Methods

- (void)backAction 
{
    [imageLoader cancelDownload];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)landingAction 
{
    [imageLoader cancelDownload];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)nextAction
{
    if(! [self checkFieldIsCorrect])
        return;
    
    NSString *taskName=titleTextField.text;
    NSString *taskAbout=aboutTextView.text;
    
    if(taskName==nil)
    {
        taskName=@"";
    }
    
    if(taskAbout==nil)
    {
        taskAbout=@"";
    }
    
    
    //=================================================
    if(appDelegate.temp.missionObj.taskArray==nil)
        appDelegate.temp.missionObj.taskArray=[[[NSMutableArray alloc] init] autorelease];
    
    
    if(missionObj.missionType == TreasureHuntMissionType )
    {
        taskObj.taskTitle=taskName;
        taskObj.taskAbout=taskAbout;
        taskObj.showDish=[NSString stringWithFormat:@"%d",dishSwitcher.on];
        taskObj.showPlace=[NSString stringWithFormat:@"%d",placeSwitcher.on];
        
        [appDelegate.temp.missionObj.taskArray addObject:taskObj];

    }
    else 
    {
        taskObj.taskTitle=taskName;
        taskObj.taskAbout=taskAbout;
        
        [appDelegate.temp.missionObj.taskArray addObject:taskObj];
    }
    
    //=================================================
    
    
   // NSLog(@"%@",missionObj);
    //NSLog(@"%d",missionObj.missionType);
    

    NSArray *subviewsArray=[self.navigationController viewControllers];    
    
    for(id viewController in  subviewsArray)
    {
        if([viewController isKindOfClass:[MissionSummaryViewController class]])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"addTaskNotification" object:taskObj];
            [self.navigationController popToViewController:viewController animated:YES]; 
             return;
        }
    }

    
    MissionSummaryViewController *VC=[[MissionSummaryViewController alloc] 
                                      initWithNibName:@"MissionSummaryViewController" 
                                      bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];
    
}


#pragma mark -
#pragma mark TextField Delegate Function Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

	return NO;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	if ([text isEqual:@"\n"]) {
		[textView resignFirstResponder];
		
        return NO;
	}
	return YES;
}

#pragma mark -
#pragma mark check Function Methods

-(BOOL)checkFieldIsCorrect
{
    
    if(titleTextField.text==nil ||[titleTextField.text isEqualToString:@""])
    {
        [self showWarningAlert:NSLocalizedString(@"Task name is required.", @"error message")];   
        return NO;
    }
    
    if(aboutTextView.text==nil ||[aboutTextView.text isEqualToString:@""])
    {
        [self showWarningAlert:NSLocalizedString(@"Task about is required.", @"error message")];   
        return NO;
    }
    
    if(missionObj.missionType != FoodGuideMissionType)
    {
        if(taskObj.taskPhoto==nil )
        {
            [self showWarningAlert:NSLocalizedString(@"Task photo is required.", @"error message")];   
            return NO;
        }
    }
    
    
	return YES;
}






@end
