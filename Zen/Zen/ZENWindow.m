//
//  ZENWindow.m
//  Zen
//
//  Created by Wojciech Czekalski on 27.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "ZENWindow.h"

@implementation ZENWindow

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
