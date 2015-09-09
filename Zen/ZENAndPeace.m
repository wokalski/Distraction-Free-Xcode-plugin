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
    IDEEditorContext *editorContext = self.barsController.editorContext;
    CGPoint location = event.locationInWindow;
    
    NSView *editorContextView = editorContext.view;
    CGRect frameInWindow = [editorContext.view convertRect:editorContextView.bounds toView:nil];
    
    NSView *sidebarView = editorContext.sidebarView;
    CGRect sideBarViewFrame = [sidebarView.superview convertRect:sidebarView.frame toView:nil];
    
    if (CGRectContainsPoint(sideBarViewFrame, location)) {
        [self.eventScheduler cancel];
        [self.barsController showBars];
    } else if (CGRectContainsPoint(frameInWindow, location) == NO) {
        [self.barsController showBars];
        [self.eventScheduler scheduleAfter:1.5f];
    } else {
        [self.eventScheduler scheduleAfter:1.5f];
    }
}

@end
