//
//  ZENIDEEditorContextDependencyManager.m
//  Zen
//
//  Created by Wojciech Czekalski on 27.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "ZENIDEEditorContextDependencyManager.h"
#import "XcodeHeaders.h"


@implementation ZENIDEEditorContextDependencyManager

- (instancetype)initWithWorkspaceDocument:(IDEWorkspaceDocument *)workspaceDocument
{
    self = [super init];
    
    if (self) {
        _workspaceDocument = workspaceDocument;
    }
    return self;
}

#pragma mark - there's where the super-vulnerable stuff is.

// That's what basically IDEEditorArea's implementation does. In addition it calls IDEEditorModeViewController (yet another reference to parent) which performs the real action but we want ot keep the implementation as simple as possible.
// If you are interested (or something breaks here) check out IDEEditorArea's implementation of this method

- (void)_openEditorOpenSpecifier:(IDEEditorOpenSpecifier *)openSpecifier editorContext:(IDEEditorContext *)editorContext takeFocus:(BOOL)takeFocus
{
    if ([editorContext openEditorOpenSpecifier:openSpecifier]) {
        [editorContext takeFocus];
    }
}

// Checking whether a component is "valid" is omnipresent in IDEKit
- (BOOL)isValid
{
    return YES;
}

- (id)currentLaunchSession
{
    return nil;
}

- (id)editorModeViewController
{
    return nil;
}

- (IDEWorkspace *)workspace
{
    return self.workspaceDocument.workspace;
}

#pragma mark -

// Returning self here as those are some nested IDEEditorContext's dependencies accessed through `IDEWorkspaceTabController`

- (id)windowController
{
    return self;
}

- (id)editorArea
{
    return self;
}

@end
