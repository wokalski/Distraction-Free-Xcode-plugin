//
//  IDEEditorContext.h
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 08.03.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "XcodeHeaders.h"

@class IDEEditorContext;

@protocol IDEEditorContextDelegate <NSObject>
@optional
- (void)editorContext:(IDEEditorContext *)context editorStateRepositoryDidChange:(id)arg2;
- (void)removeSplitForEditorContext:(IDEEditorContext *)editorContext;
- (void)addSplitForEditorContext:(IDEEditorContext *)editorContext;
- (id)editorContext:(IDEEditorContext *)editorContext navigableItemForEditingFromArchivedRepresentation:(id)arg2 error:(id *)arg3;
- (id)primaryEditorContext;
- (void)editorContextDidBecomeLastActiveEditor:(IDEEditorContext *)editorContext;
- (BOOL)provideWorkspaceStructureForEmptyEditorContext:(IDEEditorContext *)editorContext;
- (void)_editorContext:(IDEEditorContext *)editorContext openingEmptyEditorInsteadOfNavigableItem:(id)arg2;
- (BOOL)editorContext:(IDEEditorContext *)editorContext emptyEditorRootNavigableItem:(id *)arg2 selectedNavigableItem:(id *)arg3;
- (void)editorContext:(IDEEditorContext *)editorContext didUpdateMenu:(id)arg2;
- (BOOL)canCloseDocumentForEditorContext:(IDEEditorContext *)editorContext;
- (void)editorContext:(IDEEditorContext *)editorContext didSetNavigableItem:(id)arg2;
- (id)editorContext:(IDEEditorContext *)editorContext relatedMenuItemsForNavItem:(id)arg2;
- (IDEWorkspace *)workspaceForEditorContext:(IDEEditorContext *)editorContext;
@end

@interface IDEEditorContext : IDEViewController
@property(retain, nonatomic, readonly) NSURL *originalRequestedDocumentURL;
@property(readonly, nonatomic) IDEEditor *editor;
@property(retain, nonatomic, readonly) IDEEditorArea *editorArea;
@property (retain, nonatomic) IDEFileReferenceNavigableItem *greatestDocumentAncestor;
@property(retain, nonatomic, readonly) IDENavigableItem *navigableItem;
@property (nonatomic, weak) id<IDEEditorContextDelegate> delegate;
- (id)initWithNibName:(id)arg1 bundle:(id)arg2;
- (void)setupNewEditor:(IDEEditor *)editor;
- (BOOL)openEditorOpenSpecifier:(IDEEditorOpenSpecifier *)openSpecifier;
- (BOOL)openEditorHistoryItem:(id)historyItem;
- (void)takeFocus;
// debugging
- (id)_navigableItemForEditingFromArchivedRepresentation:(IDENavigableItemArchivableRepresentation *)representation error:(NSError **)error;
@end