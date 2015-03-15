//
//  TTXArtist.m
//  TopTrax
//
//  Created by Spark on 3/13/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "TTXArtist.h"

@implementation TTXArtist

+ (instancetype)objectFromDictionary:(NSDictionary *)dictionary {
    TTXArtist *artist = [[self alloc] init];
    artist.name = dictionary[@"name"];
    artist.listeners = dictionary[@"listeners"];
    artist.imageURL = [NSURL URLWithString:dictionary[@"image"][1][@"#text"]];
    return artist;
}

@end
