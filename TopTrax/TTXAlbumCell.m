//
//  TTXAlbumCell.m
//  TopTrax
//
//  Created by Spark on 3/13/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "TTXAlbumCell.h"
#import "NSData+AFDecompression.h"
#import "TTXAlbum.h"
#import "LastFMClient.h"

@interface TTXAlbumCell ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation TTXAlbumCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    // Configure self
    self.backgroundColor = [UIColor purpleColor];
    
    // Configure subivews
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:imageView];
    
    self.imageView = imageView;
    
    self.imageView.backgroundColor = [UIColor grayColor];
    
    RAC(self.imageView, image) = [[[RACObserve(self, albumModel.imageData) ignore:nil] map:^id(id value) {

        // convert into JPEG because we are getting PNG/JPEG
        // TODO: should be done only for PNGs
        UIImage *myImage = [UIImage imageWithData:value];
        NSData *jpgData = UIImageJPEGRepresentation(myImage, 1);
        
        return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [jpgData af_decompressedImageFromJPEGDataWithCallback:
             ^(UIImage *decompressedImage) {
                 [subscriber sendNext:decompressedImage];
                 [subscriber sendCompleted];
             }];
            return nil;
        }] subscribeOn:[RACScheduler scheduler]];
    }] switchToLatest];
    
    return self;
}

@end
