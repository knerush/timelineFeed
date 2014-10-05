//
//  User.h
//  TimelineFeed
//
//  Created by Katerina Nerush on 05/10/2014.
//  Copyright (c) 2014 Katerina Nerush. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (readonly, nonatomic, copy) NSString *firstName;
@property (readonly, nonatomic, copy) NSString *lastName;
@property (readonly, nonatomic, copy)NSString *avatarImageURL;

-(User *)initWithDictionary:(NSDictionary *)dict;
@end
