//
//  CityInfo.h
//  LevonTest
//
//  Created by Levon Nikoghosyan on 9/18/15.
//  Copyright © 2015 Levon Nikoghosyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityInfo : NSObject
@property (nonatomic,retain) NSString* name;
@property (nonatomic,retain) NSString* descript;
@property (nonatomic,retain) NSString* temperature;
@property (nonatomic,retain) NSDate* sunrise;
@property (nonatomic,retain) NSDate* sunset;
@property (nonatomic,retain) NSString* clouds;
@property (nonatomic,retain) NSString* rain;
@property (nonatomic,retain) NSString* humidity;
@property (nonatomic,retain) NSString* pressure;
@property (nonatomic,retain) NSMutableArray*  weakDays;

@end
