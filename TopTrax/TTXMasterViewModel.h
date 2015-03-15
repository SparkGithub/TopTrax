//
//  TTXMasterViewModel.h
//  TopTrax
//
//  Created by Spark on 3/13/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "RVMViewModel.h"
#import "AFHTTPRequestOperationManager.h"

@class TTXArtistViewModel;

@interface TTXMasterViewModel : RVMViewModel

@property (nonatomic, readonly) RACSignal *updatedContentSignal;
@property (strong, readonly, nonatomic) NSArray *artists;

-(TTXArtistViewModel *)artistViewModelForIndexPath:(NSIndexPath *)indexPath;
-(void)updateTopArtistsWithCountry:(NSString *)country;
@end
