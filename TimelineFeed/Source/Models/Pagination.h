//
//  Pagination.h
//  TimelineFeed
//
//  Created by Katerina Nerush on 06/10/2014.
//  Copyright (c) 2014 Katerina Nerush. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pagination : NSObject
@property(nonatomic, readonly)int currentPage;
@property(nonatomic, readonly, strong)NSString *nextPageUrl;
@property(nonatomic, readonly)int totalPages;

-(Pagination *)initWithDictionary:(NSDictionary *)dict;
-(Pagination *)initZeroPage;

@end
