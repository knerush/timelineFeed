//
//  TableViewCell.h
//  TimelineFeed
//
//  Created by Katerina Nerush on 25/09/2014.
//  Copyright (c) 2014 Katerina Nerush. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *likes;
@property (weak, nonatomic) IBOutlet UILabel *comments;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;

@end
