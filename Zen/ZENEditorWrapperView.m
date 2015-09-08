//
//  ZENEditorWrapperView.m
//  Zen
//
//  Created by Wojciech Czekalski on 23.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "ZENEditorWrapperView.h"

@implementation ZENEditorWrapperView

- (instancetype)initWithViewController:(NSViewController *)viewController
{
    self = [super init];
    
    if (self) {
        _viewController = viewController;
    }
    return self;
}

@end
