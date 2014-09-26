//
//  DataHTTPClient.m
//  TimelineFeed
//
//  Created by Katerina Nerush on 26/09/2014.
//  Copyright (c) 2014 Katerina Nerush. All rights reserved.
//

#import "FeedHTTPClient.h"

@implementation FeedHTTPClient

static NSString * const FeedURLString = @"http://unii-interview.herokuapp.com/api/v1/";

+ (FeedHTTPClient *)sharedFeedHTTPClient
{
    static FeedHTTPClient *_sharedFeedHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedFeedHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:FeedURLString]];
    });
    
    return _sharedFeedHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

-(void)readFeedData
{
    [self GET:@"posts" parameters:nil
      success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(feedHTTPClient:didUpdateWithData:)]) {
            [self.delegate feedHTTPClient:self didUpdateWithData:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(feedHTTPClient:didFailWithError:)]) {
            [self.delegate feedHTTPClient:self didFailWithError:error];
        }
    }];
}

@end
