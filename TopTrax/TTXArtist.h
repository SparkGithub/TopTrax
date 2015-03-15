//
//  TTXArtist.h
//  TopTrax
//
//  Created by Spark on 3/13/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTXArtist : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *listeners;
@property (strong, nonatomic) NSURL *imageURL;
@property (copy, nonatomic) NSData *imageData;

+ (instancetype)objectFromDictionary:(NSDictionary *)dictionary;

@end
