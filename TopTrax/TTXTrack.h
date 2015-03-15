//
//  TTXTracks.h
//  TopTrax
//
//  Created by Spark on 3/15/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTXTrack : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *duration;

+ (instancetype)objectFromDictionary:(NSDictionary *)dictionary;

@end
