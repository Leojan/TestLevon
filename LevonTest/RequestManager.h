//
//  RequestManager.h
//  LevonTest
//
//  Created by Levon Nikoghosyan on 9/18/15.
//  Copyright © 2015 Levon Nikoghosyan. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface RequestManager : AFHTTPSessionManager
+ (RequestManager *)sharedWeatherHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)getCurrentWeatherByName:(NSString *) name completion:(void (^)(NSDictionary* dict, NSError* error))completion;
- (void) getForecastWeatherByName:(NSString *)cityName days:(NSUInteger) days completion:(void (^)(NSDictionary* dict, NSError* error))completion;;
- (void) setMetric:(BOOL)metric;
-(void) getImageWithId:(NSString*) imgId;

@end
