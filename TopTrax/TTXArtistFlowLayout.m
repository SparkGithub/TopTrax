//
//  TTXArtistFlowLayout.m
//  TopTrax
//
//  Created by Spark on 3/13/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "TTXArtistFlowLayout.h"

@implementation TTXArtistFlowLayout

-(instancetype)init {
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(145, 145);
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    return self;
}

@end
