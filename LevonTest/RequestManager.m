//
//  RequestManager.m
//  LevonTest
//
//  Created by Levon Nikoghosyan on 9/18/15.
//  Copyright © 2015 Levon Nikoghosyan. All rights reserved.
//

#import "RequestManager.h"

@interface RequestManager () {
    BOOL isMetric;
}

@end

static  NSString*  baseUrl = @"http://api.openweathermap.org";
static  NSString* currentDateUrl = @"/data/2.5/weather";
static  NSString* forecastUrl = @"/data/2.5/forecast/daily";
static  NSString* imageUrl =@"/img/w";

@implementation RequestManager


+ (RequestManager *)sharedWeatherHTTPClient
{
    static RequestManager *_sharedWeatherHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedWeatherHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        _sharedWeatherHTTPClient->isMetric = NO;
    });
    
    return _sharedWeatherHTTPClient;
}

-(void) setMetric:(BOOL)metric {
    isMetric = metric;
}


- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFCompoundResponseSerializer compoundSerializerWithResponseSerializers:@[[AFImageResponseSerializer serializer],[AFJSONResponseSerializer serializer]]];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}


-(void) getWeatherWithSubUrl:(NSString*)subUrl parameters:(NSDictionary*) parameters   {
    
    [self GET:subUrl parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//        if ([self.delegate respondsToSelector:@selector(requestManager: didUpdateWithData:)]) {
//            [self.delegate  requestManager:self didUpdateWithData:responseObject];
//        }
        NSLog(@"ok");
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
//        if ([self.delegate respondsToSelector:@selector(requestManager: didFailWithError:)]) {
//            [self.delegate  requestManager:self didFailWithError:error];
//        }
    }];
}

-(void) getDataWithSubPath:(NSString*)subUrl parameters:(NSDictionary*) parameters   completion :(void (^)(NSDictionary *, NSError *))completion {
    
    [self GET:subUrl parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        completion (responseObject,nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion (nil,error);
    }];
}

- (void)getWeatherByName:(NSString*) cityName
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    ///q=Yerevan,AM&units=metric
    parameters[@"q"] = cityName;
    parameters[@"format"] = @"json";
    if (isMetric) {
        parameters[@"units"] = @"metric";
    }
    
    [self getWeatherWithSubUrl:currentDateUrl parameters:parameters];
    
    
}

-(void) getCurrentWeatherByName:(NSString *) cityName completion :(void (^)(NSDictionary * dict, NSError * error))completion {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    ///q=Yerevan,AM&units=metric
    parameters[@"q"] = cityName;
    parameters[@"format"] = @"json";
    if (isMetric) {
        parameters[@"units"] = @"metric";
    }

  [self getDataWithSubPath:currentDateUrl parameters:parameters completion:^(NSDictionary * dictionary, NSError * err)  {
      completion(dictionary,err);
  }];
}

-(void) getForecastWeatherByName:(NSString *)cityName days:(NSUInteger)days completion:(void (^)(NSDictionary *, NSError *))completion {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    ///api.openweathermap.org/data/2.5/forecast/daily?q=London&mode=xml&units=metric&cnt=7
    parameters[@"q"] = cityName;
    parameters[@"cnt"] = [NSString stringWithFormat:@"%lu", days];
    if (isMetric) {
        parameters[@"units"] = @"metric";
    }
    [self getDataWithSubPath:forecastUrl parameters:parameters completion:^(NSDictionary * dictionary, NSError * err)  {
        completion(dictionary,err);
    }];

}


-(void) getImageWithId:(NSString*) imgId {
    
    NSURLRequest* request = [self.requestSerializer requestWithMethod:@"GET" URLString:@"http://openweathermap.org/img/w/10d.png" parameters:nil error:nil];
    //  [self setResponseSerializer:[AFImageResponseSerializer serializer]];
    NSURLSessionDataTask* dataTask = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nonnull responseObject, NSError * _Nonnull error) {
        UIImage* image = responseObject;
        
    }];
    [dataTask resume];
    
}

@end
