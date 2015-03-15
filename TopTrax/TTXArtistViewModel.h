//
//  TTXArtistViewModel.h
//  TopTrax
//
//  Created by Spark on 3/13/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "RVMViewModel.h"

@class TTXAlbumViewModel;
@class TTXAlbum;
@class TTXArtist;

@interface TTXArtistViewModel : RVMViewModel

@property (nonatomic, readonly) RACSignal *updatedContentSignal;
@property (strong, nonatomic) NSMutableArray *albums;
@property (strong, nonatomic) TTXArtist *artist;

-(TTXAlbumViewModel *)albumViewModelForIndexPath:(NSIndexPath *)indexPath;
- (instancetype)initWithArtist:(TTXArtist *)artist;
@end
