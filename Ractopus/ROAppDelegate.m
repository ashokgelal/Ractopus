//
//  ROAppDelegate.m
//  Ractopus
//
//  Created by Ashok Gelal on 2/23/14.
//  Copyright (c) 2014 Ashok Gelal. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa/RACStream.h>
#import <ReactiveCocoa/ReactiveCocoa/RACSignal.h>
#import "ROAppDelegate.h"
#import "ROLanguageTableViewController.h"
#import "ROStore.h"

@interface ROAppDelegate ()
@property(weak) IBOutlet ROLanguageTableViewController *languageTableViewController;
@property(weak) IBOutlet NSComboBox *trendingActorComboBox;
@property(weak) IBOutlet NSComboBox *trendingTimelineComboBox;

@end

@implementation ROAppDelegate {
    ROStore *_store;
}

- (void)awakeFromNib {
    _store = [[ROStore alloc] init];
    [self.trendingActorComboBox selectItemAtIndex:0];
    [self.trendingTimelineComboBox selectItemAtIndex:0];
    [[self.languageTableViewController.languageSelectedSignal distinctUntilChanged] subscribeNext:^(id x) {
        NSLog(@"Language '%@' selected", x);
        [[_store trendingReposForTimeperiod:Today andLanguage:x] subscribeNext:^(id y) {
            NSLog(@"foo");
        }];
    }];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

@end