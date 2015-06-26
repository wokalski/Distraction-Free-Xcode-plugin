//
//  ZENIDEEditorContextConfiguration.h
//  Zen
//
//  Created by Wojciech Czekalski on 19.06.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XcodeHeaders.h"
#import "IDEEditorContext.h"

@interface ZENIDEEditorContextConfiguration : NSObject

@property (nonatomic, strong, readonly) IDEWorkspace *workspace;
@property (nonatomic, strong, readonly) IDEEditorOpenSpecifier *openSpecifier;
@property (nonatomic, strong, readonly) IDEFileReferenceNavigableItem *greatestDocumentAncestor;
@property (nonatomic, weak, readonly) IDEWorkspaceTabController *tabController;

- (instancetype)initWithIDEWorkspaceTabController:(IDEWorkspaceTabController *)workspaceTabController;

- (IDEWorkspaceTabController *)asWorkspaceTabController;

@end

@interface IDEEditorContext (ZENConfiguration)

- (void)setConfiguration:(ZENIDEEditorContextConfiguration *)config;

@end