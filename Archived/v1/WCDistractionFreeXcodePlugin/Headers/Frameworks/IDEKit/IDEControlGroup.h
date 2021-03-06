//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "DVTBorderedView.h"

@class NSArray, NSColor;

@interface IDEControlGroup : DVTBorderedView
{
    BOOL _drawsInnerBorders;
    NSColor *_innerBorderColor;
    NSColor *_innerInactiveBorderColor;
    int _solidBorderSides;
}

@property int solidBorderSides; // @synthesize solidBorderSides=_solidBorderSides;
@property(copy) NSColor *innerInactiveBorderColor; // @synthesize innerInactiveBorderColor=_innerInactiveBorderColor;
@property(copy) NSColor *innerBorderColor; // @synthesize innerBorderColor=_innerBorderColor;
@property(nonatomic) BOOL drawsInnerBorders; // @synthesize drawsInnerBorders=_drawsInnerBorders;
- (void).cxx_destruct;
- (BOOL)isShowingShadow;
- (void)setShadowSides:(int)arg1;
- (void)setShadowColor:(id)arg1;
- (void)setInactiveBackgroundGradient:(id)arg1;
- (void)setInactiveBackgroundColor:(id)arg1;
- (void)setBackgroundGradient:(id)arg1;
- (void)setBackgroundColor:(id)arg1;
- (void)setBorderSides:(int)arg1;
- (void)setAllInactiveBordersToColor:(id)arg1;
- (void)setAllBordersToColor:(id)arg1;
- (void)drawRect:(struct CGRect)arg1;
- (void)controlViewDidResize:(id)arg1;
- (unsigned long long)numberOfControlViews;
@property(readonly) NSArray *controlViews;
- (void)removeControlView:(id)arg1;
- (void)addControlViewLast:(id)arg1;
- (void)addControlViewFirst:(id)arg1;
- (void)_addControlView:(id)arg1 isFirst:(BOOL)arg2;
- (id)_borderedViewForControlView:(id)arg1;
- (void)layoutBottomUp;
- (void)layoutTopDown;
- (void)_propagateDrawingPropertiesToSubview:(id)arg1;
- (id)initWithFrame:(struct CGRect)arg1;

@end

