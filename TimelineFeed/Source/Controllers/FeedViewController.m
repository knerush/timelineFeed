//
//  ViewController.m
//  TimelineFeed
//
//  Created by Katerina Nerush on 24/09/2014.
//  Copyright (c) 2014 Katerina Nerush. All rights reserved.
//

#import "FeedViewController.h"
#import "TableViewCell.h"
#import "FeedItem.h"
#import "User.h"
#import "FeedHTTPClient.h"
#import "UIImageView+AFNetworking.h"

static const int CELL_CONTENT_MARGIN = 10;

@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, strong)NSArray *dataProvider;

@end

@implementation FeedViewController


#pragma mark - lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil]
         forCellReuseIdentifier:@"Cell"];
    
    [self readData];
}

#pragma mark - table delegate methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"Cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    FeedItem *cellData = _dataProvider[indexPath.item];
    
    cell.content.text = cellData.content;
    cell.name.text = [NSString stringWithFormat:@"%@ %@", cellData.user.firstName, cellData.user.lastName];
    cell.likes.text = [NSString stringWithFormat:@"%d", cellData.likeCount];
    cell.comments.text = [NSString stringWithFormat:@"%d", cellData.commentCount];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:cellData.user.avatarImageURL]];
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    __weak TableViewCell *weakCell = cell;
    [cell.userAvatar setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request,
                                             NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       weakCell.userAvatar.image = image;
                                       [weakCell setNeedsLayout];
                                       
                                   } failure:nil];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedItem *cellData = _dataProvider[indexPath.item];
    
    CGFloat subtitleWidth = self.view.frame.size.width - CELL_CONTENT_MARGIN * 2;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
    
    CGRect rect = [cellData.content boundingRectWithSize:CGSizeMake(subtitleWidth, MAXFLOAT)
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:attributes
                                                       context:nil];
    return rect.size.height + CELL_CONTENT_MARGIN * 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataProvider.count;
}


#pragma mark - private methods

-(void)readData
{
    FeedHTTPClient *client = [FeedHTTPClient sharedFeedHTTPClient];
    [client readFeedDataWithSuccess:^(NSArray *responseObject) {
    
        _dataProvider = responseObject;
        self.spinner.hidden = YES;
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
}


@end
