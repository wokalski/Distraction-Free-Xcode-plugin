//
//  ZENAndPeace.m
//  Zen
//
//  Created by Wojciech Czekalski on 04.08.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "ZENAndPeace.h"

@implementation ZENAndPeace

- (instancetype)initWithBarsController:(ZENBarsController *)barsController
{
    self = [super init];
    
    if (self) {
        _barsController = barsController;
        _eventScheduler = [[ZENEventScheduler alloc] initWithTarget:barsController selector:@selector(hideBars)];
    }
    return self;
}

- (void)mouseMoved:(NSEvent *)event
{
    [self.barsController showBars];
    [self.eventScheduler scheduleAfter:1.5f];
}

@end
