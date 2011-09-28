//
//  UVCategorySelectViewController.m
//  UserVoice
//
//  Created by UserVoice on 2/6/10.
//  Copyright 2010 UserVoice Inc. All rights reserved.
//

#import "UVCategorySelectViewController.h"
#import "UVForum.h"
#import "UVCategory.h"
#import "UVNewSuggestionViewController.h"

@implementation UVCategorySelectViewController

@synthesize forum;
@synthesize categories;
@synthesize selectedCategory;

- (id)initWithForum:(UVForum *)theForum andSelectedCategory:(UVCategory *)category {
	if (self = [super init]) {
		self.forum = theForum;
		self.categories = theForum.availableCategories;
		self.selectedCategory = category;
	}
	return self;
}

#pragma mark ===== table cells =====

- (void)customizeCellForCategory:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
	UVCategory *category = (UVCategory *)[self.categories objectAtIndex:indexPath.row];
	cell.textLabel.text = category.name;
	if (self.selectedCategory && self.selectedCategory.categoryId == category.categoryId) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
}

#pragma mark ===== UITableViewDataSource Methods =====

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [self createCellForIdentifier:@"Category"
							   tableView:theTableView
							   indexPath:indexPath
								   style:UITableViewCellStyleDefault
							  selectable:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.categories count];
}

#pragma mark ===== UITableViewDelegate Methods =====

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[theTableView deselectRowAtIndexPath:indexPath animated:YES];

	UVCategory *category = [self.categories objectAtIndex:indexPath.row];

	// Update the previous view controller (the new suggestion view)
	NSArray *viewControllers = [self.navigationController viewControllers];
	UVNewSuggestionViewController *prev = (UVNewSuggestionViewController *)[viewControllers objectAtIndex:[viewControllers count] - 2];
	prev.category = category;
	prev.needsReload = YES;
	
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ===== Basic View Methods =====

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	
	self.navigationItem.title = @"Category";
	
	CGRect frame = [self contentFrame];
	UITableView *theTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
	theTableView.dataSource = self;
	theTableView.delegate = self;
	
	self.view = theTableView;
	[theTableView release];
	
	//[self addGradientBackground];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
