//
//  TTXAlbumViewController.h
//  TopTrax
//
//  Created by Spark on 3/12/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTXAlbumViewModel;

@interface TTXAlbumViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, readonly) RACSignal *updatedContentSignal;
@property (nonatomic, strong) TTXAlbumViewModel *viewModel;

@end
