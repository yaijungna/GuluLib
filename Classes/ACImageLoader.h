//
//  imageLoader.h
//
//  Created by chen alan on 2011/5/23.
//  Copyright 2011 Gulu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ACImageDownloaderDelegate;

@interface ACImageLoader : NSObject {
	
	id <ACImageDownloaderDelegate> delegate;
	
	NSMutableData	*activeDownload;
	NSURLConnection *imageConnection;
	UIImage		*image;
	NSString	*URLStr;
	NSIndexPath *indexPath;
	NSString	*tagString;
	NSInteger tag;
	BOOL isStart;
    
    UITableView *table;
	
}

@property (nonatomic, assign) id <ACImageDownloaderDelegate> delegate;
@property (nonatomic, retain) NSURLConnection *imageConnection;
@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString * URLStr;
@property (nonatomic, retain) NSIndexPath *indexPath; 
@property (nonatomic, retain) NSString *tagString;
@property (nonatomic) NSInteger tag;
@property (nonatomic, retain)UITableView *table;

- (void)startDownload;
- (void)cancelDownload;

@end

@protocol ACImageDownloaderDelegate

@optional

- (void)ACImageDidLoad:(id)sender;

@end