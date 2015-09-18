//
//  AppDataManager.h
//  LevonTest
//
//  Created by Levon Nikoghosyan on 9/18/15.
//  Copyright © 2015 Levon Nikoghosyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityInfo.h"


@interface AppDataManager : NSObject
+ (instancetype)defaultManager;
-(void) updateCurrentDetailByName:(NSString *) cityName  completion:(void (^)(CityInfo* info, NSError* error))completion;
-(void) updateWeakBriefInfo:(NSString *) cityName  completion:(void (^)(CityInfo* info, NSError* error))completion;
@end
