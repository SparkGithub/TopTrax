//
//  TTXArtistViewController.h
//  TopTrax
//
//  Created by Spark on 3/12/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTXArtistViewModel;

@interface TTXArtistViewController : UICollectionViewController

@property (nonatomic, readonly) RACSignal *updatedContentSignal;
@property (nonatomic, strong) TTXArtistViewModel *viewModel;

@end
