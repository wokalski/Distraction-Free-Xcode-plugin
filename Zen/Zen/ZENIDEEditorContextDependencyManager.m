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

- (instancetype)initWithWorkspaceDocument:(IDEWorkspaceDocument *)workspaceDocument editorContext:(IDEEditorContext *)editorContext
{
    self = [super init];
    
    if (self) {
        _workspaceDocument = workspaceDocument;
        _editorContext = editorContext;
    }
    return self;
}

#pragma mark - there's where the super-vulnerable stuff is.

// That's what basically IDEEditorArea's implementation does. In addition it calls IDEEditorModeViewController (yet another reference to parent) which performs the real action but we want ot keep the implementation as simple as possible.
// If you are interested (or something breaks here) check out IDEEditorArea's implementation of this method

- (void)_openEditorOpenSpecifier:(IDEEditorOpenSpecifier *)openSpecifier editorContext:(IDEEditorContext *)editorContext takeFocus:(BOOL)takeFocus
{
    if ([self openSpecifierIsValid:openSpecifier] == NO) {
        [[self cannotOpenFileAlert:openSpecifier] runModal];
        return;
    }
    
    
    if ([editorContext openEditorOpenSpecifier:openSpecifier] && takeFocus) {
        [editorContext takeFocus];
    }
}

- (NSAlert *)cannotOpenFileAlert:(IDEEditorOpenSpecifier *)openSpecifier
{
    NSString *fileType = [[openSpecifier fileDataType] displayName];
    NSString *localizedDescription = [NSString stringWithFormat:@"Cannot open %@.", fileType];
    NSString *failureDescription = @"Files with this type are not supported by ZEN";
    
    return [NSAlert alertWithError:[NSError errorWithDomain:@"ZENErrorDomain" code:1 userInfo:@{
                                                                                                NSLocalizedDescriptionKey : localizedDescription, NSLocalizedRecoverySuggestionErrorKey : failureDescription,
                                                                                                NSLocalizedRecoveryOptionsErrorKey : @[@"OK"]}]];
}

- (BOOL)openSpecifierIsValid:(IDEEditorOpenSpecifier *)openSpecifier
{
    DVTFileDataType *fileType = [openSpecifier fileDataType];
    
    NSString *textIdentifier = @"public.text";
    NSString *sourceIdentifier = @"public.source-code";
    DVTFileDataType *sourceDataType = [DVTFileDataType fileDataTypeWithIdentifier:sourceIdentifier];

    return [fileType conformsToType:sourceDataType];
}

// same story as -_openEditorOpenSpecifier:editorContext:takeFocus
- (void)_openEditorHistoryItem:(id)item editorContext:(IDEEditorContext *)editorContext takeFocus:(BOOL)takeFocus
{
    if ([editorContext openEditorHistoryItem:item] && takeFocus) {
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

- (id)debugSessionController
{
    return nil;
}

// Left Xcode pane. It is not present in our plugin's window. 
- (id)navigatorArea
{
    return nil;
}

- (IDEWorkspace *)workspace
{
    return self.workspaceDocument.workspace;
}

- (BOOL)userWantsBreakpointsActivated
{
    return NO;
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

#pragma mark - Open Quickly

- (id)activeWorkspaceTabController //forwarded from ZENWindowController
{
    return self;
}

- (id)currentDebuggingAdditionUIControllers
{
    return nil;
}

- (id)primaryEditorContext
{
    return self.editorContext;
}

- (BOOL)isKindOfClass:(Class)aClass
{
    return [super isKindOfClass:aClass] || [aClass isSubclassOfClass:[IDEWorkspaceTabController class]];
}

- (id)inspectorArea
{
    return nil;
}

- (id)libraryArea
{
    return nil;
}

#pragma mark - 

- (NSArray *)workspaceTabControllers
{
    return @[self];
}

- (id)lastActiveEditorContext
{
    return self.editorContext;  
}

@end
