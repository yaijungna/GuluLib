//
//  UVSuggestion.m
//  UserVoice
//
//  Created by UserVoice on 10/27/09.
//  Copyright 2009 UserVoice Inc. All rights reserved.
//

#import "UVSuggestion.h"
#import "UVResponseDelegate.h"
#import "UVSession.h"
#import "UVClientConfig.h"
#import "UVUser.h"
#import "UVForum.h"
#import "UVCategory.h"
#import "UVUIColorAdditions.h"
#import "UVSuggestionDetailsViewController.h"

@implementation UVSuggestion

@synthesize suggestionId;
@synthesize forumId;
@synthesize commentsCount;
@synthesize voteCount;
@synthesize votesFor;
@synthesize votesRemaining;
@synthesize title;
@synthesize abstract;
@synthesize text;
@synthesize status;
@synthesize statusHexColor;
@synthesize forumName;
@synthesize createdAt;
@synthesize updatedAt;
@synthesize closedAt;
@synthesize creatorName;
@synthesize creatorId;
@synthesize responseText;
@synthesize responseUserName;
@synthesize responseUserAvatarUrl;
@synthesize responseUserId;
@synthesize category;

+ (void)initialize {
	[self setDelegate:[[UVResponseDelegate alloc] initWithModelClass:[self class]]];
	[self setBaseURL:[self siteURL]];
}

+ (id)getWithForum:(UVForum *)forum page:(NSInteger)page delegate:(id)delegate {
	NSString *path = [self apiPath:[NSString stringWithFormat:@"/forums/%d/suggestions.json", forum.forumId]];
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							[[NSNumber numberWithInt:page] stringValue], @"page",
							//@"5", @"per_page",
							nil];
	return [self getPath:path
			  withParams:params
				  target:delegate
				selector:@selector(didRetrieveSuggestions:)];
}

+ (id)getWithForumAndUser:(UVForum *)forum user:(UVUser *)user delegate:(id)delegate {
	NSString *path = [self apiPath:[NSString stringWithFormat:@"/forums/%d/users/%d/suggestions.json", forum.forumId, user.userId]];
	return [self getPath:path
			  withParams:nil
				  target:delegate
				selector:@selector(didRetrieveUserSuggestions:)];
}

+ (id)searchWithForum:(UVForum *)forum query:(NSString *)query delegate:(id)delegate {
	NSString *path = [self apiPath:[NSString stringWithFormat:@"/forums/%d/suggestions/search.json", forum.forumId]];
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							query,
							@"query",
							nil];
	return [self getPath:path
			  withParams:params
				  target:delegate
				selector:@selector(didSearchSuggestions:)];
}

+ (id)createWithForum:(UVForum *)forum
			 category:(UVCategory *)category
				title:(NSString *)title
				 text:(NSString *)text
				votes:(NSInteger)votes
			 delegate:(id)delegate {
	NSString *path = [self apiPath:[NSString stringWithFormat:@"/forums/%d/suggestions.json", forum.forumId]];
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							[[NSNumber numberWithInteger:votes] stringValue], @"suggestion[votes]",
							title, @"suggestion[title]",
							text == nil ? @"" : text, @"suggestion[text]",
							category == nil ? @"" : [[NSNumber numberWithInteger:category.categoryId] stringValue], @"suggestion[category_id]",
							nil];
	return [[self class] postPath:path
					   withParams:params
						   target:delegate
						 selector:@selector(didCreateSuggestion:)];
}

- (id)vote:(NSInteger)number delegate:(id)delegate {
	NSString *path = [UVSuggestion apiPath:[NSString stringWithFormat:@"/forums/%d/suggestions/%d/votes.json",
											self.forumId,
											self.suggestionId]];
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							[[NSNumber numberWithInt:number] stringValue],
							@"to",
							nil];
	
	return [[self class] postPath:path
					   withParams:params
						   target:delegate
						 selector:@selector(didVoteForSuggestion:)];
}

- (id)flag:(NSString *)code delegate:(id)delegate {
	NSString *path = [UVSuggestion apiPath:[NSString stringWithFormat:@"/forums/%d/suggestions/%d/flags",
											self.forumId,
											self.suggestionId]];
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							code, @"code",
							nil];
	return [[self class] postPath:path
					   withParams:params
						   target:delegate
						 selector:@selector(didFlagSuggestion:)];
}

+ (void)processModels:(NSArray *)models {
	if ([models count] > 0) {
		// Votes remaining are returned as part of the nested forum element for each
		// invividual suggestion, even though they're all the same. We'll arbitrarily
		// grab it from the first one.
		[self processModel:[models objectAtIndex:0]];
	}
}

- (UIColor *)statusColor {
	return self.statusHexColor ? [UIColor colorWithHexString:self.statusHexColor] : [UIColor clearColor];
}

- (NSString *)categoryString {
	if (self.category) {
		return [NSString stringWithFormat:@"%@ » %@", self.forumName, self.category.name];
	} else {
		return self.forumName;
	}
}

- (id)initWithDictionary:(NSDictionary *)dict {
	if (self = [super init]) {
		self.suggestionId = [(NSNumber *)[dict objectForKey:@"id"] integerValue];
		self.commentsCount = [(NSNumber *)[dict objectForKey:@"comments_count"] integerValue];
		self.voteCount = [(NSNumber *)[dict objectForKey:@"vote_count"] integerValue];
		self.votesFor = [(NSNumber *)[dict objectForKey:@"votes_for"] integerValue];
		self.title = [self objectOrNilForDict:dict key:@"title"];
		self.abstract = [self objectOrNilForDict:dict key:@"abstract"];
		self.text = [self objectOrNilForDict:dict key:@"text"];
		self.createdAt = [self parseJsonDate:[dict objectForKey:@"created_at"]];
		NSDictionary *statusDict = [self objectOrNilForDict:dict key:@"status"];
		if (statusDict)
		{
			self.status = [statusDict objectForKey:@"name"];
			self.statusHexColor = [statusDict objectForKey:@"hex_color"];
		}
		NSDictionary *creator = [self objectOrNilForDict:dict key:@"creator"];
		if (creator)
		{
			self.creatorName = [creator objectForKey:@"name"];
			self.creatorId = [(NSNumber *)[creator objectForKey:@"id"] integerValue];
		}
		NSDictionary *response = [self objectOrNilForDict:dict key:@"response"];
		if (response) {
			self.responseText = [self objectOrNilForDict:response key:@"text"];
			NSDictionary *responseUser = [self objectOrNilForDict:response key:@"user"];
			if (responseUser) {
				self.responseUserName = [self objectOrNilForDict:responseUser key:@"name"];
				self.responseUserAvatarUrl = [self objectOrNilForDict:responseUser key:@"avatar_url"];
				self.responseUserId = [(NSNumber *)[self objectOrNilForDict:responseUser key:@"id"] integerValue];
			}
		}
		
		NSDictionary *topic = [self objectOrNilForDict:dict key:@"topic"];
		if (topic)
		{
			NSDictionary *forum = [self objectOrNilForDict:topic key:@"forum"];
			if (forum) {
				self.forumId = [(NSNumber *)[forum objectForKey:@"id"] integerValue];
				self.forumName = [self objectOrNilForDict:forum key:@"name"];
			}
			
			self.votesRemaining = [(NSNumber *)[topic objectForKey:@"votes_remaining"] integerValue];
		}
		
		NSDictionary *categoryDict = [self objectOrNilForDict:dict key:@"category"];
		if (categoryDict) {
			self.category = [[[UVCategory alloc] initWithDictionary:categoryDict] autorelease];
		}
	}
	return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"suggestionId: %d\ntitle: %@\nvotes: %d", self.suggestionId, self.title, self.voteCount];
}

@end
