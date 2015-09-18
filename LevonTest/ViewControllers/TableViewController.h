//
//  ViewController.h
//  LevonTest
//
//  Created by Levon Nikoghosyan on 9/18/15.
//  Copyright © 2015 Levon Nikoghosyan. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController

#pragma mark - Header view outlets

@property (strong, nonatomic) IBOutlet UILabel *cityName;
@property (strong, nonatomic) IBOutlet UIImageView *weatherStatusImage;
@property (strong, nonatomic) IBOutlet UILabel *weatherStatusLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;

#pragma mark - Footer view outlets

@property (strong, nonatomic) IBOutlet UILabel *sunriseLabel;
@property (strong, nonatomic) IBOutlet UILabel *sunsetLabel;
@property (strong, nonatomic) IBOutlet UILabel *cloudsLabel;
@property (strong, nonatomic) IBOutlet UILabel *rainLabel;
@property (strong, nonatomic) IBOutlet UILabel *humidityLabel;
@property (strong, nonatomic) IBOutlet UILabel *pressureLabel;



@end
