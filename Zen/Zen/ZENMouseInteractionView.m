//
//  ZENMouseInteractionView.m
//  Zen
//
//  Created by Wojciech Czekalski on 28.07.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "ZENMouseInteractionView.h"

@implementation ZENMouseInteractionView

- (instancetype)initWithInterfaceController:(id<ZENInterfaceController>)interfaceController
{
    self = [super init];
    
    if (self) {
        _interfaceController = interfaceController;
        
        NSTrackingArea *mouseMovedTrackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds] options:NSTrackingActiveInActiveApp | NSTrackingMouseMoved owner:self userInfo:nil];
        [self addTrackingArea:mouseMovedTrackingArea];
    }
    
    return self;
}

- (void)updateTrackingAreas
{
    [super updateTrackingAreas];
    
    NSArray *trackingAreas = [self.trackingAreas copy];
    
    for (NSTrackingArea *trackingArea in trackingAreas) {
        [self removeTrackingArea:trackingArea];
        [self addTrackingArea:[[NSTrackingArea alloc] initWithRect:[self bounds] options:trackingArea.options owner:trackingArea.owner userInfo:trackingArea.userInfo]];
    }
}

- (void)mouseMoved:(NSEvent *)theEvent
{
    [self.interfaceController mouseMoved:theEvent];
}

@end
