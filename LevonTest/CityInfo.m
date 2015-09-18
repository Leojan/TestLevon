//
//  CityInfo.m
//  LevonTest
//
//  Created by Levon Nikoghosyan on 9/18/15.
//  Copyright © 2015 Levon Nikoghosyan. All rights reserved.
//

#import "CityInfo.h"

@implementation CityInfo

-(id) init {
    self = [super init];
    if (self) {
        _weakDays = [[NSMutableArray alloc] initWithCapacity:7];
    }
    return self;
}

@end
