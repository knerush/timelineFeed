//
//  DataService.h
//  TimelineFeed
//
//  Created by Katerina Nerush on 24/09/2014.
//  Copyright (c) 2014 Katerina Nerush. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataService : NSObject

+ (void)loadFeedWithSuccess:(void (^)(id JSON))success;

@end
