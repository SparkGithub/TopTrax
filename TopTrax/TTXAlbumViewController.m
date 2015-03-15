//
//  TTXAlbumViewController.m
//  TopTrax
//
//  Created by Spark on 3/12/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "TTXAlbumViewController.h"

#import "NSData+AFDecompression.h"

#import "TTXAlbumViewModel.h"
#import "TTXAlbum.h"
#import "TTXArtist.h"
#import "TTXTrack.h"

@interface TTXAlbumViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *largeImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TTXAlbumViewController

#pragma mark - UIViewController Overrides

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Configure self
    self.title = @"Loading...";

//    RAC(self.largeImageView, image) = [[[RACObserve(self.viewModel.album, largeImageData) ignore:nil] map:^id(id value) {
//        return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            [value af_decompressedImageFromJPEGDataWithCallback:
//             ^(UIImage *decompressedImage) {
//                 [subscriber sendNext:decompressedImage];
//                 [subscriber sendCompleted];
//             }];
//            return nil;
//        }] subscribeOn:[RACScheduler scheduler]];
//    }] switchToLatest];
    
    // Binding to view model
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        self.title = self.viewModel.album.name;
        self.largeImageView.image = [UIImage imageWithData:self.viewModel.album.imageData];
        [self.tableView reloadData];
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.viewModel.active = YES;
}

#pragma mark - Table view data source


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.tracks.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    // Always return YES.
    return NO;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TrackCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Private Methods

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    TTXTrack *track = self.viewModel.tracks[indexPath.row];
    
    UILabel *trackNameLabel = (UILabel *)[cell viewWithTag:200];
    trackNameLabel.text = [NSString stringWithFormat:@"%d. %@", indexPath.row, track.name];
    
    UILabel *durationLabel = (UILabel *)[cell viewWithTag:201];
    durationLabel.text = [NSString stringWithFormat:@"%@", track.duration];
}


@end