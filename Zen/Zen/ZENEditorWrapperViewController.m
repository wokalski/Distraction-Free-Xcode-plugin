//
//  ZENEditorWrapperViewController.m
//  Zen
//
//  Created by Wojciech Czekalski on 23.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "ZENEditorWrapperViewController.h"
#import "ZENEditorWrapperView.h"

@implementation ZENEditorWrapperViewController

@synthesize workspaceDocument = _workspaceDocument;

- (instancetype)initWithEditorContext:(IDEEditorContext *)editorContext workspaceDocument:(IDEWorkspaceDocument *)workspaceDocument
{
    self = [super init];
    
    if (self) {
        _editorContext = editorContext;
        _workspaceDocument = workspaceDocument;
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
}

- (void)viewWillLayout
{
    [super viewWillLayout];
    
    self.editorContext.view.frame = self.view.bounds;
    self.editorContext.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
}

#pragma mark - Xcode hacking


// IDEWorkspaceDocumentProvider protocol.
// This controller is set as the document provider for the wrapped IDEEditorContext
// More info: ./Reverse Engineering/IDEKit
- (IDEWorkspaceDocument *)workspaceDocument
{
    return _workspaceDocument;
}

@end
