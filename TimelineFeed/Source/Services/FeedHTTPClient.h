//
//  DataHTTPClient.h
//  TimelineFeed
//
//  Created by Katerina Nerush on 26/09/2014.
//  Copyright (c) 2014 Katerina Nerush. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "Pagination.h"

@protocol FeedHTTPClientDelegate;

@interface FeedHTTPClient : AFHTTPSessionManager

+ (FeedHTTPClient *)sharedFeedHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)readFeedData:(NSString *)requestStr success:(void (^)(NSArray *posts, Pagination *pagination))success failure:(void (^)(NSError *error))failure;

@end

