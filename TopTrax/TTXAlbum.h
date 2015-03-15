//
//  TTXAlbum.h
//  TopTrax
//
//  Created by Spark on 3/13/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTXAlbum : NSObject<NSCopying>

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *playcount;
@property (copy, nonatomic) NSURL *imageURL;
@property (copy, nonatomic) NSData *imageData;
@property (copy, nonatomic) NSURL *largeImageURL;
@property (copy, nonatomic) NSData *largeImageData;

+ (instancetype)objectFromDictionary:(NSDictionary *)dictionary;

@end
