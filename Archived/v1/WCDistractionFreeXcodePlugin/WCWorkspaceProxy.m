//
//  WCWorkspaceProxy.m
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 09.03.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "WCWorkspaceProxy.h"
#import <objc/runtime.h>

@interface WCWorkspaceProxy ()
@property (nonatomic, strong) IDEWorkspace *workspace;
@property (nonatomic, strong) IDEWorkspaceDocument *workspaceDocument;
@end

@implementation WCWorkspaceProxy

- (instancetype)initWithWorkspace:(IDEWorkspace *)workspace workspaceDocument:(IDEWorkspaceDocument *)workspaceDocument windowController:(NSWindowController *)windowController
{
    NSParameterAssert(workspace);
    self.workspace = workspace;
    self.workspaceDocument = workspaceDocument;
    _windowController = windowController;
    return self;
}

#pragma mark - IDEEditorArea methods

// That's what basically IDEEditorArea's implementation does. In addition it calls IDEEditorModeViewController (yet another reference to parent) which performs the real action but we want ot keep the implementation as simple as possible.
// If you are interested (or something breaks here) check out IDEEditorArea's implementation of this method

- (void)_openEditorOpenSpecifier:(IDEEditorOpenSpecifier *)openSpecifier editorContext:(IDEEditorContext *)editorContext takeFocus:(BOOL)takeFocus
{
    if ([editorContext openEditorOpenSpecifier:openSpecifier]) {
        [editorContext takeFocus];
    }
}

- (id)editorArea
{
    return nil;
}

#pragma mark - Forwarding

- (BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL isValidSelector = [self isValidSelector:aSelector] || [self isValidSelectorForSelfForwarding:aSelector];
    return [super respondsToSelector:aSelector] || isValidSelector;
}

- (id)valueForKeyPath:(NSString *)keyPath
{
    return nil;
}

- (id)currentLaunchSession
{
    return nil;
}

- (void)addObserver:(id)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    
}

- (void)removeObserver:(id)observer forKeyPath:(NSString *)keyPath
{
}

- (id)editorModeViewController
{
    return nil;
}

- (id)currentDebuggingAdditionUIControllers
{
    return nil;
}


- (id)debugSessionController
{
    return nil;
}

- (void)_openEditorHistoryItem:(id)item editorContext:(IDEEditorContext *)editorContext takeFocus:(BOOL)takeFocus
{
    [editorContext openEditorHistoryItem:item]; 
    if (takeFocus) {
        [editorContext takeFocus];
    }
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    NSMethodSignature *signature = [NSClassFromString(@"IDEWorkspaceTabController") methodSignatureForSelector:sel];
    
    NSParameterAssert(signature);
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([self isValidSelector:invocation.selector]) {
        SEL selector = invocation.selector;
        IMP implementation = class_getMethodImplementation([self class], invocation.selector);
        NSParameterAssert(implementation);
        id (*functionFromImplementaion)(id, SEL) = (void *)implementation;
        id retVal = functionFromImplementaion(self, selector);
        [invocation setReturnValue:&retVal];
    } else if ([self isValidSelectorForSelfForwarding:invocation.selector]) {
        id selfObject = self;
        [invocation setReturnValue:&selfObject];
    } else if ([self shouldIgnoreSelector:invocation.selector]) {
        return;
    } else {
    NSAssert(NO, @"%@ is not handled by %@", NSStringFromSelector(invocation.selector), NSStringFromClass([self class]));
    }
}



- (BOOL)isValidSelector:(SEL)selector
{
    return selector == @selector(workspace) || selector == @selector(workspaceDocument);
}

- (BOOL)isValidSelectorForSelfForwarding:(SEL)selector
{
    return (selector == NSSelectorFromString(@"editorArea"));
}

- (BOOL)shouldIgnoreSelector:(SEL)selector
{
    return selector == @selector(debugSessionController);
}

@end
