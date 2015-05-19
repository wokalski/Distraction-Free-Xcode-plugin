//
//  WCXcodeViewControllers.h
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 08.03.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import "WCXcodeModels.h"
#import "WCXcodeViews.h"

@interface DVTViewController : NSViewController
@end

@interface IDEWorkspaceTabController : NSViewController
@property (nonatomic, strong, readonly) IDEWorkspaceDocument *workspaceDocument;
@end

@interface IDEViewController : DVTViewController
@property (nonatomic, strong) IDEWorkspaceTabController *workspaceTabController;
@end

@class IDEEditorContext;
@interface IDEEditorArea : IDEViewController
@property(retain, nonatomic) IDEEditorContext *lastActiveEditorContext;
@end

@interface IDEEditor : IDEViewController
@property(retain, nonatomic) IDEFileTextSettings *fileTextSettings;
@property(retain, nonatomic) IDEEditorContext *editorContext;
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
- (IDEWorkspaceDocument *)document;
@end

@interface IDEWorkspaceWindow : NSWindow
+ (IDEWorkspaceWindowController *)lastActiveWorkspaceWindowController;
@end