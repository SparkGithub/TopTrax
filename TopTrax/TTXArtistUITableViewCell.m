//
//  TTXArtistUITableViewCell.m
//  TopTrax
//
//  Created by Spark on 3/15/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "TTXArtistUITableViewCell.h"

#import "NSData+AFDecompression.h"

#import "TTXArtist.h"

@implementation TTXArtistUITableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    //RAC(self.imageView, image) = RACObserve(self, artistModel.imageData);
    RAC(self.titleLabelView, text) = RACObserve(self, artistModel.name);
    RAC(self.detailsLabelView, text) = [[RACObserve(self, artistModel.listeners) ignore:nil] map:^id(NSString *value) {
        return [NSString stringWithFormat:@"(%@) listeners", value];
    }];
    RAC(self.imageView, image) = [[[RACObserve(self, artistModel.imageData) ignore:nil] map:^id(id value) {
        
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
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
