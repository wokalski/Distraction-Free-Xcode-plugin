//
//  ZENEventScheduler.h
//  Zen
//
//  Created by Wojciech Czekalski on 28.07.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZENEventScheduler : NSObject

@property (nonatomic, strong, readonly) id target;
@property (nonatomic, assign, readonly) SEL selector;

- (instancetype)initWithTarget:(id)target selector:(SEL)sel;

- (void)scheduleAfter:(NSTimeInterval)time;
- (void)cancel;

@end
