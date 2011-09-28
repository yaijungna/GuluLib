//
//  DesignMissionProfileViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/29.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "DesignMissionProfileViewController.h"

#import "DesignMissionTaskProfileViewController.h"
#import "pickPlaceDishViewController.h"
#import "pickChallengersViewController.h"




@implementation DesignMissionProfileViewController

@synthesize deadline_1;
@synthesize deadline_3;


- (void)showData
{
    [self shareGULUAPP];
    missionObj=appDelegate.temp.missionObj;
    
    if(missionObj.missionType == FoodGuideMissionType || missionObj.missionType == TreasureHuntMissionType )
    {
        dateView.hidden=YES;
        privateDateView.hidden=YES;
    }
    else if(missionObj.missionType == DareMissiontype)
    {
        dateView.hidden=YES;
        challengerLabel.hidden=YES;
        challengerTextField.hidden=YES;
        privateDateView.hidden=YES;
    }
    else if(missionObj.missionType == TimeCriticalMissionType )
    {
        [self tapButton:checkBox1];
        privateDateView.hidden=YES;
        
    }
    else if(missionObj.missionType == PrivateGroupMissionType)
    {
        dateView.hidden=YES;
        [dateView removeFromSuperview];

    }
    
    //=======================================
    
    UIImage *FoodGuideImage=[UIImage imageNamed:@"food-guide-icon-1.png"];
    UIImage *DareImage=[UIImage imageNamed:@"dare-mission-icon-1.png"];
    UIImage *TreasureImage=[UIImage imageNamed:@"treasure-hunt-icon-1.png"];
    UIImage *TimeImage=[UIImage imageNamed:@"time-critical-mission-icon-1.png"];
    UIImage *PrivateImage=[UIImage imageNamed:@"private-group-mission-icon-1.png"];
    
    if(missionObj.missionType == FoodGuideMissionType  )
    {
        nameLabel.text=NSLocalizedString(@"Name your Food Guide Mission", @"[design mission]");
        challengerTextField.text=@"0";
        [photoButton setBackgroundImage:FoodGuideImage forState:UIControlStateNormal];
        missionObj.missionPhoto=FoodGuideImage;
    }
    else if(missionObj.missionType == DareMissiontype)
    {
        nameLabel.text=NSLocalizedString(@"Name your Dare Mission Mission", @"[design mission]");
        challengerTextField.text=@"0";
        [photoButton setBackgroundImage:DareImage forState:UIControlStateNormal];
        missionObj.missionPhoto=DareImage;
    }
    else if(missionObj.missionType == TimeCriticalMissionType )
    {
        nameLabel.text=NSLocalizedString(@"Name your Time Critical Mission", @"[design mission]");
        challengerTextField.text=@"50";
        [photoButton setBackgroundImage:TimeImage forState:UIControlStateNormal];
        missionObj.missionPhoto=TimeImage;
    }
    else if(missionObj.missionType == PrivateGroupMissionType)
    {
        nameLabel.text=NSLocalizedString(@"Name your Private Group Mission", @"[design mission]");
        challengerTextField.text=@"0";
        [photoButton setBackgroundImage:PrivateImage forState:UIControlStateNormal];
        missionObj.missionPhoto=PrivateImage;
    }
    else if(missionObj.missionType == TreasureHuntMissionType)
    {
        nameLabel.text=NSLocalizedString(@"Name your Treasure Hunt Mission", @"[design mission]");
        challengerTextField.text=@"50";
        [photoButton setBackgroundImage:TreasureImage forState:UIControlStateNormal];
        missionObj.missionPhoto=TreasureImage;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeCancel
                                                                                      middle:ButtonTypeGuluLogo 
                                                                                       right:ButtonTypeNext];
	[myView addSubview:topView];
	[topView release];
    
    [topView.topLeftButton	addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topMiddleButton addTarget:self action:@selector(landingAction) forControlEvents:UIControlEventTouchUpInside];
    
    [topView.topRightButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];


    //================================================
    
    nameLabel.text=@"";
    aboutLabel.text=NSLocalizedString(@"What is this Mission about?", @"[design mission]");
    
    [self customizeLabel:nameLabel];
    [self customizeLabel:aboutLabel];
    
    titleTextField.placeholder=NSLocalizedString(@"Mission Title", @"[design mission]");
  
    [self customizeTextField:titleTextField];
    [self customizeTextView:aboutTextView];
    aboutTextView.text=@"";
    
    photobg.backgroundColor=TEXT_COLOR;
    photobg.alpha=0.2;
    photobg.layer.cornerRadius=5.0;
    
    [photoButton setBackgroundImage:[UIImage imageNamed:@"+Badge-icon-1.png"] forState:UIControlStateNormal];
    
    [photoButton addTarget:self action:@selector(gotoCamera) forControlEvents:UIControlEventTouchUpInside];
    
    photoLabel.text=NSLocalizedString(@"+Photo for badge", @"[design mission]");
    [self customizeLabel:photoLabel];
    photoLabel.font=[UIFont fontWithName:FONT_NORMAL size:10];
    photoLabel.textColor=[UIColor grayColor];
    
    
    challengerLabel.text=NSLocalizedString(@"How many challengers to grade?", @"[design mission]");
    [self customizeLabel:challengerLabel];
    
    challengerTextField.placeholder=@"0";
    [self customizeTextField:challengerTextField];

    //================================================    
    
    [checkBox1 setBackgroundImage:[UIImage imageNamed:@"unselected-bubble-1.png"] forState:UIControlStateNormal];
    [checkBox1 setBackgroundImage:[UIImage imageNamed:@"selected-bubble-1.png"] forState:UIControlStateSelected];
    [checkBox1 addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [checkBox2 setBackgroundImage:[UIImage imageNamed:@"unselected-bubble-1.png"] forState:UIControlStateNormal];
    [checkBox2 setBackgroundImage:[UIImage imageNamed:@"selected-bubble-1.png"] forState:UIControlStateSelected];
    [checkBox2 addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [checkBox3 setBackgroundImage:[UIImage imageNamed:@"unselected-bubble-1.png"] forState:UIControlStateNormal];
    [checkBox3 setBackgroundImage:[UIImage imageNamed:@"selected-bubble-1.png"] forState:UIControlStateSelected];
    [checkBox3 addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    option1Label.text=NSLocalizedString(@"1.Deadline:", @"[design mission]");
    
    option2_1_Label.text=NSLocalizedString(@"2.Complete from start to finish in", @"[design mission]");
    option2_2_Label.text=NSLocalizedString(@"hours.", @"[design mission]");
    
    option3_1_Label.text=NSLocalizedString(@"3.Deadline:", @"[design mission]");
    option3_2_Label.text=NSLocalizedString(@"&", @"[design mission]");
    option3_3_Label.text=NSLocalizedString(@"Complete from start to finish in", @"[design mission]");
    option3_4_Label.text=NSLocalizedString(@"hours.", @"[design mission]");
    
    [self customizeLabel:option1Label];
    [self customizeLabel:option2_1_Label];
    [self customizeLabel:option2_2_Label];
    [self customizeLabel:option3_1_Label];
    [self customizeLabel:option3_2_Label];
    [self customizeLabel:option3_3_Label];
    [self customizeLabel:option3_4_Label];
    
    [self customizeTextField:option1TextField];
    [self customizeTextField:option2TextField];
    [self customizeTextField:option3_1_TextField];
    [self customizeTextField:option3_2_TextField];
    
    option1TextField.placeholder=NSLocalizedString(@"Select a date.", @"[design mission]");
    option2TextField.placeholder=NSLocalizedString(@"Select a number.", @"[design mission]");
    option3_1_TextField.placeholder=NSLocalizedString(@"Select a date.", @"[design mission]");
    option3_2_TextField.placeholder=NSLocalizedString(@"Select a number.", @"[design mission]");
    
    datePickerDoneButton=[ACCreateButtonClass createButton:ButtonTypeDone];
    [datePickerBg addSubview:datePickerDoneButton];
    [datePickerDoneButton setFrame:CGRectMake(250, 7,
                                              datePickerDoneButton.frame.size.width,
                                              datePickerDoneButton.frame.size.height)];
    
    [datePickerDoneButton addTarget:self action:@selector(DateDoneAction) 
                   forControlEvents:UIControlEventTouchUpInside];
    
    //=======================================================
    
    
    startTimeLabel.text=NSLocalizedString(@"Start Time:", @"[design mission]");
    endTimeLabel.text=NSLocalizedString(@"Deadline:", @"[design mission]");
    
    startTimeTextField.placeholder=NSLocalizedString(@"Start Time", @"[design mission]");
    endTimeTextField.placeholder=NSLocalizedString(@"Deadline", @"[design mission]");
    
    [self customizeTextField:startTimeTextField];
    [self customizeTextField:endTimeTextField];
    
    [self customizeLabel:startTimeLabel];
    [self customizeLabel:endTimeLabel];
    
    datePickerDoneButton2=[ACCreateButtonClass createButton:ButtonTypeDone];
    [datePickerBg2 addSubview:datePickerDoneButton2];
    [datePickerDoneButton2 setFrame:CGRectMake(250, 7,
                                              datePickerDoneButton2.frame.size.width,
                                              datePickerDoneButton2.frame.size.height)];
    
    [datePickerDoneButton2 addTarget:self action:@selector(DateDoneAction2) 
                   forControlEvents:UIControlEventTouchUpInside];
    

   datePicker.date=[NSDate date];
   datePicker2.date=[NSDate date];
    
    //NSDate *right_now = [NSDate date];
    
    //datePicker.date=right_now;
   // datePicker2.date=right_now;
    
    
    [self showData];
    
   
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}


- (void)dealloc
{
    [deadline_1 release];
    [deadline_3 release];
     
    [super dealloc];
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
	
    missionObj.missionPhoto =image;
    
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)landingAction 
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)nextAction
{
    
   if(! [self checkFieldIsCorrect])
       return;
    

    NSString *missionName=titleTextField.text;
    NSString *missionAbout=aboutTextView.text;
    NSString *missionChallengerGrade=challengerTextField.text;
    
    if(missionName==nil)
    {
        missionName=@"";
    }
    
    if(missionAbout==nil)
    {
        missionAbout=@"";
    }
    
    if(missionChallengerGrade==nil)
    {
        missionChallengerGrade=@"";
    }
    
    
    //=================================================
    taskModel *obj=[[[taskModel alloc] init] autorelease];
    appDelegate.temp.taskObj=obj;
    
    if(missionObj.missionType == FoodGuideMissionType || 
       missionObj.missionType == TreasureHuntMissionType )
    {
        missionObj.missionTitle=missionName;
        missionObj.missionAbout=missionAbout;
        missionObj.numberOfChallengersToGrade=missionChallengerGrade;
        
        pickPlaceDishViewController *VC=[[pickPlaceDishViewController alloc] 
                                         initWithNibName:@"pickPlaceDishViewController" 
                                         bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
        
    }
    else if(missionObj.missionType == DareMissiontype)
    {
        
        missionObj.missionTitle=missionName;
        missionObj.missionAbout=missionAbout;
        
        pickChallengersViewController *VC=[[pickChallengersViewController alloc] 
                                         initWithNibName:@"pickChallengersViewController" 
                                         bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
        
    }
    else if(missionObj.missionType == TimeCriticalMissionType)
    {
        
        missionObj.missionTitle=missionName;
        missionObj.missionAbout=missionAbout;
        missionObj.numberOfChallengersToGrade=missionChallengerGrade;
        
        if(checkBox1.selected)
        {
            missionObj.deadLine=deadline_1;
        
        }
        if(checkBox2.selected)
        {
            missionObj.hours=option2TextField.text;
        }
        if(checkBox3.selected)
        {
            missionObj.deadLine=deadline_3;
            missionObj.hours=option3_2_TextField.text;
            
        }

        
        pickPlaceDishViewController *VC=[[pickPlaceDishViewController alloc] 
                                         initWithNibName:@"pickPlaceDishViewController" 
                                         bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
     
            
        
    }
    else if(missionObj.missionType == PrivateGroupMissionType)
    {
        missionObj.missionTitle=missionName;
        missionObj.missionAbout=missionAbout;
        missionObj.numberOfChallengersToGrade=missionChallengerGrade;
        
        
        pickChallengersViewController *VC=[[pickChallengersViewController alloc] 
                                           initWithNibName:@"pickChallengersViewController" 
                                           bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        [VC release];
        
        
    }
    

    
    //=================================================
    
}

- (void)PrivateViewUP 
{    
    [self moveTheView:myView movwToPosition:CGPointMake(0, -280)];
}

- (void)PrivateViewDown 
{    
    [self moveTheView:myView movwToPosition:CGPointMake(0, 0)];
}


- (void)datePickerViewUP 
{
    checkBox1.enabled=NO;
    checkBox2.enabled=NO;
    checkBox3.enabled=NO;
    
    if(checkBox1.selected)
    {
        checkBox1.enabled=YES;
    }
    if(checkBox2.selected)
    {
        checkBox2.enabled=YES;
    }
    if(checkBox3.selected)
    {
        checkBox3.enabled=YES;
    }
    
    
    [self moveTheView:myView movwToPosition:CGPointMake(0, -280)];
}

- (void)datePickerViewDown 
{
    [self moveTheView:myView movwToPosition:CGPointMake(0, 0)];
    
    checkBox1.enabled=YES;
    checkBox2.enabled=YES;
    checkBox3.enabled=YES;
    
}

- (void)DateDoneAction
{
    [self datePickerViewDown];

    if(checkBox1.selected)
    {
        option1TextField.text=[ACUtility dateStringToDateFormatString: [ACUtility nsdateTofloatString:[datePicker date]]];
        self.deadline_1=[ACUtility nsdateTofloatString:[datePicker date]];
    }
    if(checkBox3.selected)
    {
        option3_1_TextField.text=[ACUtility dateStringToDateFormatString: [ACUtility nsdateTofloatString:[datePicker date]]];
        self.deadline_3=[ACUtility nsdateTofloatString:[datePicker date]];
    }
    
    if(checkBox1.selected)
    {
        missionObj.deadLine=[ACUtility nsdateTofloatString:[datePicker date]];
        self.deadline_1=[ACUtility nsdateTofloatString:[datePicker date]];

    }
    if(checkBox2.selected)
    {
        missionObj.hours=option2TextField.text;
    }
    if(checkBox3.selected)
    {
        missionObj.deadLine=[ACUtility nsdateTofloatString:[datePicker date]];
        self.deadline_3=[ACUtility nsdateTofloatString:[datePicker date]];
        missionObj.hours=option3_2_TextField.text;
        
    }


}

- (void)DateDoneAction2
{
    [self PrivateViewDown];
    
    if(isStartOrDeadLine) //start
    {
        startTimeTextField.text=[ACUtility dateStringToDateFormatString: [ACUtility nsdateTofloatString:[datePicker2 date]]];
        
        missionObj.startTime=[ACUtility nsdateTofloatString:[datePicker2 date]];
        
    }
    
    if(!isStartOrDeadLine) //end
    {
        endTimeTextField.text=[ACUtility dateStringToDateFormatString: [ACUtility nsdateTofloatString:[datePicker2 date]]];
        
         missionObj.deadLine=[ACUtility nsdateTofloatString:[datePicker2 date]];;
    }
    
    
}


- (void)challengerUP 
{
    [self moveTheView:myView movwToPosition:CGPointMake(0, -30)];
}

- (void)hourUP 
{
    checkBox1.enabled=NO;
    checkBox2.enabled=NO;
    checkBox3.enabled=NO;
    
    if(checkBox1.selected)
    {
        checkBox1.enabled=YES;
    }
    if(checkBox2.selected)
    {
        checkBox2.enabled=YES;
    }
    if(checkBox3.selected)
    {
        checkBox3.enabled=YES;
    }

    
    [self moveTheView:myView movwToPosition:CGPointMake(0, -220)];
}


- (void)tapButton:(UIButton *) btn 
{
    checkBox1.selected=NO;
    checkBox2.selected=NO;
    checkBox3.selected=NO;
    
    btn.selected =YES;
    
    option1TextField.enabled=YES;
    option2TextField.enabled=YES;
    option3_1_TextField.enabled=YES;
    option3_2_TextField.enabled=YES;
    
    option1TextField.textColor=[UIColor lightGrayColor];
    option2TextField.textColor=[UIColor lightGrayColor];
    option3_1_TextField.textColor=[UIColor lightGrayColor];
    option3_2_TextField.textColor=[UIColor lightGrayColor];    
    
    if(btn==checkBox1)
    {
        option2TextField.enabled=NO;
        option3_1_TextField.enabled=NO;
        option3_2_TextField.enabled=NO;
        
        option1TextField.textColor=TEXT_COLOR;
        
        missionObj.deadLine=deadline_1;
    }
    if(btn==checkBox2)
    {
        option1TextField.enabled=NO;
        option3_1_TextField.enabled=NO;
        option3_2_TextField.enabled=NO;
        
        option2TextField.textColor=TEXT_COLOR;
        
        missionObj.hours=option2TextField.text;
        
    }
    if(btn==checkBox3)
    {
        option1TextField.enabled=NO;
        option2TextField.enabled=NO;
        
        option3_1_TextField.textColor=TEXT_COLOR;
        option3_2_TextField.textColor=TEXT_COLOR;
        
        missionObj.deadLine=deadline_3;
        missionObj.hours=option3_2_TextField.text;

    }
    
}


#pragma mark -
#pragma mark check Function Methods

-(BOOL)checkFieldIsCorrect
{
    
    if(titleTextField.text==nil ||[titleTextField.text isEqualToString:@""])
    {
        [self showWarningAlert:NSLocalizedString(@"Mission name is required.", @"error message")];   
        return NO;
    }
    
    if(aboutTextView.text==nil ||[aboutTextView.text isEqualToString:@""])
    {
        [self showWarningAlert:NSLocalizedString(@"Mission about is required.", @"error message")];   
          return NO;
    }
    
    if(missionObj.missionPhoto==nil )
    {
        [self showWarningAlert:NSLocalizedString(@"Mission photo is required.", @"error message")];   
          return NO;
    }
    
    
    //========================================

    if(missionObj.missionType == FoodGuideMissionType || missionObj.missionType == TreasureHuntMissionType )
    {
        if(challengerTextField.text==nil ||[challengerTextField.text isEqualToString:@""])
        {
            [self showWarningAlert:NSLocalizedString(@"Challengers is required.", @"error message")];   
            return NO;
        }
        
        if(![ACUtility isInteger:challengerTextField.text])
        {
            [self showWarningAlert:NSLocalizedString(@"Challengers needs to be a number.", @"error message")];   
            return NO;
        }
        
        
    }
    if(missionObj.missionType == DareMissiontype)
    {
        return YES;
    }
    if(missionObj.missionType == TimeCriticalMissionType)
    {
        
        if(challengerTextField.text==nil ||[challengerTextField.text isEqualToString:@""])
        {
            [self showWarningAlert:NSLocalizedString(@"Challengers is required.", @"error message")];   
            return NO;
        }
        
        if(![ACUtility isInteger:challengerTextField.text])
        {
            [self showWarningAlert:NSLocalizedString(@"Challengers needs to be a number.", @"error message")];   
            return NO;
        }
        
        
        if(checkBox1.selected)
        {
            if(option1TextField.text==nil ||[option1TextField.text isEqualToString:@""])
            {
                [self showWarningAlert:NSLocalizedString(@"Deadline is required.", @"error message")];   
                return NO;
            }
        }
        if(checkBox2.selected)
        {
            if(option2TextField.text==nil ||[option2TextField.text isEqualToString:@""])
            {
                [self showWarningAlert:NSLocalizedString(@"Hours is required.", @"error message")];   
                return NO;
            }
            
            if(![ACUtility isInteger:option2TextField.text])
            {
                [self showWarningAlert:NSLocalizedString(@"Hours needs to be a number.", @"error message")];   
                return NO;
            }

        }
       if(checkBox3.selected)
        {
            if(option3_1_TextField.text==nil ||[option3_1_TextField.text isEqualToString:@""])
            {
                [self showWarningAlert:NSLocalizedString(@"Deadline is required.", @"error message")];   
                return NO;
            }

            
            if(option3_2_TextField.text==nil ||[option3_2_TextField.text isEqualToString:@""])
            {
                [self showWarningAlert:NSLocalizedString(@"Hours is required.", @"error message")];   
                return NO;
            }
            
            if(![ACUtility isInteger:option3_2_TextField.text])
            {
                [self showWarningAlert:NSLocalizedString(@"Hours needs to be a number.", @"error message")];   
                return NO;
            }


        }
        
    }
    if(missionObj.missionType == PrivateGroupMissionType)
    {
        
        if(missionObj.startTime==nil || [missionObj.startTime isEqualToString:@""])
        {
            [self showWarningAlert:NSLocalizedString(@"Start time is required.", @"error message")];   
            return NO;
        }
        if(missionObj.deadLine==nil || [missionObj.deadLine isEqualToString:@""])
        {
            [self showWarningAlert:NSLocalizedString(@"End time is required.", @"error message")];   
            return NO;
        }


    
    
    
    }

 
    
	return YES;
}



#pragma mark -
#pragma mark TextField Delegate Function Methods


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    checkBox1.enabled=YES;
    checkBox2.enabled=YES;
    checkBox3.enabled=YES;
    
	[textField resignFirstResponder];
    [self datePickerViewDown];
    
	return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if(textField==titleTextField)
    {
        return YES; 
    }
    if(textField==challengerTextField)
    {
        [self challengerUP];
        return YES; 
    }
    if(textField==option1TextField)
    {
       // [textField resignFirstResponder];
        [self datePickerViewUP];
        return NO; 
    }
    if(textField==option2TextField)
    {
        [self hourUP];
        return YES; 
    }
    if(textField==option3_1_TextField)
    {
      //  [textField resignFirstResponder];
        [option3_2_TextField resignFirstResponder];
        [self datePickerViewUP];
        return NO; 
    }
    if(textField==option3_2_TextField)
    {
        [self hourUP];
        return YES; 
    }
    if(textField==startTimeTextField)
    {
        [self PrivateViewUP];
        isStartOrDeadLine=YES;
        return NO; 
    }
    if(textField==endTimeTextField)
    {
        [self PrivateViewUP];
        isStartOrDeadLine=NO;
        return NO; 
    }
    
	return NO;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	if ([text isEqual:@"\n"]) {
		[textView resignFirstResponder];
         [self moveTheView:myView movwToPosition:CGPointMake(0, 0)];
		
        return NO;
	}
	return YES;
}





@end
