//
//  ACCameraViewController.m
//  GULUAPP
//
//  Created by chen alan on 2011/5/24.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import "ACCameraViewController.h"
#import "debugDefined.h"

@implementation ACCameraViewController

@synthesize ACDelegate;

static id sharedMyManager_Camera = nil;


+ (id)sharedManager {
	@synchronized(self){
        if(sharedMyManager_Camera == nil)
            sharedMyManager_Camera = [[ACCameraViewController alloc] init];
    }
    return sharedMyManager_Camera;
}

- (void)initLayOut 
{	
	cameraControlLayout=[[ACCameraView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[cameraControlLayout.cameraFlashButton addTarget:self action:@selector(tapFlashBtn) forControlEvents:UIControlEventTouchUpInside];
	[cameraControlLayout.cameraFrontRearButton addTarget:self action:@selector(tapFrontRearBtn) forControlEvents:UIControlEventTouchUpInside];

	[cameraControlLayout.topView.topLeftButton addTarget:self action:@selector(cancelImagePicker) forControlEvents:UIControlEventTouchUpInside];
	[((ACButtonWIthBottomTitle *)cameraControlLayout.bottomView.bottomButton1).btn addTarget:self action:@selector(changeToLibraryMode) forControlEvents:UIControlEventTouchUpInside];
	[cameraControlLayout.bottomView.bottomButton2 addTarget:self action:@selector(takeShot) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initLayOut];
	self.delegate=self;
    self.videoQuality=UIImagePickerControllerQualityTypeLow;
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		[self changeToCameraMode];
	//	[self changeToLibraryMode];
	}
	else 
	{
		[self changeToLibraryMode];
	}	 
}

- (void)dealloc {
	
	[cameraControlLayout release];
	cameraControlLayout=nil;
    [super dealloc];
}

#pragma mark -
#pragma mark ImagePicker function

-(void)takeShot
{	
	[self takePicture];
}

-(void)cancelImagePicker
{
	UIApplication *application = [UIApplication sharedApplication];
	[application setStatusBarStyle:UIStatusBarStyleDefault];
	application.statusBarHidden=NO;
	
	[ACDelegate ACCameraViewControllerDelegateCancelImagePicker];
}

-(void)changeToLibraryMode
{
	UIApplication *application = [UIApplication sharedApplication];
	[application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
	application.statusBarHidden=NO;
	
	self.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
	self.allowsEditing=YES;
}

-(void)changeToCameraMode
{
	//UIApplication *application = [UIApplication sharedApplication];
	//application.statusBarHidden=YES;
	
	self.sourceType=UIImagePickerControllerSourceTypeCamera;
	self.allowsEditing=NO;
	self.showsCameraControls=NO;
	self.cameraOverlayView=cameraControlLayout;
	self.cameraViewTransform = CGAffineTransformMakeScale(1.0, 1.0);
	self.cameraFlashMode= UIImagePickerControllerCameraFlashModeOff;
	self.cameraDevice=UIImagePickerControllerCameraDeviceRear;
}

- (void)tapFrontRearBtn 
{
	if(self.cameraDevice==UIImagePickerControllerCameraDeviceFront)
	{
		[cameraControlLayout.cameraFrontRearButton setBackgroundImage:[UIImage imageNamed:@"inactive-camera-flip-icon.png"] forState:UIControlStateNormal];
		self.cameraDevice=UIImagePickerControllerCameraDeviceRear;
	}
	else if(self.cameraDevice==UIImagePickerControllerCameraDeviceRear)
	{
		[cameraControlLayout.cameraFrontRearButton setBackgroundImage:[UIImage imageNamed:@"active-camera-flip-icon.png"] forState:UIControlStateNormal];
		self.cameraDevice=UIImagePickerControllerCameraDeviceFront;
	}
}

- (void)tapFlashBtn 
{
	if(self.cameraFlashMode== UIImagePickerControllerCameraFlashModeOff)
	{
		[cameraControlLayout.cameraFlashButton setBackgroundImage:[UIImage imageNamed:@"active-flash-icon.png"] forState:UIControlStateNormal];
		self.cameraFlashMode= UIImagePickerControllerCameraFlashModeOn;
	}
	else if(self.cameraFlashMode== UIImagePickerControllerCameraFlashModeOn)
	{
		[cameraControlLayout.cameraFlashButton setBackgroundImage:[UIImage imageNamed:@"inactive-flash-icon.png"] forState:UIControlStateNormal];
		self.cameraFlashMode= UIImagePickerControllerCameraFlashModeOff;
	}
}


#pragma mark -
#pragma mark ImagePicker delegate

- (void)imagePickerController:(UIImagePickerController *)picker 
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo 
{
	UIApplication *application = [UIApplication sharedApplication];
	[application setStatusBarStyle:UIStatusBarStyleDefault];
	application.statusBarHidden=NO;
	
	UIImage *imageNew;
	
    ACLog(@"%@",editingInfo);	
    
    if(picker.sourceType==UIImagePickerControllerSourceTypeCamera)  //camera
	{	
        if(image.size.width>=image.size.height)
        {
          CGRect rect = CGRectMake(0.0, 0.0, 860,640);
        //    CGRect rect = CGRectMake(0.0, 0.0, image.size.width,image.size.height);
            
            UIGraphicsBeginImageContext(rect.size);
            [image drawInRect:rect];
            imageNew = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
          CGRect cropRect=CGRectMake(160, 20, 600,600);
         //   CGRect cropRect=CGRectMake(320, 40, 1200,1200);
            CGImageRef imageRef = CGImageCreateWithImageInRect([imageNew CGImage], cropRect);
            imageNew=[UIImage imageWithCGImage:imageRef];
            CGImageRelease(imageRef);

        }
        else
        {
          CGRect rect = CGRectMake(0.0, 0.0, 640,860);
        //    CGRect rect = CGRectMake(0.0, 0.0, image.size.width,image.size.height);
            
            UIGraphicsBeginImageContext(rect.size);
            [image drawInRect:rect];
            imageNew = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
          CGRect cropRect=CGRectMake(20, 114, 600,600);
        //    CGRect cropRect=CGRectMake(40, 228, 1200,1200);
            CGImageRef imageRef = CGImageCreateWithImageInRect([imageNew CGImage], cropRect);
            imageNew=[UIImage imageWithCGImage:imageRef];
            CGImageRelease(imageRef);
        }
     
       // imageNew=image;

		
    }
	// GMC we do not have to check. We always want imageNew to be used, so removing the if insures that.
	else // GMC if (picker.sourceType==UIImagePickerControllerSourceTypePhotoLibrary) 
	{
        CGRect rect =CGRectZero;
       
        if(image.size.width!=image.size.height)
        {
            float minSideLength=MIN(image.size.width, image.size.height);
            float diff=0.0;
            
            
            NSLog(@"image.size.height=%f",image.size.height);
            NSLog(@"image.size.width=%f",image.size.width);
            NSLog(@"minSideLength=%f",minSideLength);

            
            if(image.size.width==minSideLength)
            {
                diff= (image.size.height-minSideLength)/2;
                rect = CGRectMake(0.0, diff, minSideLength,minSideLength);
            }
            if(image.size.height==minSideLength)
            {
                diff= (image.size.width-minSideLength)/2;
                rect = CGRectMake(diff, 0.0, minSideLength,minSideLength);
            }
            
            CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
            image=[UIImage imageWithCGImage:imageRef];
            CGImageRelease(imageRef);
            
            NSLog(@"image.size.height=%f",image.size.height);
            NSLog(@"image.size.width=%f",image.size.width);
            

        }
        
         
        
        
        CGRect rectfinal = CGRectMake(0.0, 0.0, 600,600);
        UIGraphicsBeginImageContext(rectfinal.size);
		[image drawInRect:rectfinal];
		imageNew = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
         
              
        NSLog(@"%@=%f,%f",imageNew,imageNew.size.width,imageNew.size.height);
        
	}
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		[self changeToCameraMode];
	}
	else 
	{
		[self changeToLibraryMode];
	}	
    
	
	[ACDelegate ACCameraViewControllerDelegateDidFinishPickingImage:imageNew];
	
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{	
	
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		UIApplication *application = [UIApplication sharedApplication];
		[application setStatusBarStyle:UIStatusBarStyleDefault];
		application.statusBarHidden=NO;
		
		[ACDelegate ACCameraViewControllerDelegateCancelImagePicker];
		return;
	}
	else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		[self changeToCameraMode];
		//[ACDelegate ACCameraViewControllerDelegateCancelImagePicker];
	}
}


@end
