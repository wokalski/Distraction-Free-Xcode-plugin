    //
//  WCContainerView.m
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 03.04.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "WCContainerView.h"

@implementation WCContainerView
@synthesize viewController = _viewController;

- (instancetype)initWithViewController:(NSViewController *)viewController
{
    self = [super init];
    if (self) {
        _viewController = viewController;
    }
    return self;
}

- (NSViewController *)viewController
{
    return _viewController;
}

@end
