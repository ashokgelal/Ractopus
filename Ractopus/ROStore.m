//
// Created by Ashok Gelal on 2/24/14.
// Copyright (c) 2014 Ashok Gelal. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa/RACSignal.h>
#import "ROStore.h"
#import "ROWebService.h"


@implementation ROStore {
    ROWebService *_webService;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _webService = [[ROWebService alloc] init];
    }
    return self;
}

- (RACSignal *)trendingReposForTimeperiod:(TrendingTimeperiod)timeperiod andLanguage:(NSString *)language {
    NSInteger offset = -1000;
    switch (timeperiod) {
        case Today: {
            offset = 0;
            break;
        }
        case ThisWeek: {
            offset = -7;
            break;
        }
        case ThisMonth: {
            offset = -30;
            break;
        }
    }
    if (offset == -1000)
        @throw @"Invalid Timeperiod for fetching trending repositories";
    if ([[language uppercaseString] isEqualToString:@"ALL"])
        language = nil;
    RACSignal *signal = [_webService fetchTrendingReposForDate:[ROStore getDateStringWithDaysOffset:offset] andLanguage:language];
    return [self reposForSignal:signal];
}


- (RACSignal *)trendingDevelopersForTimeperiod:(TrendingTimeperiod)timeperiod andLanguage:(NSString *)language {
    NSInteger offset = -1000;
    switch (timeperiod) {
        case Today: {
            offset = 0;
            break;
        }
        case ThisWeek: {
            offset = -7;
            break;
        }
        case ThisMonth: {
            offset = -30;
            break;
        }
    }
    if (offset == -1000)
        @throw @"Invalid Timeperiod for fetching trending repositories";
    if ([[language uppercaseString] isEqualToString:@"ALL"])
        language = nil;
    RACSignal *signal = [_webService fetchTrendingDevelopersForDate:[ROStore getDateStringWithDaysOffset:offset] andLanguage:language];
    return [self developersForSignal:signal];
}

- (RACSignal *)reposForSignal:(RACSignal *)signal {
    return [signal map:^id(id value) {
        return @{@"foo" : @"bar"};
    }];
}

- (RACSignal *)developersForSignal:(RACSignal *)signal {
    return [signal map:^id(id value) {
        return @{@"foo" : @"bar"};
    }];
}

+ (NSString *)getDateStringWithDaysOffset:(NSInteger)offset {
    NSDate *currentDate = [NSDate date];

    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:offset];
    NSDate *outDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:currentDate options:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:outDate];
}

@end