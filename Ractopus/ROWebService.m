//
// Created by Ashok Gelal on 2/24/14.
// Copyright (c) 2014 Ashok Gelal. All rights reserved.
//

#import "ROWebService.h"
#import "RACSignal+Operations.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "RACSubscriber.h"
#import "RACDisposable.h"

@interface ROWebService () <NSURLSessionDelegate>
@end

@implementation ROWebService {
}
NSString *const kROWebServiceErrorInfoOperationKey = @"ROWebServiceErrorInfoOperationKey";
static NSString *const kSearchApiBaseUrl = @"https://api.github.com/search";

- (RACSignal *)fetchTrendingDevelopersForDate:(NSString *)createdDate andLanguage:(NSString *)language {
    return [[RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        NSString *createdParm = [NSString stringWithFormat:@"created:>%@", createdDate];
        if (language) {
            createdParm = [NSString stringWithFormat:@"%@+language:%@", createdParm, language];
        }

        NSDictionary *parameters = @{@"q" : createdParm, @"sort" : @"stars", @"order" : @"desc"};
        NSString *url = [[NSString alloc] initWithFormat:@"%@/developers", kSearchApiBaseUrl];

        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperationManager manager] GET:url parameters:parameters success:^(AFHTTPRequestOperation *op, id responseObject) {
            NSLog(@"Fetch Trending Repositories for DateFormat %@ succeeded", createdDate);
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];

        }                                                                        failure:^(AFHTTPRequestOperation *op, NSError *error) {

            NSMutableDictionary *userInfo = [error.userInfo mutableCopy] ?: [NSMutableDictionary dictionary];
            userInfo[kROWebServiceErrorInfoOperationKey] = op;
            NSError *errorWithOperation = [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo];
            NSLog(@"Error Fetching Trending Repositories for DateFormat %@", createdDate);
            [subscriber sendError:errorWithOperation];

        }];

        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];

    }

    ] replayLazily];
}

- (RACSignal *)fetchTrendingReposForDate:(NSString *)createdDate andLanguage:(NSString *)language {
    return [[RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

        NSString *createdParm = [NSString stringWithFormat:@"created:%@", createdDate];
        NSMutableDictionary *parameters = [@{@"q" : createdParm, @"sort" : @"stars", @"order" : @"desc"} mutableCopy];
        if (language) {
            parameters[@"language"] = language;
        }
        NSString *url = [[NSString alloc] initWithFormat:@"%@/repositories", kSearchApiBaseUrl];

        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperationManager manager] GET:url parameters:parameters success:^(AFHTTPRequestOperation *op, id responseObject) {
            NSLog(@"Fetch Trending Repositories for DateFormat %@ succeeded", createdDate);
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];

        }   failure:^(AFHTTPRequestOperation *op, NSError *error) {

            NSMutableDictionary *userInfo = [error.userInfo mutableCopy] ?: [NSMutableDictionary dictionary];
            userInfo[kROWebServiceErrorInfoOperationKey] = op;
            NSError *errorWithOperation = [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo];
            NSLog(@"Error Fetching Trending Repositories for DateFormat %@", createdDate);
            [subscriber sendError:errorWithOperation];

        }];

        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];

    }] replayLazily];
}

@end
