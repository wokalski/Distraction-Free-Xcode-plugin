//
//  ZENIDEEditorContextConfiguration.m
//  Zen
//
//  Created by Wojciech Czekalski on 19.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "ZENIDEEditorContextConfiguration.h"

@implementation ZENIDEEditorContextConfiguration

- (instancetype)initWithIDEWorkspaceTabController:(IDEWorkspaceTabController *)workspaceTabController
{
    self = [super init];
    
    if (self) {
        
        IDEEditorContext *editorContext = workspaceTabController.editorArea.lastActiveEditorContext;
        
        _tabController = workspaceTabController;
        _greatestDocumentAncestor = editorContext.greatestDocumentAncestor;
        _workspace = editorContext.workspaceTabController.workspaceDocument.workspace;
        _openSpecifier = [self openSpecifierForFileAtURL:_greatestDocumentAncestor.fileURL];
    }
    return self;
}

- (IDEEditorOpenSpecifier *)openSpecifierForFileAtURL:(NSURL *)url
{
    DVTDocumentLocation *location = [[NSClassFromString(@"DVTDocumentLocation") alloc] initWithDocumentURL:url timestamp:nil];
    
    NSError *error;
    
    IDEEditorOpenSpecifier *openSpecifier = [IDEEditorOpenSpecifier structureEditorOpenSpecifierForDocumentLocation:location inWorkspace:self.workspace error:&error];
    
    if (error) {
        NSLog(@"WCDistractionFreePlugin: Unexpected error:\n%@", error);
    }
    
    return openSpecifier;
}

                          
- (IDEWorkspaceTabController *)asWorkspaceTabController
{
    return (IDEWorkspaceTabController *)self;
}

- (IDEWorkspaceDocument *)workspaceDocument
{
    return self.tabController.workspaceDocument;
}

@end
