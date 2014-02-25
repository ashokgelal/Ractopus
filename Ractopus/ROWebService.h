//
// Created by Ashok Gelal on 2/24/14.
// Copyright (c) 2014 Ashok Gelal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa/RACSignal.h>

extern NSString *const kROWebServiceErrorInfoOperationKey;
@interface ROWebService : NSObject
- (RACSignal *)fetchTrendingDevelopersForDate:(NSString *)createdDate andLanguage:(NSString *)language;

- (RACSignal *)fetchTrendingReposForDate:(NSString *)createdDate andLanguage:(NSString *)language;
@end