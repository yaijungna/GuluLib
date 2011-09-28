//
//  UVComment.m
//  UserVoice
//
//  Created by UserVoice on 11/11/09.
//  Copyright 2009 UserVoice Inc. All rights reserved.
//

#import "UVComment.h"
#import "UVResponseDelegate.h"
#import "UVSession.h"
#import "UVClientConfig.h"
#import "UVSuggestion.h"
#import "UVForum.h"


@implementation UVComment

@synthesize commentId;
@synthesize text;
@synthesize userName;
@synthesize userId;
@synthesize avatarUrl;
@synthesize karmaScore;
@synthesize createdAt;

+ (void)initialize {
	[self setDelegate:[[UVResponseDelegate alloc] initWithModelClass:[self class]]];
	[self setBaseURL:[self siteURL]];
}

+ (id)getWithSuggestion:(UVSuggestion *)suggestion page:(NSInteger)page delegate:(id)delegate {
	NSString *path = [self apiPath:[NSString stringWithFormat:@"/forums/%d/suggestions/%d/comments.json",
									suggestion.forumId,
									suggestion.suggestionId]];
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							[[NSNumber numberWithInt:page] stringValue],
							@"page",
							nil];
	return [self getPath:path
			  withParams:params
				  target:delegate
				selector:@selector(didRetrieveComments:)];
}

+ (id)createWithSuggestion:(UVSuggestion *)suggestion text:(NSString *)text delegate:(id)delegate {
	NSString *path = [self apiPath:[NSString stringWithFormat:@"/forums/%d/suggestions/%d/comments.json",
									suggestion.forumId,
									suggestion.suggestionId]];
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							text, @"comment[text]",
							nil];
	return [[self class] postPath:path
					   withParams:params
						   target:delegate
						 selector:@selector(didCreateComment:)];
}

- (id)flag:(NSString *)code suggestion:(UVSuggestion *)suggestion delegate:(id)delegate {
	NSString *path = [UVComment apiPath:[NSString stringWithFormat:@"/forums/%d/suggestions/%d/comments/%d/flags",
										 suggestion.forumId,
										 suggestion.suggestionId,
										 self.commentId]];
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							code, @"code",
							nil];
	return [[self class] postPath:path
					   withParams:params
						   target:delegate
						 selector:@selector(didFlagComment:)];
}

- (id)initWithDictionary:(NSDictionary *)dict {
	if (self = [super init]) {
		self.commentId = [(NSNumber *)[dict objectForKey:@"id"] integerValue];
		self.text = [dict objectForKey:@"text"];
		NSDictionary *user = [dict objectForKey:@"creator"];
		if (user && ![[NSNull null] isEqual:user]) {
			self.userName = [user objectForKey:@"name"];
			self.userId = [(NSNumber *)[user objectForKey:@"id"] integerValue];
			self.avatarUrl = [self objectOrNilForDict:user key:@"avatar_url"];
			self.karmaScore = [(NSNumber *)[user objectForKey:@"karma_score"] integerValue];
			self.createdAt = [self parseJsonDate:[dict objectForKey:@"created_at"]];
		}
	}
	return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"commentId: %d", self.commentId];
}

@end
