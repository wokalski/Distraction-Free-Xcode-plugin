//
//  ZENEventScheduler.m
//  Zen
//
//  Created by Wojciech Czekalski on 28.07.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "ZENEventScheduler.h"

@interface ZENEventScheduler ()
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation ZENEventScheduler

- (instancetype)initWithTarget:(id)target selector:(SEL)sel
{
    self = [super init];
    
    if (self) {
        _target = target;
        _selector = sel;
    }
    return self;
}

- (void)scheduleAfter:(NSTimeInterval)time
{
    [self cancel];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self.target selector:self.selector userInfo:nil repeats:NO];
}

- (void)cancel
{
    [self.timer invalidate];
}

@end
