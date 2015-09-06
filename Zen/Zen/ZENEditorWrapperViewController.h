//
//  ZENEditorWrapperViewController.h
//  Zen
//
//  Created by Wojciech Czekalski on 23.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "IDEEditorContext.h"
#import "XcodeHeaders.h"
#import "ZENIDEEditorContextDependencyManager.h"
#import "ZENBarsController.h"

// This class acts as a wrapper view controller for IDEEditorContext. It is a "proxy" when resolving editor's dependencies. Check out .m file for more insight
@interface ZENEditorWrapperViewController : NSViewController <IDEWorkspaceDocumentProvider, DVTInvalidation>

- (instancetype)initWithEditorContext:(IDEEditorContext *)editorContext editorDependencyManager:(ZENIDEEditorContextDependencyManager *)dependencyManager barsController:(ZENBarsController *)barsController;

@property (nonatomic, strong, readonly) ZENIDEEditorContextDependencyManager *dependencyMangager;
@property (nonatomic, strong, readonly) IDEEditorContext *editorContext;
@property (nonatomic, strong, readonly) ZENBarsController *barsController;

// BADTHINGSWARNING
// Calling this method with `[IDEWorkspaceTabController class]` will also return `true`
- (BOOL)isKindOfClass:(Class)aClass;

@end
