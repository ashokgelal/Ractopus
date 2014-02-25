//
//  ROLanguageTableViewController.h
//  Ractopus
//
//  Created by Ashok Gelal on 2/23/14.
//  Copyright (c) 2014 Ashok Gelal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface ROLanguageTableViewController : NSObject <NSTableViewDataSource, NSTableViewDelegate>
@property(readonly) RACSignal *languageSelectedSignal;

- (void)reset;
@end
