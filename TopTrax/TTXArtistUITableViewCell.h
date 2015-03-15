//
//  TTXArtistUITableViewCell.h
//  TopTrax
//
//  Created by Spark on 3/15/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTXArtist;

@interface TTXArtistUITableViewCell : UITableViewCell

@property (nonatomic, strong) TTXArtist *artistModel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabelView;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabelView;

@end
