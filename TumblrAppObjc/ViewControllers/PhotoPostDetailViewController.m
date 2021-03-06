//
//  PhotoPostsDetailViewController.m
//  TumblrAppObjc
//
//  Created by Jakub Matuła on 08/10/2017.
//  Copyright © 2017 Jakub Matuła. All rights reserved.
//

#import "PhotoPostDetailViewController.h"
#import "Post.h"
#import "Masonry.h"
#import "PhotoTableViewCell.h"

static NSString * const photoCellIdentifier = @"PhotoCell";

@implementation PhotoPostDetailViewController

-(instancetype)initWithPost:(PhotoPost *)photoPost {
    self = [super init];
    _post = photoPost;
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView registerClass: [PhotoTableViewCell class] forCellReuseIdentifier: photoCellIdentifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.estimatedRowHeight = 40;
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: photoCellIdentifier forIndexPath: indexPath];
    NSURL *imgUrl = _post.photos[indexPath.row];
    cell.translatesAutoresizingMaskIntoConstraints = false;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL: imgUrl];
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell setPhotoImage:[UIImage imageWithData:data scale:1]];
        });
    });
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return _post.photos.count;
}

@end
