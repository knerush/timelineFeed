//
//  Pagination.m
//  TimelineFeed
//
//  Created by Katerina Nerush on 06/10/2014.
//  Copyright (c) 2014 Katerina Nerush. All rights reserved.
//

#import "Pagination.h"

@implementation Pagination

static NSString *const kCurrentPage = @"current_page";
static NSString *const kNextPageUrl = @"next_page";
static NSString *const kTotalPages = @"total_pages";


-(Pagination *)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _currentPage = [[dict valueForKeyPath:kCurrentPage] integerValue];

    if (![[dict valueForKeyPath:kNextPageUrl] isEqual:[NSNull null]]) {
        _nextPageUrl = [[dict valueForKeyPath:kNextPageUrl] lastPathComponent];
    }
    _totalPages = [[dict valueForKeyPath:kTotalPages] integerValue];
    
    return self;
}

-(Pagination *)initZeroPage
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _currentPage = 0;
    _nextPageUrl = @"posts";
    _totalPages = INT32_MAX;
    
    return self;
}

@end
