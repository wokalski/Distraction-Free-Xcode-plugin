//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSButton.h"

#import "DVTWindowActivationStateObserver.h"

@class NSColor, NSString;

@interface IDEButtonWithBackgroundColor : NSButton <DVTWindowActivationStateObserver>
{
    id <DVTCancellable> _windowActivationObservation;
    NSColor *_backgroundColor;
    NSColor *_inactiveBackgroundColor;
}

@property(retain) NSColor *inactiveBackgroundColor; // @synthesize inactiveBackgroundColor=_inactiveBackgroundColor;
@property(retain) NSColor *backgroundColor; // @synthesize backgroundColor=_backgroundColor;
- (void).cxx_destruct;
- (void)window:(id)arg1 didChangeActivationState:(long long)arg2;
- (void)viewWillMoveToWindow:(id)arg1;
- (BOOL)isOpaque;
- (void)dealloc;
- (void)drawRect:(struct CGRect)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

