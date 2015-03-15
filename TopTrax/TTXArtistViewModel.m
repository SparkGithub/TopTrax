//
//  TTXArtistViewModel.m
//  TopTrax
//
//  Created by Spark on 3/13/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "TTXArtistViewModel.h"

#import "LastFMClient.h"

#import "TTXAlbumViewModel.h"
#import "TTXAlbum.h"

@interface TTXArtistViewModel ()

@property (nonatomic, strong) RACSubject *updatedContentSignal;

@end

@implementation TTXArtistViewModel

-(instancetype)initWithArtist:(TTXArtist *)artist {
    self = [super init];
    if (self == nil) return nil;
    
    _artist = artist;
    
    self.updatedContentSignal = [[RACSubject subject] setNameWithFormat:@"TTXArtistViewModel updatedContentSignal"];
    
    @weakify(self)
    [self.didBecomeActiveSignal subscribeNext:^(id x) {
        
        @strongify(self);
        RACSignal *fetchSignal = [self fetchArtistAlbums];
        [fetchSignal subscribeCompleted:^{
            
            @strongify(self);
            [(RACSubject *)self.updatedContentSignal sendNext:nil];
        }];
    }];
    
    return self;
}

-(RACSignal *)fetchArtistAlbums {
    
    RACSignal *fetchSignal = [[[[LastFMClient sharedClient] artistAlbums:_artist] logError] catchTo:[RACSignal empty]];
    RAC(self, albums) = fetchSignal;
    
    return fetchSignal;
}

-(TTXAlbumViewModel *)albumViewModelForIndexPath:(NSIndexPath *)indexPath {
    TTXAlbumViewModel *viewModel = [[TTXAlbumViewModel alloc] initWithAlbum:(TTXAlbum *)[self.albums objectAtIndex:indexPath.row] andArtist:self.artist];
    return viewModel;
}

@end
