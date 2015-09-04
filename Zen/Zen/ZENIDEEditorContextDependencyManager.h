//
//  ZENIDEEditorContextDependencyManager.h
//  Zen
//
//  Created by Wojciech Czekalski on 27.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XcodeModels.h"

@class IDELaunchSession, IDEEditorContext;

// This class is provides false SOC. ZENEditorWrapperViewController depends on a class with this type so it's not about flexibility. It's about having smaller classes, it's easier for me to think about this class as a module which provides dependencies for IDEEditorContext.
// IDEEditorContext depends heavily on `IDEWorkspaceTabController`. This class provides IDEEditorContext with the same dependencies as `IDEWorkspaceTabController`. They are usually stubs or nils.
// Rationale behind creating ZEN's own class instead of using `IDEWorkspaceTabController` is better control. We can hopefully see and fix what's wrong.

// The header file is limited to methods which have to be public.
// See .m file for more insight how it works.
@interface ZENIDEEditorContextDependencyManager : NSObject

@property (nonatomic, strong, readonly) IDEWorkspaceDocument *workspaceDocument;
@property (nonatomic, weak, readonly) IDEEditorContext *editorContext;

- (instancetype)initWithWorkspaceDocument:(IDEWorkspaceDocument *)workspaceDocument editorContext:(IDEEditorContext *)editorContext;

- (IDELaunchSession *)currentLaunchSession;

@end
