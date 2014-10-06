//
//  FeedItem.m
//  TimelineFeed
//
//  Created by Katerina Nerush on 24/09/2014.
//  Copyright (c) 2014 Katerina Nerush. All rights reserved.
//

#import "FeedItem.h"

@implementation FeedItem

static NSString *const kComments = @"comment_count";
static NSString *const kContent = @"content";
static NSString *const kDate = @"created_at";
static NSString *const kLikes = @"like_count";
static NSString *const kUser = @"user";

-(FeedItem *)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _content = [dict valueForKeyPath:kContent];
    _createdDate = [dict valueForKeyPath:kDate];
    _user = [[User alloc] initWithDictionary:[dict valueForKeyPath:kUser]];
    _commentCount = [[dict valueForKeyPath:kComments] intValue];
    _likeCount = [[dict valueForKeyPath:kLikes] intValue];
    
    return self;
}

@end
