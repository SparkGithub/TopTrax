//
//  TTXAlbum.m
//  TopTrax
//
//  Created by Spark on 3/13/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "TTXAlbum.h"

@implementation TTXAlbum

+ (instancetype)objectFromDictionary:(NSDictionary *)dictionary {
    TTXAlbum *album = [[self alloc] init];
    album.name = dictionary[@"name"];
    album.playcount = dictionary[@"playcount"];
    album.imageURL = [NSURL URLWithString:dictionary[@"image"][2][@"#text"]]; //large
    album.largeImageURL = [NSURL URLWithString:dictionary[@"image"][3][@"#text"]]; //extralarge
    return album;
}

-(id) copyWithZone: (NSZone *) zone{
    TTXAlbum* copy = [[TTXAlbum allocWithZone: zone] init];
    copy.name = self.name;
    copy.playcount = self.playcount;
    copy.imageURL = self.imageURL;
    copy.largeImageURL = self.largeImageURL;
    copy.imageData = [self.imageData copyWithZone:nil];
    
    return copy;
}


@end
