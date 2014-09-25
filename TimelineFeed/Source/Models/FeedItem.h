//
//  FeedItem.h
//  TimelineFeed
//
//  Created by Katerina Nerush on 24/09/2014.
//  Copyright (c) 2014 Katerina Nerush. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kComments = @"comment_count";
static NSString *const kContent = @"content";
static NSString *const kDate = @"created_at";
static NSString *const kLikes = @"like_count";
static NSString *const kUserUrl = @"user.avatar";
static NSString *const kUserName = @"user.first_name";
static NSString *const kUserLastName = @"user.last_name";


@interface FeedItem : NSObject
@property(nonatomic, strong)NSString *content;
@property(nonatomic, strong)NSString *createdDate;
@property(nonatomic, strong)NSString *userAvatar;
@property(nonatomic, strong)NSString *userName;
@property(nonatomic, strong)NSString *userLastName;
@property int commentCount;
@property int likeCount;

+(FeedItem *)itemFromDictionary:(NSDictionary *)dict;

@end
