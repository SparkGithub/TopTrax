//
//  AppDelegate.m
//  TopTrax
//
//  Created by Spark on 3/12/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "AppDelegate.h"

#import "TTXMasterViewController.h"
#import "TTXMasterViewModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Setup window
    self.window.tintColor = [UIColor blueColor]; //Temp

//    // Setup view controllers
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    TTXMasterViewController *controller = (TTXMasterViewController *)navigationController.topViewController;
    
    TTXMasterViewModel *viewModel = [[TTXMasterViewModel alloc] init];
    controller.viewModel = viewModel;
//    
//    // Setup model
//    [[ASHCoreDataStack defaultStack] ensureInitialLoad];
    
    return YES;
}

@end
