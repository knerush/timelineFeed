//
//  FeedItem.m
//  TimelineFeed
//
//  Created by Katerina Nerush on 24/09/2014.
//  Copyright (c) 2014 Katerina Nerush. All rights reserved.
//

#import "FeedItem.h"

@implementation FeedItem

+(FeedItem *)itemFromDictionary:(NSDictionary *)dict
{
    FeedItem *item = [[FeedItem alloc] init];
    
    item.content = [dict valueForKeyPath:kContent];
    item.createdDate = [dict valueForKeyPath:kDate];
    item.userAvatar = [dict valueForKeyPath:kUserUrl];
    item.userName = [dict valueForKeyPath:kUserName];
    item.userLastName = [dict valueForKeyPath:kUserLastName];
    item.commentCount = [[dict valueForKeyPath:kComments] intValue];
    item.likeCount = [[dict valueForKeyPath:kLikes] intValue];
    
    return item;
}

@end
