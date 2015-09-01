//
//  ZENViewController.m
//  Zen
//
//  Created by Wojciech Czekalski on 15.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "ZENViewController.h"
#import "ZENContainerView.h"
#import "ZENMouseInteractionView.h"

@implementation ZENViewController

- (instancetype)initWithEditorViewController:(NSViewController *)editorViewController layout:(id<ZENEditorLayout>)layout backgroundColor:(NSColor *)backgroundColor interfaceController:(id<ZENInterfaceController>)interfaceController __attribute__((nonnull));
{
    NSParameterAssert(editorViewController);
    NSParameterAssert(layout);
    NSParameterAssert(backgroundColor);
    NSParameterAssert(interfaceController);
    
    self = [super init];
    
    if (self) {
        _editorViewController = editorViewController;
        _layout = layout;
        _backgroundColor = backgroundColor;
        _interfaceController = interfaceController;
    }

    return self;
}

- (void)loadView
{
    ZENMouseInteractionView *interactionView = [[ZENMouseInteractionView alloc] initWithInterfaceController:self.interfaceController];
    ZENContainerView *view = [[ZENContainerView alloc] init];
    view.backgroundColor = self.backgroundColor;
    view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    [interactionView addSubview:view];
    
    self.view = interactionView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addChildViewController:self.editorViewController];
    [self.view addSubview:self.editorViewController.view];
}

- (void)viewWillLayout
{
    [super viewWillLayout];
    [self performLayout];
}

- (void)performLayout
{
    self.editorViewController.view.frame = [self.layout editorRectInBounds:self.view.bounds];
}
    
@end
