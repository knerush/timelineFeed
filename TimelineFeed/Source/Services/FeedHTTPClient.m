//
//  DataHTTPClient.m
//  TimelineFeed
//
//  Created by Katerina Nerush on 26/09/2014.
//  Copyright (c) 2014 Katerina Nerush. All rights reserved.
//

#import "FeedHTTPClient.h"
#import "FeedItem.h"

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

-(void)readFeedDataWithSuccess:(void (^)(NSArray *responseObject))success
                       failure:(void (^)(NSError *error))failure
{
    [self GET:@"posts" parameters:nil
      success:^(NSURLSessionDataTask *task, id JSON) {
          
          NSArray *postsFromResponse = [JSON valueForKeyPath:@"posts.data"];
          NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
          for (NSDictionary *attributes in postsFromResponse) {
              FeedItem *post = [[FeedItem alloc] initWithDictionary:attributes];
              [mutablePosts addObject:post];
          }
          
          
          success([mutablePosts copy]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}



@end
