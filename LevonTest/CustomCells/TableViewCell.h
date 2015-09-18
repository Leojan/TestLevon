//
//  TableViewCell.h
//  LevonTest
//
//  Created by Levon Nikoghosyan on 9/18/15.
//  Copyright © 2015 Levon Nikoghosyan. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *dayOfWeek;
@property (strong, nonatomic) IBOutlet UILabel *minTemp;
@property (strong, nonatomic) IBOutlet UILabel *maxTemp;

@end
