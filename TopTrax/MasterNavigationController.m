//
//  MasterNavigationController.m
//  TopTrax
//
//  Created by Spark on 3/14/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "MasterNavigationController.h"

@implementation MasterNavigationController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _pulldownMenu = [[PulldownMenu alloc] initWithNavigationController:self];
    [self.view insertSubview:_pulldownMenu belowSubview:self.navigationBar];
    
    [_pulldownMenu insertButton:@"Spain"];
    [_pulldownMenu insertButton:@"Italy"];
    [_pulldownMenu insertButton:@"Japan"];
    [_pulldownMenu insertButton:@"Sweden"];
    [_pulldownMenu insertButton:@"Germany"];
    
    [_pulldownMenu loadMenu];
}

@end
