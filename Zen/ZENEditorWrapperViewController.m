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
#import "ZENContainerView.h"

@interface ZENEditorWrapperViewController ()

@property (nonatomic, strong) NSLayoutConstraint *xPositionConstraint;
@property (nonatomic, strong) NSLayoutConstraint *yPositionConstraint;
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *widthConstraint;

@end

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

- (void)loadView
{
    self.view = [[ZENEditorWrapperView alloc] initWithViewController:self];
    
    [self addChildViewController:self.editorContext];

    [self.view addSubview:self.editorContext.view];
    
    self.editorContext.view.frame = self.view.bounds;
    self.view.autoresizesSubviews = YES;
    self.editorContext.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.barsController hideBars];
}

- (void)viewWillAppear
{
    [super viewWillAppear];
    [[[self.barsController.editorContext.editor zen_textView] enclosingScrollView] setScrollerStyle:NSScrollerStyleOverlay];
}

- (void)viewWillLayout {
    [self.barsController layout];
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
