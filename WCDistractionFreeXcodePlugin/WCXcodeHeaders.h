//
//  WCXcodeHeaders.h
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 10.01.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface IDENavigableItem : NSObject
@end

@interface IDEFileNavigableItem : IDENavigableItem
@end

@interface IDEFileReferenceNavigableItem : IDEFileNavigableItem
{
}

@end

@interface DVTTextStorage : NSTextStorage
@property(getter=isSyntaxColoringEnabled) BOOL syntaxColoringEnabled;
@end

@interface DVTCompletingTextView : NSTextView
@end

@interface DVTSourceTextView : DVTCompletingTextView
@end

@interface DVTViewController : NSViewController
@end

@interface IDEWorkspaceTabController : NSViewController
@end

@interface IDEViewController : DVTViewController
@property (nonatomic, strong) IDEWorkspaceTabController *workspaceTabController;
@end

@class IDEEditorContext;
@interface IDEEditorArea : IDEViewController
@property(retain, nonatomic) IDEEditorContext *lastActiveEditorContext;
@end

@interface IDEFileTextSettings : NSObject
@end

@interface IDEEditor : IDEViewController
@property(retain, nonatomic) IDEFileTextSettings *fileTextSettings;
@property(retain, nonatomic) IDEEditorContext *editorContext;
@end

@interface IDEEditorContext : IDEViewController
@property(retain, nonatomic) NSURL *originalRequestedDocumentURL;
@property(readonly, nonatomic) IDEEditor *editor;
@property(retain, nonatomic) IDEEditorArea *editorArea;
@property (retain, nonatomic) IDEFileReferenceNavigableItem *greatestDocumentAncestor;
- (id)initWithNibName:(id)arg1 bundle:(id)arg2;
- (void)setupNewEditor:(IDEEditor *)editor;
@end

@interface IDEEditorDocument : NSDocument
@end

@interface IDESourceCodeDocument : IDEEditorDocument
@end

@interface IDESourceCodeEditor : IDEEditor
@property(readonly) IDESourceCodeDocument *sourceCodeDocument;
@property(retain) DVTSourceTextView *textView;
- (void)jumpToDefinitionWithShiftPlusAlternate:(id)arg1;
- (void)jumpToDefinitionWithAlternate:(id)arg1;
- (void)jumpToDefinition:(id)arg1;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundle document:(IDESourceCodeDocument *)document;
@end

@interface IDEComparisonEditor : IDEEditor
@property(retain) IDEEditorDocument *secondaryDocument;
@property(retain) IDEEditorDocument *primaryDocument;
@end

@interface IDESourceCodeComparisonEditor : IDEComparisonEditor
@property(readonly) DVTSourceTextView *keyTextView;
@end

@interface IDEWorkspaceWindowController : NSWindowController
@property(readonly) IDEEditorArea *editorArea;
@end