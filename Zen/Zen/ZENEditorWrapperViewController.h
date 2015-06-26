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
#import "ZENIDEEditorContextConfiguration.h"

@interface ZENEditorWrapperViewController : NSViewController <IDEWorkspaceDocumentProvider, IDEEditorContextDelegate>

- (instancetype)initWithEditorContext:(IDEEditorContext *)editorContext workspaceDocument:(IDEWorkspaceDocument *)workspaceDocument;

@property (nonatomic, strong, readonly) IDEWorkspaceDocument *workspaceDocument;
@property (nonatomic, strong, readonly) IDEEditorContext *editorContext;

@end
