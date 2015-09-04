//
//  ZENWindow.m
//  Zen
//
//  Created by Wojciech Czekalski on 27.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "ZENWindow.h"
#import "XcodeViewControllers.h"
@import ObjectiveC;

@implementation ZENWindow

- (void)becomeMainWindow
{
    [super becomeMainWindow];
    
    void (*becomeMainWindowFunc)(id s, SEL selector) = (void *)class_getMethodImplementation([IDEWorkspaceWindow class], @selector(becomeMainWindow));
    becomeMainWindowFunc(self, @selector(becomeMainWindow));
}

- (BOOL)canBecomeMainWindow
{
    return YES;
}

- (void)toggleFullScreen:(id)sender
{
    [super toggleFullScreen:sender];
    
    if ((self.styleMask & NSFullScreenWindowMask) == NSFullScreenWindowMask) {
        self.collectionBehavior = self.collectionBehavior & ~NSWindowCollectionBehaviorFullScreenPrimary;
        
        [[self standardWindowButton:NSWindowZoomButton] setHidden:YES];
        [[self standardWindowButton:NSWindowMiniaturizeButton] setHidden:YES];
    }
}

- (BOOL)canBecomeKeyWindow
{
    return YES;
}

@end
