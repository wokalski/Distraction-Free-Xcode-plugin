//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSView.h"

@class NSTrackingArea;

@interface _IDESharedTestPerfMetricIterationNumberView : NSView
{
    NSTrackingArea *_trackingArea;
    BOOL _selected;
    unsigned long long _iterationNumber;
    CDUnknownBlockType _numberClickedCallback;
}

@property(copy) CDUnknownBlockType numberClickedCallback; // @synthesize numberClickedCallback=_numberClickedCallback;
@property unsigned long long iterationNumber; // @synthesize iterationNumber=_iterationNumber;
- (void).cxx_destruct;
- (void)mouseUp:(id)arg1;
- (void)mouseExited:(id)arg1;
- (void)mouseEntered:(id)arg1;
- (void)updateTrackingAreas;
- (void)drawRect:(struct CGRect)arg1;
- (void)select;
- (void)deselect;

@end

