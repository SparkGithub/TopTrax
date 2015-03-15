//
//  LastFMClient.h
//  TopTrax
//
//  Created by Spark on 3/13/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@class TTXArtist;
@class TTXAlbum;

@interface LastFMClient : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;

- (RACSignal *)topArtistsForRegion:(NSString *)region;
- (RACSignal *)artistAlbums:(TTXArtist *)artist;
- (RACSignal *)artistAlbumTracks:(TTXArtist *)artist andAlbum: (TTXAlbum *)album;

@end
