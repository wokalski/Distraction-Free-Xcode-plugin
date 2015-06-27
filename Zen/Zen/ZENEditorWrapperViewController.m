//
//  ZENEditorWrapperViewController.m
//  Zen
//
//  Created by Wojciech Czekalski on 23.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "ZENEditorWrapperViewController.h"
#import "ZENEditorWrapperView.h"
#import "XcodeViewControllers.h"

@implementation ZENEditorWrapperViewController

- (instancetype)initWithEditorContext:(IDEEditorContext *)editorContext editorDependencyManager:(ZENIDEEditorContextDependencyManager *)dependencyManager;
{
    self = [super init];
    
    if (self) {
        _editorContext = editorContext;
        _dependencyMangager = dependencyManager;
    }
    return self;
}

- (void)loadView
{
    self.view = [[ZENEditorWrapperView alloc] initWithViewController:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addChildViewController:self.editorContext];
    [self.view addSubview:self.editorContext
     .view];
    
    self.editorContext.view.frame = self.view.bounds;
    self.editorContext.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
}

#pragma mark - Xcode hacking

// IDEWorkspaceDocumentProvider protocol.
// This controller is set as the document provider for the wrapped IDEEditorContext
// More info: ./Reverse Engineering/IDEKit
- (IDEWorkspaceDocument *)workspaceDocument
{
    return self.dependencyMangager.workspaceDocument;
}

// This is super bad
// I'm a bad ass now
// Xcode does a recursive search through the view (effectively view controller) hierarchy to find the nearest `IDEWorkspaceTabController` instance.
// We pretend this is IDEWorkspaceController. We will forward all calls in -forwardingTargetForSelector:
- (BOOL)isKindOfClass:(Class)aClass
{
    return [super isKindOfClass:aClass] || [aClass isSubclassOfClass:[IDEWorkspaceTabController class]];
}

// The dependency manager handles calls to `IDEWorkspaceTabController`. An instance of this class pretends to be an IDEWorkspaceTabController instance and therefore receives those methods from within IDEEditorContext.
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.dependencyMangager;
}

// IDEEditorContext asks IDEWorkspaceTabController for a value for this key. Therefore message forwarding doesn't work in this case.
- (id)currentLaunchSession
{
    return [self.dependencyMangager currentLaunchSession];
}

@end
