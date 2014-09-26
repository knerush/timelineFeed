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
@property (nonatomic, weak) id<FeedHTTPClientDelegate>delegate;

+ (FeedHTTPClient *)sharedFeedHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)readFeedData;

@end

@protocol FeedHTTPClientDelegate <NSObject>
@optional
-(void)feedHTTPClient:(FeedHTTPClient *)client didUpdateWithData:(id)data;
-(void)feedHTTPClient:(FeedHTTPClient *)client didFailWithError:(NSError *)error;
@end
