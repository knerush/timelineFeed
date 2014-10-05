//
//  DataHTTPClient.h
//  TimelineFeed
//
//  Created by Katerina Nerush on 26/09/2014.
//  Copyright (c) 2014 Katerina Nerush. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@protocol FeedHTTPClientDelegate;

@interface FeedHTTPClient : AFHTTPSessionManager

+ (FeedHTTPClient *)sharedFeedHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)readFeedDataWithSuccess:(void (^)(NSArray *responseObject))success failure:(void (^)(NSError *error))failure;

@end

