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
#import "Pagination.h"
#import "FeedHTTPClient.h"
#import "UIImageView+AFNetworking.h"

static const int CELL_CONTENT_MARGIN = 10;

@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property(nonatomic, strong)Pagination *pagination;
@property(nonatomic, strong)NSArray *dataProvider;
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
    
    _pagination = [[Pagination alloc] initZeroPage];
    
    [self readNextPageData];
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

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *footer = [[UIView alloc] init];
//    
//    return footer;
//}

#pragma mark - 

- (void)scrollViewDidEndDragging:(UIScrollView *)aScrollView
                  willDecelerate:(BOOL)decelerate{
    
    CGPoint offset = _tableView.contentOffset;
    CGRect bounds = _tableView.bounds;
    CGSize size = _tableView.contentSize;
    UIEdgeInsets inset = _tableView.contentInset;

    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float reload_distance = 50;
    if(y > h + reload_distance) {
        NSLog(@"load more data");
        
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.frame=CGRectMake(0, 0, 310, 44);
        [spinner startAnimating];
        
        self.tableView.tableFooterView = spinner;
        
        [self readNextPageData];
    }
}


#pragma mark - private methods

-(void)readNextPageData
{
    if ((_pagination.totalPages - 1) < _pagination.currentPage) {
        NSLog(@"No more data available");
        return;
    }
    
//    NSLog(@"Read data for page %d out of %d", _pagination.currentPage + 1, _pagination.totalPages);
    FeedHTTPClient *client = [FeedHTTPClient sharedFeedHTTPClient];
    [client readFeedData:_pagination.nextPageUrl
                 success:^(NSArray *responseObject, Pagination *pagination) {
                     int currentCount = _dataProvider.count;
                     
                     NSMutableArray *currentDataProvider = [NSMutableArray arrayWithArray:_dataProvider];
                     [currentDataProvider addObjectsFromArray:responseObject];
                     _dataProvider = [currentDataProvider copy];
                     self.spinner.hidden = YES;
                     [_tableView reloadData];
                     
                     [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:currentCount inSection:0]
                                       atScrollPosition:UITableViewScrollPositionTop
                                               animated:YES];
                     
                     _pagination = pagination;
                     self.tableView.tableFooterView = nil;

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
