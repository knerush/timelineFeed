//
//  User.m
//  TimelineFeed
//
//  Created by Katerina Nerush on 05/10/2014.
//  Copyright (c) 2014 Katerina Nerush. All rights reserved.
//

#import "User.h"

@implementation User

static NSString *const kUserUrl = @"avatar";
static NSString *const kUserName = @"first_name";
static NSString *const kUserLastName = @"last_name";

-(User *)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _firstName = [dict valueForKeyPath:kUserName];
    _lastName = [dict valueForKeyPath:kUserLastName];
    _avatarImageURL = [dict valueForKeyPath:kUserUrl];
    
    return self;
}

@end
