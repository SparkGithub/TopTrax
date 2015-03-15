//
//  TTXArtistViewController.m
//  TopTrax
//
//  Created by Spark on 3/12/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "TTXArtistViewController.h"

#import "TTXAlbumCell.h"

// View Models
#import "TTXAlbum.h"
#import "TTXArtist.h"
#import "TTXArtistViewModel.h"
#import "TTXArtistFlowLayout.h"
#import "TTXAlbumViewModel.h"

#import "TTXAlbumViewController.h"

static NSString *CellIdentifier = @"Cell";

@interface TTXArtistViewController ()

@end

@implementation TTXArtistViewController

#pragma mark - UIViewController Overrides

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // Configure self
    self.title = @"Loading...";
    
    // Configure view
    [self.collectionView registerClass:[TTXAlbumCell class] forCellWithReuseIdentifier:CellIdentifier];
    TTXArtistFlowLayout *flowLayout = [[TTXArtistFlowLayout alloc] init];
    [self.collectionView setCollectionViewLayout:flowLayout];

    // Binding to view model
    @weakify(self);
    
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        self.title = self.viewModel.artist.name;
        [self.collectionView reloadData];
    }];
    
    [[self rac_signalForSelector:@selector(collectionView:didSelectItemAtIndexPath:) fromProtocol:@protocol(UICollectionViewDelegate)] subscribeNext:^(RACTuple *arguments) {
        @strongify(self);
        
        
        NSIndexPath *indexPath = arguments.second;
        UICollectionView * collectionView = arguments.first;
        
//        TTXAlbumViewController *viewController = [[TTXAlbumViewController alloc] init];
//        viewController.viewModel = [self.viewModel albumViewModelForIndexPath:indexPath];
//        [self.navigationController pushViewController:viewController animated:YES];

        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TTXAlbumViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"viewAlbumDetails"];
        viewController.viewModel = [self.viewModel albumViewModelForIndexPath:indexPath];
        [self.navigationController pushViewController:viewController animated:YES];
        
        
//        [self performSegueWithIdentifier:@"viewAlbumDetails" sender:[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath]];
        
    }];
    
    
    // Need to "reset" the cached values of respondsToSelector: of UIKit
    self.collectionView.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.viewModel.active = YES;
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (self.viewModel != nil && self.viewModel.albums != nil) ? self.viewModel.albums.count : 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTXAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    TTXAlbum *album = self.viewModel.albums[indexPath.row];
    [cell setAlbumModel:album];
    return cell;
}


@end
