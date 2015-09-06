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
#import "IDEEditor+ZENTextView.h"

@implementation ZENEditorWrapperViewController

- (instancetype)initWithEditorContext:(IDEEditorContext *)editorContext editorDependencyManager:(ZENIDEEditorContextDependencyManager *)dependencyManager barsController:(ZENBarsController *)barsController;
{
    self = [super init];
    
    if (self) {
        _editorContext = editorContext;
        _dependencyMangager = dependencyManager;
        _barsController = barsController;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualTo:@"frame"] && object == self.view) {
        self.editorContext.view.frame = self.view.bounds;
        [self.barsController layout];
    }
}

- (void)loadView
{
    self.view = [[ZENEditorWrapperView alloc] initWithViewController:self];
    
    [self.view addObserver:self forKeyPath:@"frame" options:0 context:NULL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addChildViewController:self.editorContext];
    [self.view addSubview:self.editorContext.view];
    
    self.editorContext.view.frame = self.view.bounds;
    self.editorContext.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.barsController hideBars];
}

- (void)viewWillAppear
{
    [super viewWillAppear];
    [[[self.barsController.editorContext.editor zen_textView] enclosingScrollView] setScrollerStyle:NSScrollerStyleOverlay];
}

- (void)viewWillDisappear
{
    [super viewWillDisappear];
    [self.view removeObserver:self forKeyPath:@"frame"];
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

- (void)primitiveInvalidate {}

@end
