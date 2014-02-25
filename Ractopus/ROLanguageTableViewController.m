//
//  ROLanguageTableViewController.m
//  Ractopus
//
//  Created by Ashok Gelal on 2/23/14.
//  Copyright (c) 2014 Ashok Gelal. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa/RACSignal.h>
#import "ROLanguageTableViewController.h"
#import "NSObject+RACPropertySubscribing.h"

@interface ROLanguageTableViewController ()
@property(readwrite, copy, nonatomic) NSString *currentLanguage;
@property(readwrite) RACSignal *languageSelectedSignal;
@property(weak) IBOutlet NSTableView *tableView;
@end

@implementation ROLanguageTableViewController {
    NSArray *_languages;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _languages = @[@"ALL", @"C", @"C#", @"C++", @"Clojure", @"CoffeeScript", @"CSS", @"Emacs Lisp", @"Go", @"Groovy", @"Haskell", @"Java", @"JavaScript", @"Lua", @"Matlab", @"Objective-C", @"OCaml", @"Perl", @"PHP", @"Prolog", @"Puppet", @"Python", @"R", @"Ruby", @"Scala", @"Shell", @"VimL"];
    }
    self.languageSelectedSignal = [RACObserve(self, self.currentLanguage) ignore:nil];
    return self;
}

- (void)awakeFromNib {
    [self reset];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _languages.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return [_languages objectAtIndex:(NSUInteger) row];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSTableView *tableView = [notification object];
    self.currentLanguage = [_languages objectAtIndex:(NSUInteger) [tableView selectedRow]];
}

- (void)reset {
    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
}

@end
