//
//  TTXMasterViewModel.m
//  TopTrax
//
//  Created by Spark on 3/13/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "TTXMasterViewModel.h"

#import "LastFMClient.h"

#import "TTXArtistViewModel.h"
#import "TTXArtist.h"

@interface TTXMasterViewModel ()

@property (nonatomic, strong) RACSubject *updatedContentSignal;

@end

@implementation TTXMasterViewModel

-(instancetype)init {
    self = [super init];
    if (self == nil) return nil;
    
    self.updatedContentSignal = [[RACSubject subject] setNameWithFormat:@"TTXMasterViewModel updatedContentSignal"];
    
    @weakify(self)
    [self.didBecomeActiveSignal subscribeNext:^(id x) {
        @strongify(self);
        [self updateTopArtistsWithCountry: @"spain"];
    }];
    
    return self;
}

-(void)updateTopArtistsWithCountry:(NSString *)country {

    @weakify(self);
    RACSignal *fetchSignal = [self fetchTopArtists: country];
    [fetchSignal subscribeCompleted:^{
        
        @strongify(self);
        [(RACSubject *)self.updatedContentSignal sendNext:nil];
    }];
   
}

-(RACSignal *)fetchTopArtists: (NSString *)region {

    RACSignal *fetchSignal = [[[[LastFMClient sharedClient] topArtistsForRegion:region] logError] catchTo:[RACSignal empty]]; // TODO: signal to update
    
    RAC(self, artists) = fetchSignal;
    
    return fetchSignal;
}

-(TTXArtistViewModel *)artistViewModelForIndexPath:(NSIndexPath *)indexPath {
    TTXArtistViewModel *viewModel = [[TTXArtistViewModel alloc] initWithArtist:(TTXArtist *)[self.artists objectAtIndex:indexPath.row]];
    return viewModel;
}

@end
