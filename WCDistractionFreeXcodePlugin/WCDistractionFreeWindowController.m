    //
//  WCDistractionFreeWindowController.m
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 06.01.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "WCDistractionFreeWindowController.h"
#import "WCDistractionFreeEditorController.h"
#import "WCXcodeHeaders.h"
#import "WCEditorConfiguration.h"
#import "WCWorkspaceProxy.h"

@interface WCDistractionFreeWindowController () <IDEWorkspaceDocumentProvider>
@property (nonatomic, weak) WCDistractionFreeEditorController *distractionFreeViewController;
@property (nonatomic, strong, readonly) IDEWorkspaceDocument *workspaceDocumentLocal;
@end

@implementation WCDistractionFreeWindowController
@synthesize workspaceDocumentLocal = _workspaceDocumentLocal;

- (instancetype)initWithWindow:(NSWindow *)window document:(IDEWorkspaceDocument *)document
{
    self = [super initWithWindow:window];
    if (self) {
        NSParameterAssert(document);
        _workspaceDocumentLocal = document;
    }
    return self;
}

- (void)setWorkspaceDocumentLocal:(IDEWorkspaceDocument *)doc
{
    _workspaceDocumentLocal = doc;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    self.distractionFreeViewController = (WCDistractionFreeEditorController *)self.contentViewController;
    
    WCWorkspaceProxy *proxy = [[WCWorkspaceProxy alloc] initWithWorkspace:[[self class] currentWorkspace] workspaceDocument:[[[self class] currentWorkspaceWindowController] document] windowController:self];
    
    WCEditorConfiguration *configuration = [[WCEditorConfiguration alloc] initWithConfigurationBuilder:^(WCEditorConfigurationBuilder *configuration) {
        configuration.greatestDocumentAncestor = [[[self class] currentEditorContext] greatestDocumentAncestor];
        configuration.tabController = (IDEWorkspaceTabController *)proxy;
    }];
    
    [self.distractionFreeViewController setConfiguration:configuration];
}

- (IDEWorkspaceDocument *)workspaceDocument
{
    return [(WCWorkspaceProxy *)self.distractionFreeViewController.configuration.tabController workspaceDocument];
}

- (IDEWorkspace *)workspace
{
    return [[self class] currentWorkspace];
}

+ (IDEWorkspaceWindow *)currentWindow {
    NSWindow *keyWindow = [[NSApplication sharedApplication] keyWindow];
    if ([keyWindow isKindOfClass:NSClassFromString(@"IDEWorkspaceWindow")]) {
        return (IDEWorkspaceWindow *)keyWindow;
    }
    return nil;
}

+ (NSResponder *)currentWindowResponder {
    return [[self currentWindow] firstResponder];
}

+ (NSMenu *)mainMenu {
    return [NSApp mainMenu];
}

+ (NSMenuItem *)getMainMenuItemWithTitle:(NSString *)title {
    return [[self mainMenu] itemWithTitle:title];
}

+ (IDEWorkspaceWindowController *)currentWorkspaceWindowController {
    NSWindowController *result = [NSClassFromString(@"IDEWorkspaceWindow") lastActiveWorkspaceWindowController];
    if ([result isKindOfClass:NSClassFromString(@"IDEWorkspaceWindowController")]) {
        return (IDEWorkspaceWindowController *)result;
    }
    return nil;
}

+ (IDEEditorArea *)currentEditorArea {
    return [self currentWorkspaceWindowController].editorArea;
}

+ (IDEEditorContext *)currentEditorContext {
    return [self currentEditorArea].lastActiveEditorContext;
}

+ (IDEEditor *)currentEditor {
    return [self currentEditorContext].editor;
}

+ (IDEWorkspace *)currentWorkspace
{
    return [[[self currentWorkspaceWindowController] document] workspace];
}

+ (IDESourceCodeDocument *)currentSourceCodeDocument {
    if ([[self currentEditor] isKindOfClass:NSClassFromString(@"IDESourceCodeEditor")]) {
        return ((IDESourceCodeEditor *)[self currentEditor]).sourceCodeDocument;
    } else if ([[self currentEditor] isKindOfClass:
                NSClassFromString(@"IDESourceCodeComparisonEditor")]) {
        IDEEditorDocument *document =
        ((IDESourceCodeComparisonEditor *)[self currentEditor]).primaryDocument;
        if ([document isKindOfClass:NSClassFromString(@"IDESourceCodeDocument")]) {
            return (IDESourceCodeDocument *)document;
        }
    }
    return nil;
}

+ (DVTSourceTextView *)currentSourceTextView {
    if ([[self currentEditor] isKindOfClass:NSClassFromString(@"IDESourceCodeEditor")]) {
        return ((IDESourceCodeEditor *)[self currentEditor]).textView;
    } else if ([[self currentEditor] isKindOfClass:
                NSClassFromString(@"IDESourceCodeComparisonEditor")]) {
        return ((IDESourceCodeComparisonEditor *)[self currentEditor]).keyTextView;
    }
    return nil;
}

+ (DVTTextStorage *)currentTextStorage {
    NSTextView *textView = [self currentSourceTextView];
    if ([textView.textStorage isKindOfClass:NSClassFromString(@"DVTTextStorage")]) {
        return (DVTTextStorage *)textView.textStorage;
    }
    return nil;
}

+ (NSScrollView *)currentScrollView {
    NSView *view = [self currentSourceTextView];
    return [view enclosingScrollView];
}

- (void)userWantsBreakpointsActivated
{
    
}

- (id)activeWorkspaceTabController
{
    return [[WCWorkspaceProxy alloc] initWithWorkspace:self.workspaceDocument.workspace workspaceDocument:self.workspaceDocument windowController:self];

}

@end
