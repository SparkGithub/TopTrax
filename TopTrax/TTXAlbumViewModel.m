//
//  TTXAlbumViewModel.m
//  TopTrax
//
//  Created by Spark on 3/13/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "TTXAlbumViewModel.h"

#import "LastFMClient.h"

#import "TTXArtist.h"
#import "TTXAlbum.h"


@interface TTXAlbumViewModel ()

@property (nonatomic, strong) RACSubject *updatedContentSignal;

@end

@implementation TTXAlbumViewModel

-(instancetype)initWithAlbum:(TTXAlbum *)album andArtist: artist {
    self = [super init];
    if (self == nil) return nil;
    
    _album = album;
    _artist = artist;
    
    self.updatedContentSignal = [[RACSubject subject] setNameWithFormat:@"TTXAlbumViewModel updatedContentSignal"];
    
    @weakify(self)
    [self.didBecomeActiveSignal subscribeNext:^(id x) {
        
        @strongify(self);
        RACSignal *fetchSignal = [self fetchAlbumTracks];
        [fetchSignal subscribeCompleted:^{
            
            @strongify(self);
            [(RACSubject *)self.updatedContentSignal sendNext:nil];
        }];
    }];
    
    return self;
}

-(RACSignal *)fetchAlbumTracks {
    
    RACSignal *fetchSignal = [[[[LastFMClient sharedClient] artistAlbumTracks:_artist andAlbum:_album] logError] catchTo:[RACSignal empty]];
    RAC(self, tracks) = fetchSignal;
    return fetchSignal;
}

@end
