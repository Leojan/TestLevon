//
//  ViewController.m
//  LevonTest
//
//  Created by Levon Nikoghosyan on 9/18/15.
//  Copyright © 2015 Levon Nikoghosyan. All rights reserved.
//

#import "TableViewController.h"
#import "AppDataManager.h"
#import "TableViewCell.h"
#import "CityBriefInfo.h"

@interface TableViewController ()
@property (nonatomic,retain) CityInfo*  cityInfo;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AppDataManager defaultManager] updateCurrentDetailByName:@"Lyon" completion:^(CityInfo *info, NSError *error) {
        if (error) {
            return ;
        }
        self.cityInfo = info;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm a"];
       
        self.sunriseLabel.text = [formatter stringFromDate:self.cityInfo.sunrise];
         self.sunsetLabel.text = [formatter stringFromDate:self.cityInfo.sunset];
        self.cloudsLabel.text = [NSString stringWithFormat:@"%@ %%", self.cityInfo.clouds];
        if (self.cityInfo.rain) {
            self.rainLabel.text = [NSString stringWithFormat:@"%@ mm", self.cityInfo.rain];
        } else {
            self.rainLabel.text = @"---";
 
        }
        self.humidityLabel.text = [NSString stringWithFormat:@"%@ %%", self.cityInfo.humidity];
        self.pressureLabel.text = [NSString stringWithFormat:@"%@ hPa", self.cityInfo.humidity];
        self.cityName.text  =self.cityInfo.name;
        self.weatherStatusLabel.text  =self.cityInfo.descript;
        self.temperatureLabel.text  =self.cityInfo.temperature;

        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.cityInfo.weakDays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReuseIdentifier" forIndexPath:indexPath];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    dateFormatter.dateFormat=@"EEEE";
    CityBriefInfo* briefInfo = self.cityInfo.weakDays[indexPath.row];
    
    cell.dayOfWeek.text =[[dateFormatter stringFromDate:briefInfo.date] capitalizedString];
    cell.maxTemp.text = [NSString stringWithFormat:@"%.2f",[ briefInfo.maxTemp floatValue]];
    cell.minTemp.text = [NSString stringWithFormat:@"%.2f",[ briefInfo.minTemp floatValue]];

    return cell;
}

@end
