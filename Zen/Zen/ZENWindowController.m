//
//  ZENWindowController.m
//  Zen
//
//  Created by Wojciech Czekalski on 19.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "ZENWindowController.h"

@implementation ZENWindowController

- (instancetype)initWithWindow:(NSWindow *)window dependencyManager:(ZENIDEEditorContextDependencyManager *)dependencyManager
{
    self = [super initWithWindow:window];
    if (self) {
        _dependencyManager = dependencyManager;
    }
    return self;
}

#pragma mark - Open Quickly

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.dependencyManager;
}

#pragma mark - Layout

- (void)setWindow:(NSWindow *)window
{
    if (self.window == nil && window != nil) {
        [window addObserver:self forKeyPath:ZENContentLayoutRectPropertyString() options:0 context:NULL];
    } else {
        [self.window removeObserver:self forKeyPath:ZENContentLayoutRectPropertyString()];
    }
    [super setWindow:window]; 
}

- (void)dealloc
{
    [self.window removeObserver:self forKeyPath:ZENContentLayoutRectPropertyString()];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:ZENContentLayoutRectPropertyString()]) {
        [self.window.contentView setNeedsLayout:YES];
    }
}

#pragma mark -

static NSString * ZENContentLayoutRectPropertyString(void) {
    return NSStringFromSelector(@selector(contentLayoutRect));
}

@end
