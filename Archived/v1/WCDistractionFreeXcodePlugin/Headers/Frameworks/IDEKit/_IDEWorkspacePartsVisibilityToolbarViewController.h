//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "DVTToolbarViewController.h"

@class DVTObservingToken;

@interface _IDEWorkspacePartsVisibilityToolbarViewController : DVTToolbarViewController
{
    DVTObservingToken *_navigatorVisibilityObservationToken;
    DVTObservingToken *_debuggerVisibilityObservationToken;
    DVTObservingToken *_utilitiesVisibilityObservationToken;
}

- (void).cxx_destruct;
- (BOOL)validateMenuItem:(id)arg1;
- (id)_menuItemTitleForSplitViewWithTag:(unsigned long long)arg1 state:(BOOL)arg2;
- (void)_menuItemAction:(id)arg1;
- (void)_segmentStateDidChange:(id)arg1;
- (void)_toggleStateForSplitViewWithTag:(unsigned long long)arg1;
- (id)_propertyNameForSplitViewWithTag:(unsigned long long)arg1;
- (id)menuForMenuFormRepresentation;
- (void)primitiveInvalidate;
- (id)_create1010AndLaterControl;
- (id)_createPre1010Control;
- (id)initWithToolbarItemIdentifier:(id)arg1 window:(id)arg2;
- (id)_imageFactoryForImageNamed:(id)arg1;
- (id)_viewUtilitiesImageFactory;
- (id)_viewDebugAreaImageFactory;
- (id)_viewNavigatorsImageFactory;

@end

