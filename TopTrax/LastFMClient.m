//
//  LastFMClient.m
//  TopTrax
//
//  Created by Spark on 3/13/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "LastFMClient.h"

#import "TTXArtist.h"
#import "TTXAlbum.h"
#import "TTXTrack.h"

@implementation LastFMClient
+ (instancetype)sharedClient {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self manager];
    });
    
    return sharedInstance;
}

+ (instancetype)manager {
    return [[self alloc] initWithBaseURL:nil];
}

- (RACSignal *)topArtistsForRegion:(NSString *)region {
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self GET:@"http://ws.audioscrobbler.com/2.0/" parameters:@{@"method": @"geo.gettopartists", @"country": region, @"api_key": @"9c0cbfb76c4b7e2b3e4e559d8d0ff13c", @"format": @"json"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *artists = [[[responseObject[@"topartists"][@"artist"] rac_sequence] map:^id(NSDictionary *artist) {
                TTXArtist *fecthedArtist = [TTXArtist objectFromDictionary:artist];
                [self downloadImageForArtist:fecthedArtist];
                return fecthedArtist;
            }] array];
            [subscriber sendNext:artists];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }] replayLazily];
}

// ----- OPTION 1 -----

//-(NSURLRequest *)buildURLRequestForArtistAlbum:(TTXArtist *)artist {
//    
//    NSString* urlString = [[NSString stringWithFormat:@"http://ws.audioscrobbler.com/2.0/?method=%@&artist=%@&api_key=%@&limit=%@&format=%@",
//                            @"artist.gettopalbums",
//                            artist.name,
//                            @"9c0cbfb76c4b7e2b3e4e559d8d0ff13c",
//                            @"10",
//                            @"json"] stringByAddingPercentEscapesUsingEncoding : NSUTF8StringEncoding];
//
//    NSURL *api= [NSURL URLWithString:urlString];
//    return [[NSURLRequest alloc] initWithURL:api];
//}
//
//-(RACSignal *)requestArtistAlbums:(TTXArtist *)artist
//{
//    NSURLRequest *request = [self buildURLRequestForArtistAlbum:artist];
//    return [[NSURLConnection rac_sendAsynchronousRequest:request] reduceEach:^id(NSURLResponse *response, NSData *data){
//        return data;
//    }];
//}
//
//
//- (RACSignal *)artistAlbums:(TTXArtist *)artist{
//    return [[[[[self requestArtistAlbums:artist] deliverOn:[RACScheduler mainThreadScheduler]] map:^id(NSData *data) {
//        id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        
//        return [[[results[@"topalbums"][@"album"] rac_sequence] map:^id(NSDictionary *album) {
//            TTXAlbum *fecthedAlbum = [TTXAlbum objectFromDictionary:album];
//            [self downloadImageForAlbum:fecthedAlbum];
//            return fecthedAlbum;
//        }] array];
//    }] publish] autoconnect];
//}


- (RACSignal *)artistAlbums:(TTXArtist *)artist {
    //NSLog(@"Start fetch for artist name:%@",artist.name);
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self GET:@"http://ws.audioscrobbler.com/2.0/" parameters:@{@"method": @"artist.gettopalbums", @"artist": artist.name, @"api_key": @"9c0cbfb76c4b7e2b3e4e559d8d0ff13c", /*@"limit":@"10",*/ @"format": @"json"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *albums = [[[responseObject[@"topalbums"][@"album"] rac_sequence] map:^id(NSDictionary *album) {
                TTXAlbum *fecthedAlbum = [TTXAlbum objectFromDictionary:album];
                [self downloadImageForAlbum:fecthedAlbum];
                //[self downloadLargeImageForAlbum:fecthedAlbum]; //TODO download large image; maybe do it on next page?
                return fecthedAlbum;
            }] array];
            [subscriber sendNext:albums];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }] publish] autoconnect];
}

- (RACSignal *)artistAlbumTracks:(TTXArtist *)artist andAlbum: (TTXAlbum *)album {
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self GET:@"http://ws.audioscrobbler.com/2.0/" parameters:@{@"method": @"album.getinfo", @"artist": artist.name, @"api_key": @"9c0cbfb76c4b7e2b3e4e559d8d0ff13c", @"album":album.name, @"format": @"json"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *tracks = [[[responseObject[@"album"][@"tracks"][@"track"] rac_sequence] map:^id(NSDictionary *track) {
                TTXTrack *fecthedTrack = [TTXTrack objectFromDictionary:track];
                return fecthedTrack;
            }] array];
            [subscriber sendNext:tracks];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }] publish] autoconnect];
}

#pragma mark - Image download section

-(void)downloadImageForArtist:(TTXArtist *)artist {
    RAC(artist, imageData) = [self download:artist.imageURL];
}

-(void)downloadImageForAlbum:(TTXAlbum *)album {
    RAC(album, imageData) = [self download:album.imageURL];
}

-(void)downloadLargeImageForAlbum:(TTXAlbum *)album {
    RAC(album, largeImageURL) = [self download:album.largeImageURL];
}

-(RACSignal *)download:(NSURL *)url {
    NSAssert(url, @"URL must not be nil");
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    return [[[NSURLConnection rac_sendAsynchronousRequest:request] reduceEach:^id(NSURLResponse *response, NSData *data){
        //NSLog(@"downloaded:%@",url.path);
        return data;
    }] deliverOn:[RACScheduler mainThreadScheduler]];
}

@end
