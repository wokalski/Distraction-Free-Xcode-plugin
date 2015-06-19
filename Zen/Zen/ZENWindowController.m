//
//  ZENWindowController.m
//  Zen
//
//  Created by Wojciech Czekalski on 19.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "ZENWindowController.h"

/*  This class is only needed to support view resizing. It can be done in numerous ways, but surprisingly none of them is clean - i.e. doesn't involve view controller knowing that it's window is the contentView, or doesn't include bubbling up an event using a delegate from the view.
    The other way would be to use auto layout for everything but it would be an unneccessary overhead IMO.
*/

@implementation ZENWindowController

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
