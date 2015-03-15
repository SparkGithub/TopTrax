//
//  TTXAlbumViewModel.h
//  TopTrax
//
//  Created by Spark on 3/13/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "RVMViewModel.h"

@class TTXAlbum;
@class TTXArtist;


@interface TTXAlbumViewModel : RVMViewModel

@property (nonatomic, readonly) RACSignal *updatedContentSignal;
@property (strong, nonatomic) NSMutableArray *tracks;
@property (strong, nonatomic) TTXArtist *artist;
@property (strong, nonatomic) TTXAlbum *album;

- (instancetype)initWithAlbum:(TTXAlbum *)album andArtist:(TTXArtist *)artist;

@end
