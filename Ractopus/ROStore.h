//
// Created by Ashok Gelal on 2/24/14.
// Copyright (c) 2014 Ashok Gelal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TrendingTimeperiod) {
    Today,
    ThisWeek,
    ThisMonth
};


@interface ROStore : NSObject
- (RACSignal *)trendingReposForTimeperiod:(TrendingTimeperiod)timeperiod andLanguage:(NSString *)language;

- (RACSignal *)trendingDevelopersForTimeperiod:(TrendingTimeperiod)timeperiod andLanguage:(NSString *)language;
@end