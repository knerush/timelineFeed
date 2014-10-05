//
//  FeedItem.h
//  TimelineFeed
//
//  Created by Katerina Nerush on 24/09/2014.
//  Copyright (c) 2014 Katerina Nerush. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface FeedItem : NSObject
@property(nonatomic, readonly, strong)NSString *content;
@property(nonatomic, readonly, strong)NSString *createdDate;
@property(nonatomic, readonly, strong)User *user;
@property(nonatomic, readonly) int commentCount;
@property(nonatomic, readonly) int likeCount;

-(FeedItem *)initWithDictionary:(NSDictionary *)dict;

@end
