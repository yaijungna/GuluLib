//
//  PostReviewViewContorller.m
//  GULUAPP
//
//  Created by chen alan on 2011/6/8.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "PostReviewViewContorller.h"

#import "PostManager.h"

@implementation PostReviewViewContorller

@synthesize post;
@synthesize postWarningAlert,postFinishAlert,postSubmitConfirmAlert;


- (void) initViewController
{
	topView=[[[TopMenuBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] initTopBarView:ButtonTypeCancel middle:ButtonTypeGuluLogo right:ButtonTypeNoneType];
	[self.view addSubview:topView];
	[topView release];
	
	[topView.topLeftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[topView.topMiddleButton addTarget:self action:@selector(landingAction) forControlEvents:UIControlEventTouchUpInside];

	spinView=[[loadingSpinnerAndMessageView alloc] init] ;
	[self.view addSubview:spinView];
	spinView.hidden=YES;
	
	//=====
	
	imagePicker =[ACCameraViewController sharedManager];
	imagePicker.ACDelegate=self;
	[photobtn addTarget:self action:@selector(retakeAction) forControlEvents:UIControlEventTouchUpInside];
	
	//=====
	
	[self customizeTextField:placeTextField];
	[self customizeTextField:dishTextField];
	[self customizeTextView:reviewTextView];
	
	[placeTextField setReturnKeyType: UIReturnKeyDone];
	[dishTextField setReturnKeyType: UIReturnKeyDone];
//    [bestknowforTextField setReturnKeyType: UIReturnKeyDone];

	[placeTextField addTarget:self action:@selector(textFieldEditingBegin:) forControlEvents:UIControlEventEditingDidBegin];
	[dishTextField addTarget:self action:@selector(textFieldEditingBegin:) forControlEvents:UIControlEventEditingDidBegin];
//    [bestknowforTextField addTarget:self action:@selector(textFieldEditingBegin:) forControlEvents:UIControlEventEditingDidBegin];
    
	reviewTextView.delegate=self;

	placeTextField.placeholder=NSLocalizedString(@"Restaurant",@"[post]select restaurant ");
	dishTextField.placeholder=NSLocalizedString(@"Dish",@"[post]select dish");
	
	[submitBtn setBackgroundImage:[UIImage imageNamed:@"button-1.png"] forState:UIControlStateNormal];
	[submitBtn	setTitle:NSLocalizedString(@"SUBMIT",@"[button] submit post") forState:UIControlStateNormal];
	[submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[submitBtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:14]];
	[submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    
    [saveBtn setBackgroundImage:[UIImage imageNamed:@"button-1.png"] forState:UIControlStateNormal];
	[saveBtn setTitle:NSLocalizedString(@"SAVE",@"[button] SAVE post") forState:UIControlStateNormal];
	[saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[saveBtn.titleLabel setFont:[UIFont fontWithName:FONT_BOLD size:14]];
	[saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [thumbUpButton setBackgroundImage:[UIImage imageNamed:@"inactive-thumbs-up-1.png"] forState:UIControlStateNormal];
	[thumbUpButton setBackgroundImage:[UIImage imageNamed:@"active-thumbs-up-1.png"] forState:UIControlStateSelected];
	[thumbDownButton setBackgroundImage:[UIImage imageNamed:@"inactive-thumbs-down-1.png"] forState:UIControlStateNormal];
	[thumbDownButton setBackgroundImage:[UIImage imageNamed:@"active-thumbs-down-1.png"] forState:UIControlStateSelected];
	
	[thumbUpButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
	[thumbDownButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //===================   slider  =======================
    
    slider=[[ACSlider alloc] initWithFrame:CGRectMake(10, 170, 300, 55)];
	[reviewInfoview addSubview:slider ];
	slider.delegate=self;
    
    //=====================================================
    
    placeVC=[[SearchRestaurantViewController alloc] initWithNibName:@"SearchRestaurantViewController" bundle:nil];
    placeVC.searchTextField=placeTextField;
    [subview addSubview:placeVC.view];
    placeVC.delegate=self;
    placeVC.navigationController=self.navigationController;
    [placeVC.table setFrame:CGRectMake(0,460, 320, 313)];
    placeVC.allowAddNewPlace=YES;
    
    
    dishVC=[[SearchDishViewController alloc] initWithNibName:@"SearchDishViewController" bundle:nil];
    dishVC.searchTextField=dishTextField;
    [subview addSubview:dishVC.view];
    dishVC.delegate=self;
    [dishVC.table setFrame:CGRectMake(0,460, 320, 313)];
    
    /*
    bestknownforVC=[[bestKnownForViewController alloc] initWithNibName:@"bestKnownForViewController" bundle:nil];
    bestknownforVC.searchTextField=bestknowforTextField;
    [subview addSubview:dishVC.view];
    bestknownforVC.delegate=self;
    [bestknownforVC.table setFrame:CGRectMake(0,460, 320, 313)];
    */
    
    [reviewInfoview setFrame:CGRectMake(0, 460, 320, 317)];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];	
    
    self.post=appDelegate.temp.postObj;
	post.bestKnownFor=@"";
    photoImageView.image= post.photo;    
    [post submitPhotoStart];
    
    if([post.dishDict count])
    {
        placeTextField.text=[post.restaurantDict objectForKey:@"name"];
        dishTextField.text=[post.dishDict objectForKey:@"name"];
        placeTextField.userInteractionEnabled=NO;
        dishTextField.userInteractionEnabled=NO;
        [self textViewDidBeginEditing:reviewTextView];
        
        if(post.review)
        {
            reviewTextView.text=post.review;
        }

        return;
    }
    else if([post.restaurantDict count])
    {
        placeTextField.userInteractionEnabled=NO;
        [self selectedDictionary:post.restaurantDict];
        
        if(post.review)
        {
            reviewTextView.text=post.review;
        }

        return;
    }
    else
    {
        [self textFieldEditingBegin:placeTextField];  //normal
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    [post release];
	[postWarningAlert release];
    [postFinishAlert release];
    [postSubmitConfirmAlert release];
    
    [slider release];
    
    [placeVC release]; placeVC=nil;
    [dishVC release]; dishVC=nil;
    
    [spinView release];

    [super dealloc];
}

#pragma mark search place delegate Methods

- (void) selectedBestKnownForDictionary:(NSMutableDictionary *)dict
{
    post.bestKnownFor=@"";
    [self textViewDidBeginEditing:reviewTextView];
    [reviewInfoview resignFirstResponder];

}

#pragma mark search place delegate Methods

- (void) selectedDictionary:(NSMutableDictionary *)dict;
{
    post.restaurantDict=dict;
    
    placeTextField.text=[dict objectForKey:@"name"];
    [self moveTheView:placeVC.table movwToPosition:CGPointMake(0, 460)];
    
    dishVC.rid=[post.restaurantDict objectForKey:@"id"];
    [dishVC getDishOfPlace];
    
    [self textFieldEditingBegin:dishTextField];
}

#pragma mark search dish delegate Methods

- (void) selectedDishDictionary:(NSMutableDictionary *)dict;
{
    [self moveTheView:dishVC.table movwToPosition:CGPointMake(0, 460)];
    
    ACLog(@"%@", dict);
    if([dict objectForKey:@"app_skip"])
    {
        post.dishDict=[[[NSMutableDictionary alloc] init] autorelease];
        [post.dishDict setObject:@"" forKey:@"id"];
		[post.dishDict setObject:@"" forKey:@"name"];
    }
    else if([dict objectForKey:@"app_newdish"])
    {
        NSMutableDictionary *Dict=[[[NSMutableDictionary alloc] init] autorelease];
        [Dict setObject:[dict objectForKey:@"app_newdish"] forKey:@"name"];
        [Dict setObject:@"-1" forKey:@"id"];
        
        
        post.dishDict=Dict;
    }
    else
    {
         post.dishDict=dict;
    }
    ACLog(@"%@",post.dishDict);
    dishTextField.text=[post.dishDict objectForKey:@"name"];
    
    [self textViewDidBeginEditing:reviewTextView];
}

#pragma mark textfield and textview delegate Methods
#pragma mark -
-(void)textFieldEditingBegin:(UITextField *)field
{
    
    if(field == placeTextField)
    {
        [subview bringSubviewToFront:placeVC.view];
        [self moveTheView:placeVC.table movwToPosition:CGPointMake(0, 0)];
        [self moveTheView:dishVC.table movwToPosition:CGPointMake(0, 460)];
//        [self moveTheView:bestknownforVC.table movwToPosition:CGPointMake(0, 460)];
        [self moveTheView:reviewInfoview movwToPosition:CGPointMake(0, 460)];
    }
    else if(field == dishTextField)
    {
        [subview bringSubviewToFront:dishVC.view];
        [self moveTheView:dishVC.table movwToPosition:CGPointMake(0, 0)];
        [self moveTheView:placeVC.table movwToPosition:CGPointMake(0, 460)];
//        [self moveTheView:bestknownforVC.table movwToPosition:CGPointMake(0, 460)];
        [self moveTheView:reviewInfoview movwToPosition:CGPointMake(0, 460)];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
//    [reviewTextView becomeFirstResponder];
    
    [subview bringSubviewToFront:reviewInfoview];
    [self moveTheView:reviewInfoview movwToPosition:CGPointMake(0, 0)];
    [self moveTheView:placeVC.table movwToPosition:CGPointMake(0, 460)];
    [self moveTheView:dishVC.table movwToPosition:CGPointMake(0, 460)];
 //   [self moveTheView:bestknownforVC.table movwToPosition:CGPointMake(0, 460)];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	if ([text isEqual:@"\n"]) {
		[textView resignFirstResponder];
		
		post.review=textView.text;
		
		return NO;
	}
	return YES;
}

#pragma mark -
#pragma mark alert Function Methods

-(void) showWarningAlert:(NSString *)String
{	    
    self.postWarningAlert = [[[TSAlertView alloc] init] autorelease];
    postWarningAlert.title =NSLocalizedString(@"Warning!",@"Warning alert to notify user.");
    postWarningAlert.message =String;
    postWarningAlert.delegate=self;
    [postWarningAlert addButtonWithTitle: GLOBAL_NO_STRING];
    [postWarningAlert addButtonWithTitle: GLOBAL_YES_STRING];
    [postWarningAlert show];
}

/*
-(void) showSubmitFinishAlert
{	
    [postWarningAlert dismissWithClickedButtonIndex:0 animated:NO];
    
    self.postFinishAlert = [[[TSAlertView alloc] init] autorelease];
    postFinishAlert.title =NSLocalizedString(@"Congratulations!",@"");
    postFinishAlert.message =NSLocalizedString(@"Submit Successfully!",@"[post]") ;
    postFinishAlert.delegate=self;
    [postFinishAlert addButtonWithTitle: GLOBAL_OK_STRING];
    [postFinishAlert show];
}
 */

-(void) showNotCompleteAlert:(NSString *)str
{	
    TSAlertView *Alert = [[[TSAlertView alloc] init] autorelease];
    Alert.title =NSLocalizedString(@"Warning!",@"");
    Alert.message =str;
    Alert.delegate=self;
    [Alert addButtonWithTitle: GLOBAL_OK_STRING];
    [Alert show];
}

/*
-(void) showSubmitAlert
{	
    self.postSubmitConfirmAlert = [[[TSAlertView alloc] init] autorelease];
    postSubmitConfirmAlert.title =NSLocalizedString(@"Confirm",@"");
    postSubmitConfirmAlert.message =NSLocalizedString(@"Are you sure you want to submit this post? ",@"[post]") ;
    postSubmitConfirmAlert.delegate=self;
    [postSubmitConfirmAlert addButtonWithTitle: GLOBAL_NO_STRING];
    [postSubmitConfirmAlert addButtonWithTitle: GLOBAL_YES_STRING];
    [postSubmitConfirmAlert show];
}
*/

#pragma mark -
#pragma mark  Function Methods

- (void)tapButton:(UIButton *) btn 
{
	if(btn==thumbUpButton)
	{
        if(thumbUpButton.selected){
            thumbUpButton.selected =NO;
            post.isThumb=0;}
        else{
            thumbUpButton.selected =YES;
            thumbDownButton.selected=NO;
            post.isThumb=1;}
    }
	
	if(btn==thumbDownButton){
        if(thumbDownButton.selected){
            thumbDownButton.selected =NO;
            post.isThumb=0;}
        else{
            thumbDownButton.selected =YES;
            thumbUpButton.selected=NO;
            post.isThumb=-1;}
	}
}

- (void)retakeAction 
{
	[self presentModalViewController:imagePicker animated:NO];
}

- (void)backAction 
{
	[self showWarningAlert:NSLocalizedString(@"Abort this review and go back?",@"[POST] press cancel button and show the warning")];
}

- (void)landingAction
{
	[self showWarningAlert:NSLocalizedString(@"Abort this review and go to Landing?",@"[POST] press cancel button and show the warning")];
}

- (void)submitAction
{
    if([post.review isEqualToString:@""] || post.review==nil)
    {
        [self showNotCompleteAlert:NSLocalizedString(@"Please type somethimg.", @"tell user to write review")];
        return;
    }    
    
    
    [self showSpinnerView:spinView mesage:GLOBAL_SAVING_STRING];
    reviewInfoview.userInteractionEnabled=NO;
    
    [self performSelector:@selector(submitReview) withObject:nil afterDelay:0.2];
    
}

- (void)saveAction
{ 
    if([post.review isEqualToString:@""] || post.review==nil)
    {
        [self showNotCompleteAlert:NSLocalizedString(@"Please type somethimg.", @"tell user to write review")];
        return;
    }    
    
    [self showSpinnerView:spinView mesage:GLOBAL_SAVING_STRING];
    reviewInfoview.userInteractionEnabled=NO;
    
    [self performSelector:@selector(saveReview) withObject:nil afterDelay:0.2];
}

 

#pragma mark -
#pragma mark request Function Methods

- (void)submitReview
{	
    ACLog(@"submitReview");
    
    PostManager *manager=[PostManager sharedManager];
    [manager addToQueue:post];
    [manager postRveview:[manager.postQueueArray count]-1];
    appDelegate.gotoLastPageFromPost=YES;
    appDelegate.temp.postObj=nil;
    [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:NO afterDelay:0.1];
}

- (void)saveReview
{	
    ACLog(@"saveReview");
    
    PostManager *manager=[PostManager sharedManager];
    [manager addToQueue:post];

    appDelegate.gotoLastPageFromPost=YES;
    appDelegate.temp.postObj=nil;
    [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:NO afterDelay:0.1];
}

/*
- (void)postSuccessed:(id)sender info:(id)info
{
    [self showSubmitFinishAlert];	
}

- (void)postFailed:(id)sender error:(NSError *)error
{
    ScrollView.userInteractionEnabled=YES;
    [self hideSpinnerView:spinView];
    
    [post save];
    
    appDelegate.gotoLastPageFromPost=YES;
    appDelegate.temp.postObj=nil;
   
    [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:NO afterDelay:0.1];
    
    
    
    ACLog(@"submit review fail at step%d",((postModel*)sender).step);
}
 */

#pragma mark -
#pragma mark TSAlert Delegate Function Methods

- (void)alertView:(TSAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    /*
    if(alert==postFinishAlert && buttonIndex ==0)  //post finish
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyPost" object:nil];
        
        if(post.todoid)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTodoList" object:nil];
        }
        
        if(post.taskid)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyMission" object:nil];
        }
        
		appDelegate.gotoLastPageFromPost=YES;
		appDelegate.temp.postObj=nil;
		
        //[self.navigationController popViewControllerAnimated:NO];
        [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:NO afterDelay:0.1];
    }
     */
    if(alert==postWarningAlert && buttonIndex==1)  //cancel post
    {
        appDelegate.gotoLastPageFromPost=YES;
        appDelegate.temp.postObj=nil;
        //[self.navigationController popViewControllerAnimated:NO];
        [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:NO afterDelay:0.1];
    }
   /* else if(alert==postSubmitConfirmAlert && buttonIndex==1)  //submit
    {
        ScrollView.userInteractionEnabled=NO;
        [placeVC.network cancelAllRequestsInRequestsQueue];
        [dishVC.network cancelAllRequestsInRequestsQueue];
        [self submitReview];
      
    }
    */
}


#pragma mark -
#pragma mark ACCameraViewController Delegate Function Methods

- (void)ACCameraViewControllerDelegateDidFinishPickingImage:(UIImage *)image
{
	post.photoDict=nil;
	[self dismissModalViewControllerAnimated:NO];
	post.photo=image;
    photoImageView.image=image;
    [post submitPhotoStart];
}

- (void)ACCameraViewControllerDelegateCancelImagePicker
{
	[self dismissModalViewControllerAnimated:NO];
}

#pragma mark -
#pragma mark ACSlider Delegate Function Methods

-(void)slideToEndAction
{
    slider.hidden=YES;
    
    thumbUpButton.selected=YES;
    thumbDownButton.selected=NO;
    
    thumbUpButton.userInteractionEnabled=NO;
    thumbDownButton.userInteractionEnabled=NO;

    guluApprovedView *approvedView =[[guluApprovedView alloc] initWithFrame:slider.frame];
	[reviewInfoview addSubview:approvedView];
	[approvedView release];
	approvedView.hidden=NO;
    
    post.isGuluapproved=YES;
    post.isThumb=1;
    
}


@end
