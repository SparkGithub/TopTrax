//
//  TTXTracks.m
//  TopTrax
//
//  Created by Spark on 3/15/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "TTXTrack.h"

@implementation TTXTrack

+ (instancetype)objectFromDictionary:(NSDictionary *)dictionary {
    TTXTrack *track = [[self alloc] init];
    track.name = dictionary[@"name"];
    track.duration = dictionary[@"duration"];
    return track;
}

@end
