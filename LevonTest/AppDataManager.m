//
//  AppDataManager.m
//  LevonTest
//
//  Created by Levon Nikoghosyan on 9/18/15.
//  Copyright © 2015 Levon Nikoghosyan. All rights reserved.
//

#import "AppDataManager.h"
#import "RequestManager.h"
#import "CityBriefInfo.h"

@implementation AppDataManager


+(instancetype) defaultManager {
    static dispatch_once_t once;
    static AppDataManager *defaultManager;
    dispatch_once(&once, ^{
        defaultManager = [[self alloc] init];
    });
    return defaultManager;
    
}

-(void) updateCurrentDetailByName:(NSString *)cityName completion:(void (^)(CityInfo * info, NSError * err))completion {
    [[RequestManager sharedWeatherHTTPClient] getCurrentWeatherByName:cityName completion:^(NSDictionary *dict, NSError *error) {
        if (error) {
            return completion(nil,error);
        }
        __block CityInfo* info = [[CityInfo alloc] init];
        info.name = dict[@"name"];
        NSDictionary*  mainDict = dict[@"main"];
        info.humidity = mainDict[@"humidity"];
        info.pressure = mainDict[@"pressure"];
        info.rain = dict[@"rain"];
        NSNumber*  num = mainDict[@"temp"];
        info.temperature = [num stringValue];
        NSDictionary* cloudsDict = dict[@"clouds"];
        info.clouds = cloudsDict[@"all"];
        NSArray* array = dict[@"weather"];
        NSDictionary* weatherDict = array[0];

        info.descript =weatherDict[@"description"];

        NSDictionary* sysDict = dict[@"sys"];
        info.sunset = [NSDate dateWithTimeIntervalSince1970:[sysDict[@"sunset"] integerValue]];
        info.sunrise = [NSDate dateWithTimeIntervalSince1970:[sysDict[@"sunrise"] integerValue]];
        [[RequestManager sharedWeatherHTTPClient] getForecastWeatherByName:cityName days:7 completion:^(NSDictionary *briefDict, NSError *briefError) {
            if (briefError) {
                return completion(nil,briefError);
            }
            NSArray*  arr = briefDict[@"list"];
            NSAssert(arr.count == 7, @"must  be 7");
            for (NSDictionary*  tempDictionary in arr) {
                CityBriefInfo*  briefInfo = [[CityBriefInfo alloc] init];
                NSDictionary*  temperatureDict = tempDictionary[@"temp"];
                NSNumber* num = temperatureDict[@"min"];
                briefInfo.minTemp = [num stringValue];
                num = temperatureDict[@"max"];
                briefInfo.maxTemp = [num stringValue];
                briefInfo.date =[NSDate dateWithTimeIntervalSince1970:[tempDictionary[@"dt"] integerValue]];
                [info.weakDays addObject:briefInfo];
                
            }
            completion(info,nil);
  
        }];



    }];
}

@end
