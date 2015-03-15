//
//  TTXMasterViewController.h
//  TopTrax
//
//  Created by Spark on 3/12/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PulldownMenu.h"

@class TTXMasterViewModel;

@interface TTXMasterViewController : UITableViewController<PulldownMenuDelegate>

@property (nonatomic, strong) TTXMasterViewModel *viewModel;

@end
